// GenMD5=21bd7d310577a0955140b7062c423584

import Foundation
import ResourceGen
import UIKit
public struct RM {
  static var rsControl: ResourceControl = ResourceControl(key: "resource")
  public struct FontSize {
    /// primary, 16, 正文大小
    public static var primary: Fontable { return Fontable(rsControl.mFontSize(by: "primary")) }
    /// secondary, 14, 次要大小
    public static var secondary: Fontable { return Fontable(rsControl.mFontSize(by: "secondary")) }
  }
  public struct Color {
    /// theme, #282828, 主题色
    public static var theme: UIColor { return rsControl.mColor(by: "theme") }
  }
  public struct Image {
    /// ic
    public static var ic: UIImage? { return UIImage(named: "images/ic", in: rsControl.mBundle, compatibleWith: nil)}
    /// sub/unvisible
    public static var sub_unvisible: UIImage? { return UIImage(named: "images/sub/unvisible", in: rsControl.mBundle, compatibleWith: nil)}
  }
  public struct File {
    /// a.json
    public static var a_json: Data? { return rsControl.mData(by: "files/a.json") }
    /// b.txt
    public static var b_txt: Data? { return rsControl.mData(by: "files/b.txt") }
    /// sub/d.doc
    public static var sub_d_doc: Data? { return rsControl.mData(by: "files/sub/d.doc") }
    /// c.xls
    public static var c_xls: Data? { return rsControl.mData(by: "files/c.xls") }
  }
}