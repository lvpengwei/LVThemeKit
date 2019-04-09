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

@interface _Observer : NSObject <LVThemeKitObserverGenerator>
@property (nonatomic, strong) id ob;
- (NSString *)notificationName;
@end
@implementation _Observer
- (NSString *)notificationName {
    return @"";
}
- (void)lvThemeKitObserverGeneratorCompletion:(LVThemeKitCompletion)completion {
    self.ob = [[NSNotificationCenter defaultCenter] addObserverForName:[self notificationName] object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        completion();
    }];
}
- (void)dealloc {
    if (self.ob) [[NSNotificationCenter defaultCenter] removeObserver:self.ob];
}
@end

@interface QDObserver : _Observer
@end
@implementation QDObserver
- (NSString *)notificationName {
    return QD_THEME_CHANGED_NOTIFICATION;
}
@end

@interface ReaderObserver : _Observer
@end
@implementation ReaderObserver
- (NSString *)notificationName {
    return READER_THEME_CHANGED_NOTIFICATION;
}
@end

@interface AppObserver : _Observer
@end
@implementation AppObserver
- (NSString *)notificationName {
    return APP_THEME_CHANGED_NOTIFICATION;
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
    config.generators = @[[QDObserver class], [ReaderObserver class], [AppObserver class]];
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
