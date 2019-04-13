//
//  LVThemeKit.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LVThemeKit, LVThemeObject, LVThemeResource;
typedef void(^LVThemeKitCompletion)(void);
@protocol LVThemeKitObserverGenerator <NSObject>
- (void)lvThemeKitObserverGeneratorCompletion:(LVThemeKitCompletion)completion;
@end

typedef void(^LVThemeKitApplyPropertyCompletion)(LVThemeObject *theme);
typedef void(^LVThemeKitApplyPropertyBlock)(LVThemeKit *tk, NSString *key, LVThemeKitApplyPropertyCompletion completion);
@interface LVThemeKitConfig : NSObject
// 生成皮肤监听的数组
@property (nonatomic, copy) NSArray<Class<LVThemeKitObserverGenerator>> *generators;
// 自定义皮肤的应用顺序，默认是数组顺序。如果是多区域主题可以用到这个字段。
@property (nonatomic, copy) LVThemeKitApplyPropertyBlock _Nullable applyProperty;
@end

@protocol LVThemeObjectProtocol <NSObject>
- (void)themeObject:(LVThemeObject *)object property:(NSString *)key valueChanged:(LVThemeResource *)res;
@end

@interface LVThemeObject : NSObject
@property (nonatomic, weak, readonly) id<LVThemeObjectProtocol> tk;
- (instancetype)initWithTK:(id<LVThemeObjectProtocol>)tk;
- (BOOL)hasValueForKey:(NSString *)key;
+ (NSArray *)keyPaths;
@end

@interface LVThemeKit<T: LVThemeObject *, V> : NSObject
// 不可以为空
@property (class, nonatomic, strong) LVThemeKitConfig *config;
// 按照监听数组的顺序生成 T 实例
@property (nonatomic, strong, readonly) NSArray<T> *themes;
// 数组中的第一个元素
@property (nonatomic, strong, readonly) T theme;
@property (nonatomic, weak, readonly) V view;
+ (instancetype)instanceWithView:(V)view;
+ (Class)tClass;
- (void)apply:(T)object key:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
