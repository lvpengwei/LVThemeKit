//
//  LVThemeKit.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LVThemeResource;
@interface LVThemeObject<K> : NSObject
@property (nonatomic, weak, readonly) K tk;
- (instancetype)initWithTK:(K)tk;
+ (NSArray *)keyPaths;
@end
@interface LVThemeKit<T, V> : NSObject
@property (nonatomic, strong, readonly) T qd; // 黑夜模式
@property (nonatomic, strong, readonly) T reader; // 阅读器主题
@property (nonatomic, strong, readonly) T app; // app皮肤
@property (nonatomic, weak, readonly) V view;
+ (instancetype)instanceWithView:(V)view;
+ (Class)tClass;
- (void)themeObject:(T)object property:(NSString *)key valueChanged:(LVThemeResource *)res;
- (void)applyProperty:(NSString *)key;
- (void)apply;
@end

NS_ASSUME_NONNULL_END
