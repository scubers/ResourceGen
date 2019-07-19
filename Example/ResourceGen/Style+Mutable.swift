// GenMD5=21bd7d310577a0955140b7062c423584

import Foundation
import ResourceGen
import UIKit
extension ResourceControl.Mutable {

    public class FontSize {

        /// secondary
        /// 次要大小
        /// 14
        public static var secondary: Fontable { return Fontable(ResourceControl.mutableFontSize(by: "secondary")) }

        /// primary
        /// 正文大小
        /// 16
        public static var primary: Fontable { return Fontable(ResourceControl.mutableFontSize(by: "primary")) }

    }

    public class Color {

        /// 主题色
        public static var theme: UIColor { return ResourceControl.mutableColor(by: "theme") }

    }

    public class Image {

        /// ic
        public static var ic: UIImage? { return UIImage(named: "images/ic", in: ResourceControl.mutableBundle, compatibleWith: nil)}

        /// sub/unvisible
        public static var sub_unvisible: UIImage? { return UIImage(named: "images/sub/unvisible", in: ResourceControl.mutableBundle, compatibleWith: nil)}

    }

    public class File {

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
