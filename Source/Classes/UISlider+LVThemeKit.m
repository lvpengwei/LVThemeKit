//
//  UISlider+LVThemeKit.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//

#import "UISlider+LVThemeKit.h"
#import <objc/runtime.h>

@implementation UISliderTheme
+ (NSArray *)keyPaths {
    return @[@"minimumTrackTintColor", @"maximumTrackTintColor"];
}
@end
@implementation UISliderThemeKit
+ (Class)tClass {
    return [UISliderTheme class];
}
@end
@implementation UISlider (LVThemeKit)
- (UISliderThemeKit *)sliderTK {
    UISliderThemeKit *_sliderTK = objc_getAssociatedObject(self, _cmd);
    if (_sliderTK == nil) {
        _sliderTK = [UISliderThemeKit instanceWithView:self];
        objc_setAssociatedObject(self, _cmd, _sliderTK, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _sliderTK;
}
@end
