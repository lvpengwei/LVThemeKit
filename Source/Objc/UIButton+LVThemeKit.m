//
//  UIButton+LVThemeKit.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "UIButton+LVThemeKit.h"
#import "LVThemeColor.h"
#import <objc/runtime.h>
#import "LVThemeString.h"
#import "LVThemeAttributedString.h"
#import "NSString+LVThemeKit.h"

@interface UIButtonTheme ()
@property (nonatomic, strong) NSMutableDictionary *titleColorDict;
@property (nonatomic, strong) NSMutableDictionary *titleDict;
@property (nonatomic, strong) NSMutableDictionary *imageDict;
@property (nonatomic, strong) NSMutableDictionary *attributedTitleDict;
@end
@implementation UIButtonTheme
- (instancetype)initWithTK:(id)tk {
    self = [super initWithTK:tk];
    if (self) {
        self.titleColorDict = @{}.mutableCopy;
        self.titleDict = @{}.mutableCopy;
        self.imageDict = @{}.mutableCopy;
        self.attributedTitleDict = @{}.mutableCopy;
    }
    return self;
}
+ (NSString *)titleColor {
    return [@"titleColor" undefined];
}
+ (NSString *)title {
    return [@"title" undefined];
}
+ (NSString *)image {
    return [@"image" undefined];
}
+ (NSString *)attributedTitle {
    return [@"attributedTitle" undefined];
}
+ (NSArray *)keyPaths {
    return @[[self title], [self titleColor], [self image], [self attributedTitle]];
}
- (BOOL)hasValueForKey:(NSString *)key {
    if ([key isEqualToString:[[self class] titleColor]]) {
        return self.titleColorDict.count > 0;
    } else if ([key isEqualToString:[[self class] title]]) {
        return self.titleDict.count > 0;
    } else if ([key isEqualToString:[[self class] image]]) {
        return self.imageDict.count > 0;
    } else if ([key isEqualToString:[[self class] attributedTitle]]) {
        return self.attributedTitleDict.count > 0;
    }
    return NO;
}
- (void)setTitleColor:(LVThemeColor *  _Nullable)titleColor forState:(UIControlState)state {
    [self.titleColorDict setObject:titleColor forKey:@(state)];
    [self.tk themeObject:self property:[[self class] titleColor] valueChanged:titleColor];
}
- (void)setTitle:(LVThemeString *  _Nullable)title forState:(UIControlState)state {
    [self.titleDict setObject:title forKey:@(state)];
    [self.tk themeObject:self property:[[self class] title] valueChanged:title];
}
- (void)setImage:(LVThemeImage * _Nullable)image forState:(UIControlState)state {
    [self.imageDict setObject:image forKey:@(state)];
    [self.tk themeObject:self property:[[self class] image] valueChanged:image];
}
- (void)setAttributedTitle:(LVThemeAttributedString * _Nullable)title forState:(UIControlState)state {
    [self.attributedTitleDict setObject:title forKey:@(state)];
    [self.tk themeObject:self property:[[self class] attributedTitle] valueChanged:title];
}
@end
@implementation UIButtonThemeKit
+ (Class)tClass {
    return [UIButtonTheme class];
}
- (void)apply:(LVThemeObject *)object key:(NSString *)key {
    UIButtonTheme *theme = (UIButtonTheme *)object;
    if ([key isEqualToString:[[theme class] attributedTitle]]) {
        for (NSNumber *key in theme.attributedTitleDict) {
            LVThemeAttributedString *title = theme.attributedTitleDict[key];
            [self.view setAttributedTitle:title.resValue forState:key.unsignedIntegerValue];
        }
    } else if ([key isEqualToString:[[theme class] title]]) {
        for (NSNumber *key in theme.titleDict) {
            LVThemeString *title = theme.titleDict[key];
            [self.view setTitle:title.resValue forState:key.unsignedIntegerValue];
        }
    } else if ([key isEqualToString:[[theme class] image]]) {
        for (NSNumber *key in theme.imageDict) {
            LVThemeImage *image = theme.imageDict[key];
            [self.view setImage:image.resValue forState:key.unsignedIntegerValue];
        }
    } else if ([key isEqualToString:[[theme class] titleColor]]) {
        for (NSNumber *key in theme.titleColorDict) {
            LVThemeColor *color = theme.titleColorDict[key];
            [self.view setTitleColor:color.resValue forState:key.unsignedIntegerValue];
        }
    }
}
@end
@implementation UIButton (LVThemeKit)
- (UIButtonThemeKit *)buttonTK {
    UIButtonThemeKit *_viewTK = objc_getAssociatedObject(self, _cmd);
    if (_viewTK == nil) {
        _viewTK = [UIButtonThemeKit instanceWithView:self];
        objc_setAssociatedObject(self, _cmd, _viewTK, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _viewTK;
}
@end
