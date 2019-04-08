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
- (void)setTitleColor:(LVThemeColor *  _Nullable)titleColor forState:(UIControlState)state {
    [self.titleColorDict setObject:titleColor forKey:@(state)];
    [self.tk themeObject:self property:@"titleColor" valueChanged:titleColor];
}
- (void)setTitle:(LVThemeString *  _Nullable)title forState:(UIControlState)state {
    [self.titleDict setObject:title forKey:@(state)];
    [self.tk themeObject:self property:@"title" valueChanged:title];
}
- (void)setImage:(LVThemeImage * _Nullable)image forState:(UIControlState)state {
    [self.imageDict setObject:image forKey:@(state)];
    [self.tk themeObject:self property:@"image" valueChanged:image];
}
- (void)setAttributedTitle:(LVThemeAttributedString * _Nullable)title forState:(UIControlState)state {
    [self.attributedTitleDict setObject:title forKey:@(state)];
    [self.tk themeObject:self property:@"attributedTitle" valueChanged:title];
}
@end
@implementation UIButtonThemeKit
+ (Class)tClass {
    return [UIButtonTheme class];
}
- (void)applyProperty:(NSString *)key {
    if ([key isEqualToString:@"image"]) {
        [self applyImage];
    } else if ([key isEqualToString:@"titleColor"]) {
        [self applyTextColor];
    } else if ([key isEqualToString:@"title"]) {
        [self applyTitle];
    } else if ([key isEqualToString:@"attributedTitle"]) {
        [self applyAttributedTitle];
    }
}
- (void)applyAttributedTitle {
    for (UIButtonTheme *theme in self.themes) {
        if (theme.attributedTitleDict.count) {
            for (NSNumber *key in theme.attributedTitleDict) {
                LVThemeAttributedString *title = theme.attributedTitleDict[key];
                [self.view setAttributedTitle:title.resValue forState:key.unsignedIntegerValue];
            }
            return;
        }
    }
}
- (void)applyTitle {
    for (UIButtonTheme *theme in self.themes) {
        if (theme.titleDict.count) {
            for (NSNumber *key in theme.titleDict) {
                LVThemeString *title = theme.titleDict[key];
                [self.view setTitle:title.resValue forState:key.unsignedIntegerValue];
            }
            return;
        }
    }
}
- (void)applyImage {
    for (UIButtonTheme *theme in self.themes) {
        if (theme.imageDict.count) {
            for (NSNumber *key in theme.imageDict) {
                LVThemeImage *image = theme.imageDict[key];
                [self.view setImage:image.resValue forState:key.unsignedIntegerValue];
            }
            return;
        }
    }
}
- (void)applyTextColor {
    for (UIButtonTheme *theme in self.themes) {
        if (theme.titleColorDict.count) {
            for (NSNumber *key in theme.titleColorDict) {
                LVThemeColor *color = theme.titleColorDict[key];
                [self.view setTitleColor:color.resValue forState:key.unsignedIntegerValue];
            }
            return;
        }
    }
}
- (void)apply {
    [super apply];
    [self applyProperty:@"titleColor"];
    [self applyProperty:@"title"];
    [self applyProperty:@"image"];
    [self applyProperty:@"attributedTitle"];
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
