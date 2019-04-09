//
//  LVThemeKit+Demo.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "LVThemeKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface LVThemeKit<T, V> (Demo)
@property (nonatomic, strong, readonly) T qd; // 黑夜模式
@property (nonatomic, strong, readonly) T reader; // 阅读器主题
@property (nonatomic, strong, readonly) T app; // app皮肤
+ (void)demoConfig;
@end

NS_ASSUME_NONNULL_END
