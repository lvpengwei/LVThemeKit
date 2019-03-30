//
//  LVThemeString.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "LVThemeString.h"
#import "QDThemeManager.h"

@implementation LVThemeString
+ (instancetype)qdThemeString {
    return [self instance:^id _Nonnull{
        return [QDThemeManager share].isNight ? @"黑夜" : @"白天";
    }];
}
@end
