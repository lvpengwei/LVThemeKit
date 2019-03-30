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
#import "QDThemeManager.h"
#import "LVThemeString.h"

@interface UIButtonTheme ()
@property (nonatomic, strong) NSMutableDictionary *titleColorDict;
@property (nonatomic, strong) NSMutableDictionary *titleDict;
@property (nonatomic, strong) NSMutableDictionary *imageDict;
@end
@implementation UIButtonTheme
- (instancetype)initWithTK:(id)tk {
    self = [super initWithTK:tk];
    if (self) {
        self.titleColorDict = @{}.mutableCopy;
        self.titleDict = @{}.mutableCopy;
        self.imageDict = @{}.mutableCopy;
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
//- (void)setImage:(LVThemeImage * _Nullable)image forState:(UIControlState)state {
//    [self.imageDict setObject:image forKey:@(state)];
//    [self.tk themeObject:self property:@"image" valueChanged:image];
//}
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
    }
}
- (void)applyTitle {
    for (NSNumber *key in self.qd.titleDict) {
        LVThemeString *title = self.qd.titleDict[key];
        [self.view setTitle:title.resValue forState:key.unsignedIntegerValue];
    }
}
- (void)applyImage {
}
- (void)applyTextColor {
    if ([QDThemeManager share].isNight && self.qd.titleColorDict.count) {
        for (NSNumber *key in self.qd.titleColorDict) {
            LVThemeColor *color = self.qd.titleColorDict[key];
            [self.view setTitleColor:color.resValue forState:key.unsignedIntegerValue];
        }
        return;
    }
    if (self.reader.titleColorDict.count) {
        for (NSNumber *key in self.reader.titleColorDict) {
            LVThemeColor *color = self.reader.titleColorDict[key];
            [self.view setTitleColor:color.resValue forState:key.unsignedIntegerValue];
        }
        return;
    }
    if (self.app.titleColorDict.count) {
        for (NSNumber *key in self.app.titleColorDict) {
            LVThemeColor *color = self.app.titleColorDict[key];
            [self.view setTitleColor:color.resValue forState:key.unsignedIntegerValue];
        }
        return;
    }
    if (self.qd.titleColorDict.count) {
        for (NSNumber *key in self.qd.titleColorDict) {
            LVThemeColor *color = self.qd.titleColorDict[key];
            [self.view setTitleColor:color.resValue forState:key.unsignedIntegerValue];
        }
    }
}
- (void)apply {
    [super apply];
    [self applyProperty:@"titleColor"];
    [self applyProperty:@"title"];
//    [self applyProperty:@"image"];
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
