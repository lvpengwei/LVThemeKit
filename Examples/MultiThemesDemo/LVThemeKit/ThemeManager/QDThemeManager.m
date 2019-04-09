//
//  QDThemeManager.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "QDThemeManager.h"
#import "UIColor+hex.h"

NSString * const QD_THEME_CHANGED_NOTIFICATION = @"qd_theme_changed";
NSString * const QD_THEME_FONT = @"font";
NSString * const QD_THEME_BACKGROUND = @"background";

@interface QDThemeManager ()
@property (nonatomic, strong) NSArray *themes;
@end
@implementation QDThemeManager
+ (instancetype)share {
    static dispatch_once_t onceToken;
    static QDThemeManager *themeManager;
    dispatch_once(&onceToken, ^{
        themeManager = [[self alloc] init];
    });
    return themeManager;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.type = QDThemeDay;
        self.themes = @[
                        @{ QD_THEME_FONT: @"#3B3F47", QD_THEME_BACKGROUND: @"#FFFFFF", },
                        @{ QD_THEME_FONT: @"#CCCCCC", QD_THEME_BACKGROUND: @"#262626", }
                        ];
    }
    return self;
}
- (BOOL)isNight {
    return self.type == QDThemeNight;
}
- (void)setType:(QDThemeType)type {
    _type = type;
    [[NSNotificationCenter defaultCenter] postNotificationName:QD_THEME_CHANGED_NOTIFICATION object:nil];
}
- (UIColor *)colorWithKey:(NSString *)key {
    NSInteger index = _type == QDThemeDay ? 0 : 1;
    return [UIColor colorWithHex:self.themes[index][key]];
}
@end
