//
//  LVThemeColor.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "LVThemeResource.h"

NS_ASSUME_NONNULL_BEGIN

@interface LVThemeColor : LVThemeResource<UIColor *>
+ (instancetype)readerThemeFont;
+ (instancetype)readerThemeBackground;
+ (instancetype)appThemeFont;
+ (instancetype)appThemeBackground;
+ (instancetype)qdThemeFont;
+ (instancetype)qdThemeBackground;
@end

NS_ASSUME_NONNULL_END
