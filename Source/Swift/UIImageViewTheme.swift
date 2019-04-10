//
//  UIImageViewTheme.swift
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/12.
//

import Foundation

public class UIImageViewTheme: LVThemeObject {
    @objc public dynamic var image: LVThemeImage?
    class override func keyPaths() -> [String] {
        return ["image"]
    }
}
public class UIImageViewThemeKit: LVThemeKit<UIImageViewTheme, UIImageView> { }
private var imageTKKey: UInt8 = 0
extension UIImageView {
    public var imageTK: UIImageViewThemeKit {
        var _imageTK = objc_getAssociatedObject(self, &imageTKKey) as? UIImageViewThemeKit
        if _imageTK == nil {
            _imageTK = UIImageViewThemeKit(with: self)
            objc_setAssociatedObject(self, &imageTKKey, _imageTK, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return _imageTK!
    }
}
