//
//  CALayer+LVThemeKit.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//

#import "CALayer+LVThemeKit.h"
#import <objc/runtime.h>

@implementation CALayerTheme
+ (NSArray *)keyPaths {
    return @[@"backgroundColor", @"borderColor"];
}
@end
@implementation CALayerThemeKit
+ (Class)tClass {
    return [CALayerTheme class];
}
@end
@implementation CALayer (LVThemeKit)
- (CALayerThemeKit *)layerTK {
    CALayerThemeKit *_layerTK = objc_getAssociatedObject(self, _cmd);
    if (_layerTK == nil) {
        _layerTK = [CALayerThemeKit instanceWithView:self];
        objc_setAssociatedObject(self, _cmd, _layerTK, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _layerTK;
}
@end
