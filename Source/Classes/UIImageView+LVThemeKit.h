//
//  UIImageView+LVThemeKit.h
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LVThemeImage;
@interface UIImageViewTheme : LVThemeObject
@property (nonatomic, strong) LVThemeImage * _Nullable image;
@end
@interface UIImageViewThemeKit : LVThemeKit<UIImageViewTheme *, UIImageView *>
@end
@interface UIImageView (LVThemeKit)
@property (nonatomic, strong, readonly) UIImageViewThemeKit *imageTK;
@end

NS_ASSUME_NONNULL_END
