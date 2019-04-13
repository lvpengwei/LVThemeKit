//
//  UISlider+LVThemeKit.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//

#import <UIKit/UIKit.h>
#import "LVThemeKit.h"

NS_ASSUME_NONNULL_BEGIN

@class LVThemeColor;
@interface UISliderTheme : LVThemeObject
@property (nonatomic, strong) LVThemeColor * _Nullable minimumTrackTintColor;
@property (nonatomic, strong) LVThemeColor * _Nullable maximumTrackTintColor;
@end
@interface UISliderThemeKit : LVThemeKit<UISliderTheme *, UISlider *>
@end
@interface UISlider (LVThemeKit)
@property (nonatomic, strong, readonly) UISliderThemeKit *sliderTK;
@end

NS_ASSUME_NONNULL_END
