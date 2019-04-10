//
//  UIButtonTheme.swift
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/12.
//

import Foundation

public class UIButtonTheme: LVThemeObject {
    private(set) var titleDict: [UInt: LVThemeString] = [:]
    private(set) var titleColorDict: [UInt: LVThemeColor] = [:]
    private(set) var imageDict: [UInt: LVThemeImage] = [:]
    private(set) var attributedTitleDict: [UInt: LVThemeAttributedString] = [:]
    public func setTitle(_ title: LVThemeString?, for state: UIControl.State) {
        titleDict[state.rawValue] = title
        tk.themeObject(self, property: "title", changed: title)
    }
    public func setTitleColor(_ color: LVThemeColor?, for state: UIControl.State) {
        titleColorDict[state.rawValue] = color
        tk.themeObject(self, property: "titleColor", changed: color)
    }
    public func setImage(_ image: LVThemeImage?, for state: UIControl.State) {
        imageDict[state.rawValue] = image
        tk.themeObject(self, property: "image", changed: image)
    }
    public func setAttributedTitle(_ title: LVThemeAttributedString?, for state: UIControl.State) {
        attributedTitleDict[state.rawValue] = title
        tk.themeObject(self, property: "attributedTitle", changed: title)
    }
    class override func keyPaths() -> [String] {
        return ["title", "titleColor", "image", "attributedTitle"]
    }
    override func addObservers() { }
    override func hasValue(for key: String) -> Bool {
        switch key {
        case "title":
            return !titleDict.isEmpty
        case "titleColor":
            return !titleColorDict.isEmpty
        case "image":
            return !imageDict.isEmpty
        case "attributedTitle":
            return !attributedTitleDict.isEmpty
        default:
            return false
        }
    }
}
public class UIButtonThemeKit: LVThemeKit<UIButtonTheme, UIButton> {
    override func apply(object: UIButtonTheme, key: String) {
        switch key {
        case "title":
            object.titleDict.forEach({
                guard let title = $1.resValue as? String else { return }
                view.setTitle(title, for: UIControl.State(rawValue: $0))
            })
        case "titleColor":
            object.titleColorDict.forEach({
                guard let color = $1.resValue as? UIColor else { return }
                view.setTitleColor(color, for: UIControl.State(rawValue: $0))
            })
        case "image":
            object.imageDict.forEach({
                guard let image = $1.resValue as? UIImage else { return }
                view.setImage(image, for: UIControl.State(rawValue: $0))
            })
        case "attributedTitle":
            object.attributedTitleDict.forEach({
                guard let title = $1.resValue as? NSAttributedString else { return }
                view.setAttributedTitle(title, for: UIControl.State(rawValue: $0))
            })
        default:
            break
        }
    }
}
private var buttonTKKey: UInt8 = 0
extension UIButton {
    public var buttonTK: UIButtonThemeKit {
        var _buttonTK = objc_getAssociatedObject(self, &buttonTKKey) as? UIButtonThemeKit
        if _buttonTK == nil {
            _buttonTK = UIButtonThemeKit(with: self)
            objc_setAssociatedObject(self, &buttonTKKey, _buttonTK, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return _buttonTK!
    }
}
