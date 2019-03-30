//
//  QDThemeManager.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

// 黑夜模式
extern NSString * const QD_THEME_CHANGED_NOTIFICATION;
extern NSString * const QD_THEME_FONT;
extern NSString * const QD_THEME_BACKGROUND;

typedef enum : NSUInteger {
    QDThemeDay,
    QDThemeNight,
} QDThemeType;
@interface QDThemeManager : NSObject
@property (nonatomic) QDThemeType type;
@property (nonatomic, readonly, getter=isNight) BOOL night;
+ (instancetype)share;
- (UIColor *)colorWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
