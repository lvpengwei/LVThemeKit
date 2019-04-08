//
//  CAShapeLayer+LVThemeKit.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//

#import "CAShapeLayer+LVThemeKit.h"
#import <objc/runtime.h>

@implementation CAShapeLayerTheme
+ (NSArray *)keyPaths {
    return @[@"fillColor"];
}
@end
@implementation CAShapeLayerThemeKit
+ (Class)tClass {
    return [CAShapeLayerTheme class];
}
@end
@implementation CAShapeLayer (LVThemeKit)
- (CAShapeLayerThemeKit *)shapeTK {
    CAShapeLayerThemeKit *_viewTK = objc_getAssociatedObject(self, _cmd);
    if (_viewTK == nil) {
        _viewTK = [CAShapeLayerThemeKit instanceWithView:self];
        objc_setAssociatedObject(self, _cmd, _viewTK, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _viewTK;
}
@end
