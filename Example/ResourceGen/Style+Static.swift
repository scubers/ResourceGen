// GenMD5=600c76a1f966b80235ceed69feff2a2e

import Foundation
import ResourceGen
import UIKit
public struct _RS {

    public struct FontSize {

        /// primary
        /// 正文大小
        /// 16
        public static var primary: Fontable { return Fontable(16.0) }

        /// secondary
        /// 次要大小
        /// 14
        public static var secondary: Fontable { return Fontable(14.0) }

    }

    public struct Color {

        /// 主题色
        public static var theme: UIColor { return ResourceControl.color(hexString: "#282828") }

        /// 主题色
        public static var theme1: UIColor { return ResourceControl.color(hexString: "#282828") }

    }

    public struct Image {

        /// ic
        public static var ic: UIImage? { return UIImage(named: "images/ic", in: ResourceControl.staticBundle, compatibleWith: nil)}

        /// sub/unvisible
        public static var sub_unvisible: UIImage? { return UIImage(named: "images/sub/unvisible", in: ResourceControl.staticBundle, compatibleWith: nil)}

    }

    public struct File {

        /// a.json
        public static var a_json: Data? { return ResourceControl.staticData(by: "files/a.json") }

        /// b.txt
        public static var b_txt: Data? { return ResourceControl.staticData(by: "files/b.txt") }

        /// sub/d.doc
        public static var sub_d_doc: Data? { return ResourceControl.staticData(by: "files/sub/d.doc") }

        /// c.xls
        public static var c_xls: Data? { return ResourceControl.staticData(by: "files/c.xls") }

    }

}
