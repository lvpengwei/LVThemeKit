//
//  CALayerTheme.swift
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/12.
//

import Foundation

public class CALayerTheme: LVThemeObject {
    @objc public dynamic var backgroundColor: LVThemeColor?
    @objc public dynamic var borderColor: LVThemeColor?
    class override func keyPaths() -> [String] {
        return ["backgroundColor", "borderColor"]
    }
}
public class CALayerThemeKit: LVThemeKit<CALayerTheme, CALayer> { }
private var layerTKKey: UInt8 = 0
extension CALayer {
    public var layerTK: CALayerThemeKit {
        var _layerTK = objc_getAssociatedObject(self, &layerTKKey) as? CALayerThemeKit
        if _layerTK == nil {
            _layerTK = CALayerThemeKit(with: self)
            objc_setAssociatedObject(self, &layerTKKey, _layerTK, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return _layerTK!
    }
}
