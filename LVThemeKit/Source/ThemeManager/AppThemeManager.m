//
//  AppThemeManager.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "AppThemeManager.h"
#import "UIColor+hex.h"

NSString * const APP_THEME_CHANGED_NOTIFICATION = @"app_theme_changed";
NSString * const APP_THEME_FONT = @"font";
NSString * const APP_THEME_BACKGROUND = @"background";

@implementation AppThemeManager
+ (instancetype)share {
    static dispatch_once_t onceToken;
    static AppThemeManager *themeManager;
    dispatch_once(&onceToken, ^{
        themeManager = [[self alloc] init];
    });
    return themeManager;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.themes = @[
                        @{ APP_THEME_FONT: @"#00FF00", APP_THEME_BACKGROUND: @"#D2E4D2", },
                        @{ APP_THEME_FONT: @"#FF00FF", APP_THEME_BACKGROUND: @"#FFE4E1", }
                        ];
    }
    return self;
}
- (void)themeIndexChanged {
    [[NSNotificationCenter defaultCenter] postNotificationName:APP_THEME_CHANGED_NOTIFICATION object:nil];
}
@end
