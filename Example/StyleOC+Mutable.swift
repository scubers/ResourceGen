// GenMD5=

import Foundation
import ResourceGen
import UIKit
@objc public class RM_OC: NSObject {
  static var rsControl: ResourceControl = ResourceControl(key: "resource")
  /// secondary, 14, 次要大小
  @objc public static var font_secondary: Fontable { return Fontable(rsControl.mFontSize(by: "secondary")) }
  /// primary, 16, 正文大小
  @objc public static var font_primary: Fontable { return Fontable(rsControl.mFontSize(by: "primary")) }
  /// theme, #282828, 主题色
  @objc public static var color_theme: UIColor { return rsControl.mColor(by: "theme") }
  /// ic
  @objc public static var image_ic: UIImage? { return UIImage(named: "images/ic", in: rsControl.mBundle, compatibleWith: nil)}
  /// sub/unvisible
  @objc public static var image_sub_unvisible: UIImage? { return UIImage(named: "images/sub/unvisible", in: rsControl.mBundle, compatibleWith: nil)}
  /// a.json
  @objc public static var file_a_json: Data? { return rsControl.mData(by: "files/a.json") }
  /// b.txt
  @objc public static var file_b_txt: Data? { return rsControl.mData(by: "files/b.txt") }
  /// sub/d.doc
  @objc public static var file_sub_d_doc: Data? { return rsControl.mData(by: "files/sub/d.doc") }
  /// c.xls
  @objc public static var file_c_xls: Data? { return rsControl.mData(by: "files/c.xls") }
  /// a.json
  @objc public static var file_path_a_json: String? { return rsControl.mPath(by: "files/a.json") }
  /// b.txt
  @objc public static var file_path_b_txt: String? { return rsControl.mPath(by: "files/b.txt") }
  /// sub/d.doc
  @objc public static var file_path_sub_d_doc: String? { return rsControl.mPath(by: "files/sub/d.doc") }
  /// c.xls
  @objc public static var file_path_c_xls: String? { return rsControl.mPath(by: "files/c.xls") }
}