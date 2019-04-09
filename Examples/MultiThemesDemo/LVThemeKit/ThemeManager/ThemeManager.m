//
//  ThemeManager.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "ThemeManager.h"
#import "UIColor+hex.h"

@implementation ThemeManager
- (void)switchTheme {
    self.currentIndex = (self.currentIndex + 1) % (self.themes.count);
}
- (UIColor *)colorWithKey:(NSString *)key {
    return [UIColor colorWithHex:self.themes[self.currentIndex][key]];
}
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [self themeIndexChanged];
}
- (void)themeIndexChanged { }
@end
