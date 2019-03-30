//
//  ReaderThemeManager.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

// 阅读器皮肤
extern NSString * const READER_THEME_CHANGED_NOTIFICATION;
extern NSString * const READER_THEME_FONT;
extern NSString * const READER_THEME_BACKGROUND;

@interface ReaderThemeManager : ThemeManager
+ (instancetype)share;
@end

NS_ASSUME_NONNULL_END
