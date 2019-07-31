// GenMD5=21bd7d310577a0955140b7062c423584

import Foundation
import ResourceGen
import UIKit
public struct RS {
  static var rsControl: ResourceControl = ResourceControl(key: "resource")
  public struct FontSize {
    /// primary, 16, 正文大小
    public static var primary: Fontable { return Fontable(16.0) }
    /// secondary, 14, 次要大小
    public static var secondary: Fontable { return Fontable(14.0) }
  }
  public struct Color {
    /// theme, #282828, 主题色
    public static var theme: UIColor { return ResourceControl.color(hexString: "#282828") }
  }
  public struct Image {
    /// ic
    public static var ic: UIImage? { return UIImage(named: "images/ic", in: rsControl.sBundle, compatibleWith: nil)}
    /// sub/unvisible
    public static var sub_unvisible: UIImage? { return UIImage(named: "images/sub/unvisible", in: rsControl.sBundle, compatibleWith: nil)}
  }
  public struct File {
    /// a.json
    public static var a_json: Data? { return rsControl.sData(by: "files/a.json") }
    /// b.txt
    public static var b_txt: Data? { return rsControl.sData(by: "files/b.txt") }
    /// sub/d.doc
    public static var sub_d_doc: Data? { return rsControl.sData(by: "files/sub/d.doc") }
    /// c.xls
    public static var c_xls: Data? { return rsControl.sData(by: "files/c.xls") }
  }
  public struct FilePath {
    /// a.json
    public static var a_json: String? { return rsControl.sPath(by: "files/a.json") }
    /// b.txt
    public static var b_txt: String? { return rsControl.sPath(by: "files/b.txt") }
    /// sub/d.doc
    public static var sub_d_doc: String? { return rsControl.sPath(by: "files/sub/d.doc") }
    /// c.xls
    public static var c_xls: String? { return rsControl.sPath(by: "files/c.xls") }
  }
}