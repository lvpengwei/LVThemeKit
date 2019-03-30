//
//  LVThemeResource.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "LVThemeResource.h"

@interface LVThemeResource<T> ()
@property (nonatomic, copy) T (^block)(void);
@end
@implementation LVThemeResource
+ (instancetype)instance:(id (^)(void))block {
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(id (^)(void))block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}
- (id)resValue {
    return self.block();
}
@end
