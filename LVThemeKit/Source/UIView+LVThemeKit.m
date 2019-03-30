//
//  UIView+LVThemeKit.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "UIView+LVThemeKit.h"
#import "LVThemeColor.h"
#import <objc/runtime.h>
#import "QDThemeManager.h"

@implementation UIViewTheme
+ (NSArray *)keyPaths {
    return @[@"backgroundColor", @"tintColor"];
}
@end
@implementation UIViewThemeKit
+ (Class)tClass {
    return [UIViewTheme class];
}
@end
@implementation UIView (LVThemeKit)
- (UIViewThemeKit *)viewTK {
    UIViewThemeKit *_viewTK = objc_getAssociatedObject(self, _cmd);
    if (_viewTK == nil) {
        _viewTK = [UIViewThemeKit instanceWithView:self];
        objc_setAssociatedObject(self, _cmd, _viewTK, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _viewTK;
}
@end
