//
//  UILabel+LVThemeKit.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVThemeKit.h"

NS_ASSUME_NONNULL_BEGIN

@class LVThemeColor, LVThemeAttributedString;
@interface UILabelTheme : LVThemeObject
@property (nonatomic, strong) LVThemeColor * _Nullable textColor;
@property (nonatomic, strong) LVThemeAttributedString * _Nullable attributedText;
@end
@interface UILabelThemeKit : LVThemeKit<UILabelTheme *, UILabel *>
@end
@interface UILabel (LVThemeKit)
@property (nonatomic, strong, readonly) UILabelThemeKit *labelTK;
@end

NS_ASSUME_NONNULL_END
