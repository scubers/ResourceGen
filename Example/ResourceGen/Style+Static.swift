// GenMD5=21bd7d310577a0955140b7062c423584

import Foundation
import ResourceGen
import UIKit
extension ResourceControl.Static {

    public class FontSize {

        /// primary
        /// 正文大小
        /// 16
        public static var primary: Fontable { return Fontable(16.0) }

        /// secondary
        /// 次要大小
        /// 14
        public static var secondary: Fontable { return Fontable(14.0) }

    }

    public class Color {

        /// 主题色
        public static var theme: UIColor { return ResourceControl.color(hexString: "#282828") }

    }

    public class Image {

        /// ic
        public static var ic: UIImage? { return UIImage(named: "images/ic", in: ResourceControl.staticBundle, compatibleWith: nil)}

        /// sub/unvisible
        public static var sub_unvisible: UIImage? { return UIImage(named: "images/sub/unvisible", in: ResourceControl.staticBundle, compatibleWith: nil)}

    }

    public class File {

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
