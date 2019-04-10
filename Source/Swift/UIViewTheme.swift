//
//  UIViewTheme.swift
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/10.
//

import Foundation

public class UIViewTheme: LVThemeObject {
    @objc public dynamic var backgroundColor: LVThemeColor?
    class override func keyPaths() -> [String] {
        return ["backgroundColor"]
    }
}
public class UIViewThemeKit: LVThemeKit<UIViewTheme, UIView> { }
private var viewTKKey: UInt8 = 0
extension UIView {
    public var viewTK: UIViewThemeKit {
        var _viewTK = objc_getAssociatedObject(self, &viewTKKey) as? UIViewThemeKit
        if _viewTK == nil {
            _viewTK = UIViewThemeKit(with: self)
            objc_setAssociatedObject(self, &viewTKKey, _viewTK, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return _viewTK!
    }
}
