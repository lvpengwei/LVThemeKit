//
//  LVThemeKitExtension.swift
//  DayNightDemo
//
//  Created by lvpengwei on 2019/4/9.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

import Foundation
import LVThemeKit


extension Notification.Name {
    static let dayNightChanged = Notification.Name("day_night_changed")
}
let DAY_NIGHT_FONT = "font"
let DAY_NIGHT_BACKGROUND = "background"
let DAY_NIGHT_BACKGROUNDLIGHT = "backgroundLight"
let DAY_NIGHT_HIGHLIGHT = "highlight"
class DayNightManager {
    fileprivate static let sharedInstance = DayNightManager()
    public class var shared: DayNightManager {
        get {
            return sharedInstance
        }
    }
    var type = DayNightType.day {
        didSet {
            NotificationCenter.default.post(name: .dayNightChanged, object: nil)
        }
    }
    var night: Bool {
        return type == .night
    }
    enum DayNightType: Int {
        case day = 0
        case night
    }
    private var map: [[String: String]]
    init() {
        map = [[DAY_NIGHT_FONT: "#262626FF", DAY_NIGHT_BACKGROUND: "#F6F6F6FF", DAY_NIGHT_BACKGROUNDLIGHT: "#FFFFFFFF", DAY_NIGHT_HIGHLIGHT: "#ED424BFF"],
               [DAY_NIGHT_FONT: "#CCCCCCFF", DAY_NIGHT_BACKGROUND: "#1A1A1AFF", DAY_NIGHT_BACKGROUNDLIGHT: "#262626FF", DAY_NIGHT_HIGHLIGHT: "#3D5CB8FF"]]
    }
    func color(with key: String) -> UIColor? {
        guard let hex = map[type.rawValue][key] else { return nil }
        return UIColor(hex: hex)
    }
    func image() -> UIImage? {
        return !night ? UIImage(named: "24_rijian") : UIImage(named: "24_yejian")
    }
    class func change() {
        shared.type = shared.night ? .day : .night
    }
    class func config() {
        let conf = LVThemeKitConfig()
        conf.generators = [DayNightObserver.self]
        LVThemeKit<AnyObject, AnyObject>.config = conf
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

extension LVThemeString {
    class var dayNightString: LVThemeString {
        return LVThemeString.instance({ () -> NSString in
            return DayNightManager.shared.night ? "黑夜" : "白天"
        })
    }
}

extension LVThemeColor {
    class var font: LVThemeColor {
        return LVThemeColor.instance({ () -> UIColor? in
            return DayNightManager.shared.color(with: DAY_NIGHT_FONT)
        })
    }
    class var background: LVThemeColor {
        return LVThemeColor.instance({ () -> UIColor? in
            return DayNightManager.shared.color(with: DAY_NIGHT_BACKGROUND)
        })
    }
    class var backgroundLight: LVThemeColor {
        return LVThemeColor.instance({ () -> UIColor? in
            return DayNightManager.shared.color(with: DAY_NIGHT_BACKGROUNDLIGHT)
        })
    }
    class var highlight: LVThemeColor {
        return LVThemeColor.instance({ () -> UIColor? in
            return DayNightManager.shared.color(with: DAY_NIGHT_HIGHLIGHT)
        })
    }
}

extension LVThemeImage {
    class var dayNightImage: LVThemeImage {
        return LVThemeImage.instance({ () -> UIImage? in
            return DayNightManager.shared.image()
        })
    }
}

class DayNightObserver: NSObject, LVThemeKitObserverGenerator {
    var observer: Any?
    func lvThemeKitObserverGeneratorCompletion(_ completion: @escaping LVThemeKitCompletion) {
        observer = NotificationCenter.default.addObserver(forName: .dayNightChanged, object: nil, queue: OperationQueue.main) { (_) in
            completion()
        }
    }
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
