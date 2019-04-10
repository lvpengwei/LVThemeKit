//
//  LVThemeResource.swift
//  Pods-DayNightDemoSwift
//
//  Created by lvpengwei on 2019/4/10.
//

import Foundation

public class LVThemeResource: NSObject {
    public var resValue: NSObject? {
        return self.block()
    }
    private var block: (() -> NSObject?)
    public required init(with block: @escaping (() -> NSObject?)) {
        self.block = block
    }
}

public class LVThemeColor: LVThemeResource { }

public class LVThemeImage: LVThemeResource { }

public class LVThemeAttributedString: LVThemeResource { }

public class LVThemeString: LVThemeResource { }
