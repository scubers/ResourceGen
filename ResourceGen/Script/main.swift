//  main.swift
//  CodeGen
//
//  Created by Jrwong on 2019/7/15.
//  Copyright © 2019 Jrwong. All rights reserved.
//

import Foundation
import CommonCrypto

protocol CodeFormatable {
    func getCode(by level: Int) -> String
}

struct Indent {
    let level: Int
    func getIndent() -> String {
        return Array(repeating: " ", count: level * 2).joined(separator: "")
    }
}

struct Var: CodeFormatable {
    
    var comment: [String]
    var modifiers: [String]
    var name: String
    var type: String
    var valueContent: String
    
    func getCode(by level: Int) -> String {
        let prefix = Indent(level: level).getIndent()
        
        var code = "\n"
        
        comment.forEach { (c) in
            code += "\(prefix)/// \(c)\n"
        }
        code += "\(prefix)\(modifiers.joined(separator: " ")) \(name): \(type) \(valueContent)"
        
        return code
    }
}

struct NameSpace: CodeFormatable {
    var imports: [String]
    var modifiers: [String]
    var name: String
    var vars = [Var]()
    var nameSpaces = [NameSpace]()
    
    func getCode(by level: Int) -> String {
        let prefix = Indent(level: level).getIndent()
        var code = "\n"
        imports.forEach { i in
            code += "\(i)\n"
        }
        code += "\(prefix)\(modifiers.joined(separator: " ")) \(name) {"
        vars.forEach { (v) in
            code += v.getCode(by: level + 1)
        }
        nameSpaces.forEach { (n) in
            code += n.getCode(by: level + 1)
        }
        code += "\n\(prefix)}"
        return code
    }
}


enum StyleType: String {
    case `static`
    case mutable
}

enum ResourceType {
    case color, fontSize, image, files
    var fileOrDirName: String {
        switch self {
        case .color: return "color.json"
        case .fontSize: return "fontSize.json"
        case .image: return "images"
        case .files: return "files"
        }
    }
}

extension String {
    var style_gen_name: String {
        return
            self
                .replacingOccurrences(of: " ", with: "_")
                .replacingOccurrences(of: "/", with: "_")
                .replacingOccurrences(of: "+", with: "_")
                .replacingOccurrences(of: ".", with: "_")
    }
    func getMD5() -> String {
        let str = cString(using: .utf8)
        
        let strLen = CUnsignedInt(lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return String(format: hash as String)
    }
}

struct BundleResources {
    
    struct Colors: Codable {
        let value: String
        let desc: String
    }
    
    struct FontSize: Codable {
        let value: String
        let desc: String
        func getDouble() -> Double {
            return Double(value) ?? 0
        }
    }
    
    struct Image {
        let name: String
    }
    
    struct File {
        let path: String
    }
    
    var color: [String: Colors]?
    var fontSize: [String: FontSize]?
    var images: [String]?
    var files: [String]?
    private(set) var md5: String
    init(dir: String) {
        let mgr = FileManager.default
        var md5 = ""
        if let data = mgr.contents(atPath: "\(dir)/\(ResourceType.color.fileOrDirName)") {
            color = try! JSONDecoder().decode([String: Colors].self, from: data)
            if let colorMD5 = String(data: data, encoding: .utf8)?.getMD5() {
                md5 += colorMD5
            }
        }
        if let data = mgr.contents(atPath: "\(dir)/\(ResourceType.fontSize.fileOrDirName)") {
            fontSize = try! JSONDecoder().decode([String: FontSize].self, from: data)
            if let fontMD5 = String(data: data, encoding: .utf8)?.getMD5() {
                md5 += fontMD5
            }
        }
        if mgr.fileExists(atPath: "\(dir)/\(ResourceType.image.fileOrDirName)") {
            var subs = mgr.subpaths(atPath: "\(dir)/\(ResourceType.image.fileOrDirName)") ?? []
            var set = [String]()
            subs =
                subs
                    .filter { $0.hasSuffix(".png") }
                    .map {
                        $0
                            .replacingOccurrences(of: "@2x.png", with: "")
                            .replacingOccurrences(of: "@3x.png", with: "")
                            .replacingOccurrences(of: ".png", with: "")
                    }
                    .filter {
                        if set.contains($0) {
                            return false
                        }
                        set.append($0)
                        return true
            }
            images = subs
            
            md5 += subs.joined(separator: "").getMD5()
        }
        if mgr.fileExists(atPath: "\(dir)/\(ResourceType.files.fileOrDirName)") {
            files = mgr.subpaths(atPath: "\(dir)/\(ResourceType.files.fileOrDirName)")?.filter({ (path) -> Bool in
                var flag = ObjCBool(false)
                mgr.fileExists(atPath: "\(dir)/\(ResourceType.files.fileOrDirName)/\(path)", isDirectory: &flag)
                return !flag.boolValue
            })
            if let files = files, files.count > 0 {
                md5 += files.joined(separator: "").getMD5()
            }
        }
        
        self.md5 = md5.getMD5()
    }
}

extension BundleResources {
    
    func getCode(type: StyleType) -> String {
        let name = type == .static ? "RS" : "RM"
        var style = NameSpace(imports: ["import Foundation", "import ResourceGen", "import UIKit"],
                              modifiers: ["public struct"],
                              name: name,
            vars: [],
            nameSpaces: [])
        if let code = getSizeCode(type) {
            style.nameSpaces.append(code)
        }
        if let code = getColorCode(type) {
            style.nameSpaces.append(code)
        }
        if let code = getImageCode(type) {
            style.nameSpaces.append(code)
        }
        if let code = getFileCode(type) {
            style.nameSpaces.append(code)
        }
        
        return style.getCode(by: 0)
    }
    
    func getSizeCode(_ type: StyleType) -> NameSpace? {
        guard let sizes = fontSize else { return nil }
        var sizeSpace = NameSpace(imports: [],
                                  modifiers: ["public", "struct"],
                                  name: "FontSize", vars: [], nameSpaces: [])
        sizes.forEach { (key, value) in
            var valueContent: String
            if type == .static {
                valueContent = "{ return Fontable(\(value.getDouble())) }"
            } else {
                valueContent = "{ return Fontable(ResourceControl.mutableFontSize(by: \"\(key)\")) }"
            }
            let fontV = Var(comment: [key, value.desc, value.value], modifiers: ["public", "static", "var"], name: key, type: "Fontable", valueContent: valueContent)
            sizeSpace.vars.append(fontV)
        }
        return sizeSpace
    }
    
    func getColorCode(_ type: StyleType) -> NameSpace? {
        guard let colors = color else { return nil }
        var colorSpace = NameSpace(imports: [],
                                   modifiers: ["public", "struct"],
                                   name: "Color", vars: [], nameSpaces: [])
        colors.forEach { (key, value) in
            var valueContent: String
            if type == .static {
                valueContent = "{ return ResourceControl.color(hexString: \"\(value.value)\") }"
            } else {
                valueContent = "{ return ResourceControl.mutableColor(by: \"\(key)\") }"
            }
            let colorV = Var(comment: [value.desc], modifiers: ["public", "static", "var"], name: key, type: "UIColor", valueContent: valueContent)
            colorSpace.vars.append(colorV)
        }
        return colorSpace
    }
    
    func getImageCode(_ type: StyleType) -> NameSpace? {
        guard let images = images else { return nil }
        var imageSpace = NameSpace(imports: [],
                                   modifiers: ["public", "struct"],
                                   name: "Image", vars: [], nameSpaces: [])
        images.forEach { (i) in
            var valueContent: String
            if type == .static {
                valueContent = "{ return UIImage(named: \"images/\(i)\", in: ResourceControl.staticBundle, compatibleWith: nil)}"
            } else {
                valueContent = "{ return UIImage(named: \"images/\(i)\", in: ResourceControl.mutableBundle, compatibleWith: nil)}"
            }
            let imageV = Var(comment: [i], modifiers: ["public", "static", "var"], name: i.style_gen_name, type: "UIImage?", valueContent: valueContent)
            imageSpace.vars.append(imageV)
        }
        return imageSpace
    }
    
    func getFileCode(_ type: StyleType) -> NameSpace? {
        guard let files = files else { return nil }
        var imageSpace = NameSpace(imports: [],
                                   modifiers: ["public", "struct"],
                                   name: "File", vars: [], nameSpaces: [])
        files.forEach { (i) in
            var valueContent: String
            if type == .static {
                valueContent = "{ return ResourceControl.staticData(by: \"files/\(i)\") }"
            } else {
                valueContent = "{ return ResourceControl.mutableData(by: \"files/\(i)\") }"
            }
            let imageV = Var(comment: [i], modifiers: ["public", "static", "var"], name: i.style_gen_name, type: "Data?", valueContent: valueContent)
            imageSpace.vars.append(imageV)
        }
        return imageSpace
    }
    
}

extension BundleResources {
    func getOCCode(type: StyleType) -> String {
        let name = type == .static ? "RSObjc" : "RMObjc"
        var style = NameSpace(imports: ["import Foundation", "import ResourceGen", "import UIKit"],
                              modifiers: ["@objc public class"],
                              name: "\(name): NSObject",
            vars: [],
            nameSpaces: [])
        
        style.vars.append(contentsOf: getOCSize(type))
        style.vars.append(contentsOf: getOCColor(type))
        style.vars.append(contentsOf: getOCImageCode(type))
        style.vars.append(contentsOf: getOCFileCode(type))
        
        return style.getCode(by: 0)
    }
    
    func getOCSize(_ type: StyleType) -> [Var] {
        guard let sizes = fontSize else { return [] }
        return
            sizes.map({ (key, value) -> Var in
                var valueContent: String
                if type == .static {
                    valueContent = "{ return Fontable(\(value.getDouble())) }"
                } else {
                    valueContent = "{ return Fontable(ResourceControl.mutableFontSize(by: \"\(key)\")) }"
                }
                return Var(comment: [key, value.value, value.desc], modifiers: ["@objc", "public", "static", "var"], name: "font_\(key.style_gen_name)", type: "Fontable", valueContent: valueContent)
            })
    }
    
    func getOCColor(_ type: StyleType) -> [Var] {
        guard let colors = color else { return [] }
        return
            colors.map { (key, value) -> Var in
                var valueContent: String
                if type == .static {
                    valueContent = "{ return ResourceControl.color(hexString: \"\(value.value)\") }"
                } else {
                    valueContent = "{ return ResourceControl.mutableColor(by: \"\(key)\") }"
                }
                return Var(comment: [value.desc], modifiers: ["@objc", "public", "static", "var"], name: "color_\(key.style_gen_name)", type: "UIColor", valueContent: valueContent)
        }
    }
    
    func getOCImageCode(_ type: StyleType) -> [Var] {
        guard let images = images else { return [] }
        return
            images.map { (i) -> Var in
                var valueContent: String
                if type == .static {
                    valueContent = "{ return UIImage(named: \"images/\(i)\", in: ResourceControl.staticBundle, compatibleWith: nil)}"
                } else {
                    valueContent = "{ return UIImage(named: \"images/\(i)\", in: ResourceControl.mutableBundle, compatibleWith: nil)}"
                }
                return Var(comment: [i], modifiers: ["@objc", "public", "static", "var"], name: "image_\(i.style_gen_name)", type: "UIImage?", valueContent: valueContent)
            }
    }
    
    func getOCFileCode(_ type: StyleType) -> [Var] {
        guard let files = files else { return [] }
        
        return
            files.map { (i) -> Var in
            var valueContent: String
            if type == .static {
                valueContent = "{ return ResourceControl.staticData(by: \"files/\(i)\") }"
            } else {
                valueContent = "{ return ResourceControl.mutableData(by: \"files/\(i)\") }"
            }

            return Var(comment: [i], modifiers: ["@objc", "public", "static", "var"], name: "file_\(i.style_gen_name)", type: "Data?", valueContent: valueContent)
        }
    }
}


/// typeof --arg1=xx --arg2=yy
fileprivate class CommandLineArgsFetcher {
    var origins = [String]()
    init(args: [String]) {
        self.origins = args
    }
    func get(_ key: String) -> String? {
        for arg in origins {
            let fix = "--\(key)="
            if arg.hasPrefix(fix) {
                return arg.replacingOccurrences(of: fix, with: "")
            }
        }
        return nil
    }
    func conatain(_ key: String) -> Bool {
        for arg in origins {
            let fix = "--\(key)"
            if arg.hasPrefix(fix) {
                return true
            }
        }
        return false
    }
}


fileprivate let params = CommandLineArgsFetcher(args: CommandLine.arguments)

if params.conatain("help") {
    print("""
输入参数：
    --dir=/xx/yy/zz: 需要扫描的bundle路径
    --output=/xx/yy/zz: 导出文件
    --type=[static,mutable]: 导出的资源文件类型
    --objc: 是否导出objc类型
""")
    exit(0)
}

guard let dir = params.get("dir") else {
    print("请输入 --dir=/xx/yy/zz")
    exit(-1)
}
guard let output = params.get("output") else {
    print("请输入 --output=/xx/yy/zz")
    exit(-1)
}

let type = StyleType(rawValue: params.get("type") ?? "") ?? .static
let isObjc = params.conatain("objc")

var code: String = ""
let res = BundleResources(dir: dir)


let exists = FileManager.default.fileExists(atPath: output)
let md5 = res.md5

if exists {
    // 判断是否需要重写
    let data = try! Data(contentsOf: URL(fileURLWithPath: output))
    let content = String(data: data, encoding: .utf8) ?? ""
    if content.contains(md5) {
        // 相同，则不写入
        exit(0)
    }
}

if isObjc {
    code = res.getOCCode(type: type)
} else {
    code = res.getCode(type: type)
}
code = "// GenMD5=\(md5)\n" + code

try! code.write(to: URL(fileURLWithPath: output), atomically: true, encoding: .utf8)
