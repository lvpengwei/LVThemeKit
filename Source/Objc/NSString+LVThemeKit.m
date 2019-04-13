//
//  NSString+LVThemeKit.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/13.
//

#import "NSString+LVThemeKit.h"

NSString * const PREFIX_UNDEFINED = @"undefined";
@implementation NSString (LVThemeKit)
- (NSString *)undefined {
    return [NSString stringWithFormat:@"%@_%@", PREFIX_UNDEFINED, self];
}
- (BOOL)isUndefined {
    return [self hasPrefix:PREFIX_UNDEFINED];
}
@end
