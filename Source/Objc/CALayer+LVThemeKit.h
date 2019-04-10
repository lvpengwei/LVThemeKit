//
//  CALayer+LVThemeKit.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//

#import <QuartzCore/QuartzCore.h>
#import "LVThemeKit.h"

NS_ASSUME_NONNULL_BEGIN

@class LVThemeColor;
@interface CALayerTheme : LVThemeObject
@property (nonatomic, strong) LVThemeColor * _Nullable backgroundColor;
@property (nonatomic, strong) LVThemeColor * _Nullable borderColor;
@end
@interface CALayerThemeKit : LVThemeKit<CALayerTheme *, CALayer *>
@end
@interface CALayer (LVThemeKit)
@property (nonatomic, strong, readonly) CALayerThemeKit *layerTK;
@end

NS_ASSUME_NONNULL_END
