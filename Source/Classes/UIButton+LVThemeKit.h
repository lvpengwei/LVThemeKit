//
//  UIButton+LVThemeKit.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVThemeKit.h"

NS_ASSUME_NONNULL_BEGIN

@class LVThemeColor, UIButtonThemeKit, LVThemeString, LVThemeAttributedString, LVThemeImage;
@interface UIButtonTheme : LVThemeObject<UIButtonThemeKit *>
- (void)setTitleColor:(LVThemeColor *  _Nullable)titleColor forState:(UIControlState)state;
- (void)setTitle:(LVThemeString *  _Nullable)title forState:(UIControlState)state;
- (void)setImage:(LVThemeImage * _Nullable)image forState:(UIControlState)state;
- (void)setAttributedTitle:(LVThemeAttributedString * _Nullable)title forState:(UIControlState)state;
@end
@interface UIButtonThemeKit : LVThemeKit<UIButtonTheme *, UIButton *>
@end
@interface UIButton (LVThemeKit)
@property (nonatomic, strong, readonly) UIButtonThemeKit *buttonTK;
@end

NS_ASSUME_NONNULL_END
