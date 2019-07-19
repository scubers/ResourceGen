// GenMD5=600c76a1f966b80235ceed69feff2a2e

import Foundation
import ResourceGen
import UIKit
public struct _RM {

    public struct FontSize {

        /// primary
        /// 正文大小
        /// 16
        public static var primary: Fontable { return Fontable(ResourceControl.mutableFontSize(by: "primary")) }

        /// secondary
        /// 次要大小
        /// 14
        public static var secondary: Fontable { return Fontable(ResourceControl.mutableFontSize(by: "secondary")) }

    }

    public struct Color {

        /// 主题色
        public static var theme: UIColor { return ResourceControl.mutableColor(by: "theme") }

        /// 主题色
        public static var theme1: UIColor { return ResourceControl.mutableColor(by: "theme1") }

    }

    public struct Image {

        /// ic
        public static var ic: UIImage? { return UIImage(named: "images/ic", in: ResourceControl.mutableBundle, compatibleWith: nil)}

        /// sub/unvisible
        public static var sub_unvisible: UIImage? { return UIImage(named: "images/sub/unvisible", in: ResourceControl.mutableBundle, compatibleWith: nil)}

    }

    public struct File {

        /// a.json
        public static var a_json: Data? { return ResourceControl.mutableData(by: "files/a.json") }

        /// b.txt
        public static var b_txt: Data? { return ResourceControl.mutableData(by: "files/b.txt") }

        /// sub/d.doc
        public static var sub_d_doc: Data? { return ResourceControl.mutableData(by: "files/sub/d.doc") }

        /// c.xls
        public static var c_xls: Data? { return ResourceControl.mutableData(by: "files/c.xls") }

    }

}
