//
//  LVThemeString+Demo.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "LVThemeString+Demo.h"
#import "QDThemeManager.h"

@implementation LVThemeString (Demo)
+ (instancetype)qdThemeString {
    return [self instance:^id _Nonnull{
        return [QDThemeManager share].isNight ? @"黑夜Button" : @"白天Button";
    }];
}
@end
