// GenMD5=21bd7d310577a0955140b7062c423584

import Foundation
import ResourceGen
import UIKit
extension _RSObjc {

    /// primary
    /// 16
    /// 正文大小
    @objc public static var font_primary: Fontable { return Fontable(16.0) }

    /// secondary
    /// 14
    /// 次要大小
    @objc public static var font_secondary: Fontable { return Fontable(14.0) }

    /// 主题色
    @objc public static var color_theme: UIColor { return ResourceControl.color(hexString: "#282828") }

    /// ic
    @objc public static var image_ic: UIImage? { return UIImage(named: "images/ic", in: ResourceControl.staticBundle, compatibleWith: nil)}

    /// sub/unvisible
    @objc public static var image_sub_unvisible: UIImage? { return UIImage(named: "images/sub/unvisible", in: ResourceControl.staticBundle, compatibleWith: nil)}

    /// a.json
    @objc public static var file_a_json: Data? { return ResourceControl.staticData(by: "files/a.json") }

    /// b.txt
    @objc public static var file_b_txt: Data? { return ResourceControl.staticData(by: "files/b.txt") }

    /// sub/d.doc
    @objc public static var file_sub_d_doc: Data? { return ResourceControl.staticData(by: "files/sub/d.doc") }

    /// c.xls
    @objc public static var file_c_xls: Data? { return ResourceControl.staticData(by: "files/c.xls") }

}
