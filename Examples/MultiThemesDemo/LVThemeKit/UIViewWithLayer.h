//
//  UIViewWithLayer.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewWithLayer : UIView

@property (nonatomic, weak) CALayer *lay;
@property (nonatomic, weak) CAShapeLayer *shapeLay;

@end

NS_ASSUME_NONNULL_END
