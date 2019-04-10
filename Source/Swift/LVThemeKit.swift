//
//  LVThemeKit.swift
//  Pods-DayNightDemoSwift
//
//  Created by lvpengwei on 2019/4/10.
//

import Foundation

protocol LVThemeObjectProtocol: class {
    func themeObject(_ obj: LVThemeObject, property: String, changed value: LVThemeResource?)
}
public class LVThemeObject: NSObject {
    private(set) weak var tk: LVThemeObjectProtocol!
    required init(with tk: LVThemeObjectProtocol) {
        super.init()
        self.tk = tk
        addObservers()
    }
    func hasValue(for key: String) -> Bool {
        return value(forKey: key) != nil
    }
    class func keyPaths() -> [String] {
        return []
    }
    func addObservers() {
        type(of: self).keyPaths().forEach({ addObserver(for: $0) })
    }
    private func addObserver(for keyPath: String) {
        addObserver(self, forKeyPath: keyPath, options: .new, context: nil)
    }
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath, let value = value(forKey: keyPath) as? LVThemeResource else { return }
        tk.themeObject(self, property: keyPath, changed: value)
    }
    deinit {
        type(of: self).keyPaths().forEach({ removeObserver(self, forKeyPath: $0) })
    }
}

public protocol LVThemeKitObserverGenerator: class {
    init()
    func lvThemeKitObserverGenerator(completion: @escaping () -> Void)
}

public class LVThemeKitConfig {
    public static var config: LVThemeKitConfig?
    public var generators: [LVThemeKitObserverGenerator.Type] = []
    public var applyProperty: ((LVThemeKit<LVThemeObject, NSObject>, String, (LVThemeObject) -> Void) -> Void)?
    public init() { }
}
public class LVThemeKit<T: LVThemeObject, V: NSObject>: LVThemeObjectProtocol {
    private(set) weak var view: V!
    public private(set) var themes: [T]
    public var theme: T { return themes[0] }
    private var observers: [Int: LVThemeKitObserverGenerator] = [:]
    init(with view: V) {
        self.view = view
        assert(LVThemeKitConfig.config != nil, "LVThemeKit.config 不能为空")
        let conf = LVThemeKitConfig.config!
        assert(!conf.generators.isEmpty, "LVThemeKit.config.generators 不能为空")
        self.themes = []
        conf.generators.forEach({ _ in
            self.themes.append(T(with: self))
        })
    }
    func themeObject(_ obj: LVThemeObject, property: String, changed value: LVThemeResource?) {
        setup(themeObject: obj, property: property, changed: value)
        apply(property: property)
    }
    private func setup(themeObject: LVThemeObject, property: String, changed value: LVThemeResource?) {
        guard let index = themes.firstIndex(where: { $0 === themeObject }) else { return }
        guard observers[index] == nil else { return }
        let clz = LVThemeKitConfig.config!.generators[index]
        let generator = clz.init()
        generator.lvThemeKitObserverGenerator { [weak self] in
            guard let this = self else { return }
            this.apply()
        }
        observers[index] = generator
    }
    private func apply(property key: String) {
        if let applyProperty = LVThemeKitConfig.config?.applyProperty, let s = self as? LVThemeKit<LVThemeObject, NSObject> {
            applyProperty(s, key, { [weak self] (theme) in
                guard let this = self else { return }
                guard let t = theme as? T else { return }
                this.apply(object: t, key: key)
            })
            return
        }
        for t in themes {
            if t.hasValue(for: key) {
                apply(object: t, key: key)
                break
            }
        }
    }
    func apply(object: T, key: String) {
        guard let v = object.value(forKey: key) as? LVThemeResource else { return }
        if view is CALayer {
            if let resValue = v.resValue as? UIColor {
                view.setValue(resValue.cgColor, forKey: key)
            }
        } else {
            view.setValue(v.resValue, forKey: key)
        }
    }
    private func apply() {
        T.keyPaths().forEach({ apply(property: $0) })
    }
}
