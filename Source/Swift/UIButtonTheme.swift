//
//  UIButtonTheme.swift
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/12.
//

import Foundation

private let TITLE = "title".undefined
private let TITLECOLOR = "titleColor".undefined
private let IMAGE = "image".undefined
private let ATTRIBUTEDTITLE = "attributedTitle".undefined
public class UIButtonTheme: LVThemeObject {
    private(set) var titleDict: [UInt: LVThemeString] = [:]
    private(set) var titleColorDict: [UInt: LVThemeColor] = [:]
    private(set) var imageDict: [UInt: LVThemeImage] = [:]
    private(set) var attributedTitleDict: [UInt: LVThemeAttributedString] = [:]
    public func setTitle(_ title: LVThemeString?, for state: UIControl.State) {
        titleDict[state.rawValue] = title
        tk.themeObject(self, property: TITLE, changed: title)
    }
    public func setTitleColor(_ color: LVThemeColor?, for state: UIControl.State) {
        titleColorDict[state.rawValue] = color
        tk.themeObject(self, property: TITLECOLOR, changed: color)
    }
    public func setImage(_ image: LVThemeImage?, for state: UIControl.State) {
        imageDict[state.rawValue] = image
        tk.themeObject(self, property: IMAGE, changed: image)
    }
    public func setAttributedTitle(_ title: LVThemeAttributedString?, for state: UIControl.State) {
        attributedTitleDict[state.rawValue] = title
        tk.themeObject(self, property: ATTRIBUTEDTITLE, changed: title)
    }
    class override func keyPaths() -> [String] {
        return [TITLE, TITLECOLOR, IMAGE, ATTRIBUTEDTITLE]
    }
    override func hasValue(for key: String) -> Bool {
        switch key {
        case TITLE:
            return !titleDict.isEmpty
        case TITLECOLOR:
            return !titleColorDict.isEmpty
        case IMAGE:
            return !imageDict.isEmpty
        case ATTRIBUTEDTITLE:
            return !attributedTitleDict.isEmpty
        default:
            return false
        }
    }
}
public class UIButtonThemeKit: LVThemeKit<UIButtonTheme, UIButton> {
    override func apply(object: UIButtonTheme, key: String) {
        switch key {
        case TITLE:
            object.titleDict.forEach({
                guard let title = $1.resValue as? String else { return }
                view.setTitle(title, for: UIControl.State(rawValue: $0))
            })
        case TITLECOLOR:
            object.titleColorDict.forEach({
                guard let color = $1.resValue as? UIColor else { return }
                view.setTitleColor(color, for: UIControl.State(rawValue: $0))
            })
        case IMAGE:
            object.imageDict.forEach({
                guard let image = $1.resValue as? UIImage else { return }
                view.setImage(image, for: UIControl.State(rawValue: $0))
            })
        case ATTRIBUTEDTITLE:
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
