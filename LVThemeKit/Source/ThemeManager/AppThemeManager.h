//
//  AppThemeManager.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

// APP 皮肤
extern NSString * const APP_THEME_CHANGED_NOTIFICATION;
extern NSString * const APP_THEME_FONT;
extern NSString * const APP_THEME_BACKGROUND;

@interface AppThemeManager : ThemeManager
+ (instancetype)share;
@end

NS_ASSUME_NONNULL_END
