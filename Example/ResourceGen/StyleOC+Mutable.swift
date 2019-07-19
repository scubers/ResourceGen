// GenMD5=600c76a1f966b80235ceed69feff2a2e

import Foundation
import ResourceGen
import UIKit
@objc public class _RMObjc: NSObject {

    /// primary
    /// 16
    /// 正文大小
    @objc public static var font_primary: Fontable { return Fontable(ResourceControl.mutableFontSize(by: "primary")) }

    /// secondary
    /// 14
    /// 次要大小
    @objc public static var font_secondary: Fontable { return Fontable(ResourceControl.mutableFontSize(by: "secondary")) }

    /// 主题色
    @objc public static var color_theme: UIColor { return ResourceControl.mutableColor(by: "theme") }

    /// 主题色
    @objc public static var color_theme1: UIColor { return ResourceControl.mutableColor(by: "theme1") }

    /// ic
    @objc public static var image_ic: UIImage? { return UIImage(named: "images/ic", in: ResourceControl.mutableBundle, compatibleWith: nil)}

    /// sub/unvisible
    @objc public static var image_sub_unvisible: UIImage? { return UIImage(named: "images/sub/unvisible", in: ResourceControl.mutableBundle, compatibleWith: nil)}

    /// a.json
    @objc public static var file_a_json: Data? { return ResourceControl.mutableData(by: "files/a.json") }

    /// b.txt
    @objc public static var file_b_txt: Data? { return ResourceControl.mutableData(by: "files/b.txt") }

    /// sub/d.doc
    @objc public static var file_sub_d_doc: Data? { return ResourceControl.mutableData(by: "files/sub/d.doc") }

    /// c.xls
    @objc public static var file_c_xls: Data? { return ResourceControl.mutableData(by: "files/c.xls") }

}
