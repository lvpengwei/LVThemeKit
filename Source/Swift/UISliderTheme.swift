//
//  UISliderTheme.swift
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/12.
//

import Foundation

public class UISliderTheme: LVThemeObject {
    @objc public dynamic var minimumTrackTintColor: LVThemeColor?
    @objc public dynamic var maximumTrackTintColor: LVThemeColor?
    class override func keyPaths() -> [String] {
        return ["minimumTrackTintColor", "maximumTrackTintColor"]
    }
}
public class UISliderThemeKit: LVThemeKit<UISliderTheme, UISlider> { }
private var sliderTKKey: UInt8 = 0
extension UISlider {
    public var sliderTK: UISliderThemeKit {
        var _sliderTK = objc_getAssociatedObject(self, &sliderTKKey) as? UISliderThemeKit
        if _sliderTK == nil {
            _sliderTK = UISliderThemeKit(with: self)
            objc_setAssociatedObject(self, &sliderTKKey, _sliderTK, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return _sliderTK!
    }
}
