//
//  UIColor+hex.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "UIColor+hex.h"

@implementation NSString (LeftPadding)
// taken from http://stackoverflow.com/questions/964322/padding-string-to-left-with-objective-c
- (NSString *)stringByPaddingTheLeftToLength:(NSUInteger)newLength withString:(NSString *)padString startingAtIndex:(NSUInteger)padIndex {
    if ([self length] <= newLength)
        return [[@"" stringByPaddingToLength:newLength - [self length] withString:padString startingAtIndex:padIndex] stringByAppendingString:self];
    else
        return [self copy];
}
@end

@implementation UIColor (hex)
+ (UIColor *)colorWithHex:(NSString *)hex {
    if (hex.length == 0)
        return [UIColor blackColor];
    
    if ([hex characterAtIndex:0] == '#')
        hex = [hex substringFromIndex:1];
    
    NSString *a, *r, *g, *b;
    
    NSUInteger len = hex.length;
    if (len == 6) {
    six:
        a = @"FF";
        r = [hex substringWithRange:NSMakeRange(0, 2)];
        g = [hex substringWithRange:NSMakeRange(2, 2)];
        b = [hex substringWithRange:NSMakeRange(4, 2)];
    }
    else if (len == 8) {
    eight:
        a = [hex substringWithRange:NSMakeRange(0, 2)];
        r = [hex substringWithRange:NSMakeRange(2, 2)];
        g = [hex substringWithRange:NSMakeRange(4, 2)];
        b = [hex substringWithRange:NSMakeRange(6, 2)];
    }
    else if (len == 3) {
    three:
        a = @"FF";
        r = [hex substringWithRange:NSMakeRange(0, 1)];
        r = [r stringByAppendingString:a];
        g = [hex substringWithRange:NSMakeRange(1, 1)];
        g = [g stringByAppendingString:a];
        b = [hex substringWithRange:NSMakeRange(2, 1)];
        b = [b stringByAppendingString:a];
    }
    else if (len == 4) {
        a = [hex substringWithRange:NSMakeRange(0, 1)];
        a = [a stringByAppendingString:a];
        r = [hex substringWithRange:NSMakeRange(1, 1)];
        r = [r stringByAppendingString:a];
        g = [hex substringWithRange:NSMakeRange(2, 1)];
        g = [g stringByAppendingString:a];
        b = [hex substringWithRange:NSMakeRange(3, 1)];
        b = [b stringByAppendingString:a];
    }
    else if (len == 5 || len == 7) {
        hex = [@"0" stringByAppendingString:hex];
        if (len == 5) goto six;
        goto eight;
    }
    else if (len < 3) {
        hex = [hex stringByPaddingTheLeftToLength:3 withString:@"0" startingAtIndex:0];
        goto three;
    }
    else if (len > 8) {
        hex = [hex substringFromIndex:len-8];
        goto eight;
    }
    else {
        a = @"FF";
        r = @"00";
        g = @"00";
        b = @"00";
    }
    
    // parse each component separately. This gives more accurate results than
    // throwing it all together in one string and use scanf on the global string.
    a = [@"0x" stringByAppendingString:a];
    r = [@"0x" stringByAppendingString:r];
    g = [@"0x" stringByAppendingString:g];
    b = [@"0x" stringByAppendingString:b];
    
    uint av, rv, gv, bv;
    sscanf([a cStringUsingEncoding:NSASCIIStringEncoding], "%x", &av);
    sscanf([r cStringUsingEncoding:NSASCIIStringEncoding], "%x", &rv);
    sscanf([g cStringUsingEncoding:NSASCIIStringEncoding], "%x", &gv);
    sscanf([b cStringUsingEncoding:NSASCIIStringEncoding], "%x", &bv);
    
    return [UIColor colorWithRed: rv / 255.f
                           green: gv / 255.f
                            blue: bv / 255.f
                           alpha: av / 255.f];
}
@end
