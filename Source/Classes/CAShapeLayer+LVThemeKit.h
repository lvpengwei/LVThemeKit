//
//  CAShapeLayer+LVThemeKit.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@class LVThemeColor, CAShapeLayerThemeKit;
@interface CAShapeLayerTheme : LVThemeObject<CAShapeLayerThemeKit *>
@property (nonatomic, strong) LVThemeColor * _Nullable fillColor;
@end
@interface CAShapeLayerThemeKit : LVThemeKit<CAShapeLayerTheme *, CAShapeLayer *>
@end
@interface CAShapeLayer (LVThemeKit)
@property (nonatomic, strong, readonly) CAShapeLayerThemeKit *shapeTK;
@end

NS_ASSUME_NONNULL_END
