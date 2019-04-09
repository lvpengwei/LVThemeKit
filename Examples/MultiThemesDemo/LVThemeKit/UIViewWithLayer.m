//
//  UIViewWithLayer.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "UIViewWithLayer.h"
#import "LVThemeKit+Demo.h"
#import "CALayer+LVThemeKit.h"
#import "CAShapeLayer+LVThemeKit.h"
#import "LVThemeColor+Demo.h"

@implementation UIViewWithLayer
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self commitInit];
}
- (void)commitInit {
    CALayer *lay = [CALayer layer];
    lay.layerTK.reader.backgroundColor = [LVThemeColor readerThemeBackground];
    lay.layerTK.reader.borderColor = [LVThemeColor readerThemeFont];
    lay.borderWidth = 1;
    [self.layer addSublayer:lay];
    self.lay = lay;
    CAShapeLayer *shapeLay = [CAShapeLayer layer];
    shapeLay.shapeTK.reader.fillColor = [LVThemeColor readerThemeFont];
    [self.layer addSublayer:shapeLay];
    self.shapeLay = shapeLay;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.lay.frame = CGRectMake(8, 8, self.bounds.size.width * 0.5 - 16, self.bounds.size.height - 16);
    self.shapeLay.frame = CGRectMake(self.bounds.size.width * 0.5 + 8, 8, self.bounds.size.width * 0.5 - 16, self.bounds.size.height - 16);
    CGFloat radius = self.shapeLay.bounds.size.height * 0.5;
    self.shapeLay.path = [UIBezierPath bezierPathWithRoundedRect:self.shapeLay.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(radius, radius)].CGPath;
}
- (CGSize)intrinsicContentSize {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
}
@end
