//
//  ReaderThemeManager.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "ReaderThemeManager.h"

NSString * const READER_THEME_CHANGED_NOTIFICATION = @"reader_theme_changed";
NSString * const READER_THEME_FONT = @"font";
NSString * const READER_THEME_BACKGROUND = @"background";

@implementation ReaderThemeManager
+ (instancetype)share {
    static dispatch_once_t onceToken;
    static ReaderThemeManager *themeManager;
    dispatch_once(&onceToken, ^{
        themeManager = [[self alloc] init];
    });
    return themeManager;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.themes = @[
                        @{ READER_THEME_FONT: @"#00FFFF", READER_THEME_BACKGROUND: @"#F6F6F6", },
                        @{ READER_THEME_FONT: @"#FF0000", READER_THEME_BACKGROUND: @"#FAF0E6", }
                        ];
    }
    return self;
}
- (void)themeIndexChanged {
    [[NSNotificationCenter defaultCenter] postNotificationName:READER_THEME_CHANGED_NOTIFICATION object:nil];
}
@end
