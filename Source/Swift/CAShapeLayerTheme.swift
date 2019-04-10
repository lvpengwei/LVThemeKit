//
//  CAShapeLayerTheme.swift
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/12.
//

import Foundation

public class CAShapeLayerTheme: LVThemeObject {
    @objc public dynamic var fillColor: LVThemeColor?
    class override func keyPaths() -> [String] {
        return ["fillColor"]
    }
}
public class CAShapeLayerThemeKit: LVThemeKit<CAShapeLayerTheme, CAShapeLayer> { }
private var shapeTKKey: UInt8 = 0
extension CAShapeLayer {
    public var shapeTK: CAShapeLayerThemeKit {
        var _shapeTK = objc_getAssociatedObject(self, &shapeTKKey) as? CAShapeLayerThemeKit
        if _shapeTK == nil {
            _shapeTK = CAShapeLayerThemeKit(with: self)
            objc_setAssociatedObject(self, &shapeTKKey, _shapeTK, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return _shapeTK!
    }
}
