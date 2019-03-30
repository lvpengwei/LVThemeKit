//
//  LVThemeColor.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "LVThemeColor.h"
#import "AppThemeManager.h"
#import "ReaderThemeManager.h"
#import "QDThemeManager.h"

@implementation LVThemeColor
+ (instancetype)readerThemeFont {
    return [self readerTheme:READER_THEME_FONT];
}
+ (instancetype)readerThemeBackground {
    return [self readerTheme:READER_THEME_BACKGROUND];
}
+ (instancetype)appThemeFont {
    return [self appTheme:APP_THEME_FONT];
}
+ (instancetype)appThemeBackground {
    return [self appTheme:APP_THEME_BACKGROUND];
}
+ (instancetype)readerTheme:(NSString *)key {
    return [self instance:^id _Nonnull{
        return [[ReaderThemeManager share] colorWithKey:key];
    }];
}
+ (instancetype)appTheme:(NSString *)key {
    return [self instance:^id _Nonnull{
        return [[AppThemeManager share] colorWithKey:key];
    }];
}
+ (instancetype)qdThemeFont {
    return [self qdTheme:QD_THEME_FONT];
}
+ (instancetype)qdThemeBackground {
    return [self qdTheme:QD_THEME_BACKGROUND];
}
+ (instancetype)qdTheme:(NSString *)key {
    return [self instance:^id _Nonnull{
        return [[QDThemeManager share] colorWithKey:key];
    }];
}
@end
