//
//  ResourceControl.swift
//  CodeGen
//
//  Created by Jrwong on 2019/7/17.
//  Copyright © 2019 Jrwong. All rights reserved.
//

import Foundation

public class ResourceControl {
    
    public static var staticBundle: Bundle = Bundle.main
    
    public static var mutableBundle: Bundle = Bundle.main {
        didSet {
            bundleResource = _BundleResources(dir: ResourceControl.mutableBundle.bundlePath)
        }
    }
    static var bundleResource: _BundleResources!
 
    public class Static {}
    public class Mutable {}
    
    public static func color(hexString: String) -> UIColor {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
        
    }
}

public extension ResourceControl {
    public static func mutableFontSize(by key: String) -> CGFloat {
        guard let size = bundleResource.fontSize else { return 0 }
        return CGFloat(Double(size[key]?.value ?? "0") ?? 0)
    }
    public static func mutableColor(by key: String) -> UIColor {
        guard let colors = bundleResource.color, let value = colors[key] else { return .black }
        return color(hexString: value.value)
    }
    public static func staticData(by path: String) -> Data? {
        return data(by: path, from: staticBundle)
    }
    public static func mutableData(by path: String) -> Data? {
        return data(by: path, from: mutableBundle)
    }
    static func data(by path: String, from bundle: Bundle) -> Data? {
        var isDir = ObjCBool(false)
        FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
        if isDir.boolValue {
            return nil
        }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: "\(bundle.bundlePath)/\(path)"))
        } catch {
            print("Resource Gen Error!! [path: \(path)], content error")
            return nil
        }
    }
}

@objc public class Fontable: NSObject {
    public init(_ size: CGFloat) {
        super.init()
        self.size = size
    }
    var size: CGFloat = 0
    @objc public func of(name: String) -> UIFont {
        return UIFont(name: name, size: size)!
    }
    @objc public func system() -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    @objc public func boldSystem() -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
}

enum _ResourceType {
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

struct _BundleResources {
    
    struct Colors: Codable {
        let value: String
        let desc: String
    }
    
    struct FontSize: Codable {
        let value: String
        let desc: String
        func getCGFloat() -> CGFloat {
            return CGFloat((value as NSString).floatValue)
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
    var files: String?
    init(dir: String) {
        let mgr = FileManager.default
        if let data = mgr.contents(atPath: "\(dir)/\(ResourceType.color.fileOrDirName)") {
            color = try! JSONDecoder().decode([String: Colors].self, from: data)
        }
        if let data = mgr.contents(atPath: "\(dir)/\(ResourceType.fontSize.fileOrDirName)") {
            fontSize = try! JSONDecoder().decode([String: FontSize].self, from: data)
        }
        if mgr.fileExists(atPath: "\(dir)/\(ResourceType.image.fileOrDirName)") {
            //            images = "\(di
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
        }
        if mgr.fileExists(atPath: "\(dir)/\(ResourceType.files.fileOrDirName)") {
            files = "\(dir)/\(ResourceType.files.fileOrDirName)"
        }
        
    }
}
