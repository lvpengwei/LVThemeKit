//
//  UILabelTheme.swift
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/12.
//

import Foundation

public class UILabelTheme: LVThemeObject {
    @objc public dynamic var textColor: LVThemeColor?
    @objc public dynamic var attributedText: LVThemeAttributedString?
    class override func keyPaths() -> [String] {
        return ["textColor", "attributedText"]
    }
}
public class UILabelThemeKit: LVThemeKit<UILabelTheme, UILabel> { }
private var labelTKKey: UInt8 = 0
extension UILabel {
    public var labelTK: UILabelThemeKit {
        var _labelTK = objc_getAssociatedObject(self, &labelTKKey) as? UILabelThemeKit
        if _labelTK == nil {
            _labelTK = UILabelThemeKit(with: self)
            objc_setAssociatedObject(self, &labelTKKey, _labelTK, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return _labelTK!
    }
}
