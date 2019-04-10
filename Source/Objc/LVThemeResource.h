//
//  LVThemeResource.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LVThemeResource<T> : NSObject
@property (nonatomic, readonly) T _Nullable resValue;
+ (instancetype)instance:(T _Nullable (^)(void))block;
@end

NS_ASSUME_NONNULL_END
