//
//  LVThemeKit+Demo.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/4/8.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "LVThemeKit+Demo.h"
#import "QDThemeManager.h"
#import "ReaderThemeManager.h"
#import "AppThemeManager.h"

@interface NotificationCancelable : NSObject<LVThemeKitCancelable>
@property (nonatomic, strong) id observer;
+ (instancetype)instanceWith:(id)observer;
@end
@implementation NotificationCancelable
+ (instancetype)instanceWith:(id)observer {
    NotificationCancelable *cancelable = [NotificationCancelable new];
    cancelable.observer = observer;
    return cancelable;
}
- (void)cancel {
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}
@end

@implementation LVThemeKit (Demo)
- (id)qd {
    return self.themes[0];
}
- (id)reader {
    return self.themes[1];
}
- (id)app {
    return self.themes[2];
}
+ (void)demoConfig {
    LVThemeKitConfig *config = [[LVThemeKitConfig alloc] init];
    config.generators = @[^id<LVThemeKitCancelable>(LVThemeKitCompletion completion) {
        return [NotificationCancelable instanceWith:[[NSNotificationCenter defaultCenter] addObserverForName:QD_THEME_CHANGED_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            completion();
        }]];
    },^id<LVThemeKitCancelable>(LVThemeKitCompletion completion) {
        return [NotificationCancelable instanceWith:[[NSNotificationCenter defaultCenter] addObserverForName:READER_THEME_CHANGED_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            completion();
        }]];
    },^id<LVThemeKitCancelable>(LVThemeKitCompletion completion) {
        return [NotificationCancelable instanceWith:[[NSNotificationCenter defaultCenter] addObserverForName:APP_THEME_CHANGED_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            completion();
        }]];
    }];
    config.applyProperty = ^(LVThemeKit *tk, NSString * _Nonnull key, LVThemeKitApplyPropertyCompletion  _Nonnull completion) {
        if ([QDThemeManager share].isNight && [tk.qd valueForKey:key]) {
            completion(tk.qd);
        } else if ([tk.reader valueForKey:key]) {
            completion(tk.reader);
        } else if ([tk.app valueForKey:key]) {
            completion(tk.app);
        } else if ([tk.qd valueForKey:key]) {
            completion(tk.qd);
        }
    };
    LVThemeKit.config = config;
}
@end
