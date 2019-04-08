//
//  ThemeManager.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThemeManager : NSObject
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *themes;
- (void)switchTheme;
- (UIColor *)colorWithKey:(NSString *)key;
- (void)themeIndexChanged;
@end

NS_ASSUME_NONNULL_END
