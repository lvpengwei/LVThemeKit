//
//  UIView+LVThemeKit.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVThemeKit.h"

NS_ASSUME_NONNULL_BEGIN

@class LVThemeColor, UIViewThemeKit;
@interface UIViewTheme : LVThemeObject<UIViewThemeKit *>
@property (nonatomic, strong) LVThemeColor * _Nullable backgroundColor;
@property (nonatomic, strong) LVThemeColor * _Nullable tintColor;
@end
@interface UIViewThemeKit : LVThemeKit<UIViewTheme *, UIView *>
@end
@interface UIView (LVThemeKit)
@property (nonatomic, strong, readonly) UIViewThemeKit * _Nullable viewTK;
@end

NS_ASSUME_NONNULL_END
