//
//  UIImageView+LVThemeKit.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//

#import "UIImageView+LVThemeKit.h"
#import <objc/runtime.h>

@implementation UIImageViewTheme
+ (NSArray *)keyPaths {
    return @[@"image"];
}
@end
@implementation UIImageViewThemeKit
+ (Class)tClass {
    return [UIImageViewTheme class];
}
@end
@implementation UIImageView (LVThemeKit)
- (UIImageViewThemeKit *)imageTK {
    UIImageViewThemeKit *_imageTK = objc_getAssociatedObject(self, _cmd);
    if (_imageTK == nil) {
        _imageTK = [UIImageViewThemeKit instanceWithView:self];
        objc_setAssociatedObject(self, _cmd, _imageTK, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _imageTK;
}
@end
