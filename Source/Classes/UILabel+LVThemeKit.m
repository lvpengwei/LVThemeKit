//
//  UILabel+LVThemeKit.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "UILabel+LVThemeKit.h"
#import <objc/runtime.h>

@implementation UILabelTheme
+ (NSArray *)keyPaths {
    return @[@"textColor", @"attributedText"];
}
@end
@implementation UILabelThemeKit
+ (Class)tClass {
    return [UILabelTheme class];
}
@end
@implementation UILabel (LVThemeKit)
- (UILabelThemeKit *)labelTK {
    UILabelThemeKit *_viewTK = objc_getAssociatedObject(self, _cmd);
    if (_viewTK == nil) {
        _viewTK = [UILabelThemeKit instanceWithView:self];
        objc_setAssociatedObject(self, _cmd, _viewTK, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _viewTK;
}
@end
