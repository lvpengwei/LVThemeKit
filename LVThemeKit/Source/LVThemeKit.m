//
//  LVThemeKit.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "LVThemeKit.h"
#import "ReaderThemeManager.h"
#import "AppThemeManager.h"
#import "QDThemeManager.h"
#import "LVThemeResource.h"

@interface LVThemeObject<K> ()
@property (nonatomic, weak, readwrite) K tk;
@end
@implementation LVThemeObject
- (instancetype)initWithTK:(id)tk {
    self = [super init];
    if (self) {
        self.tk = tk;
        [self addObservers];
    }
    return self;
}
+ (NSArray *)keyPaths {
    return @[];
}
- (void)addObservers {
    for (NSString *key in [self class].keyPaths) {
        [self addObserverForKeyPath:key];
    }
}
- (void)addObserverForKeyPath:(NSString *)key {
    [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self.tk themeObject:self property:keyPath valueChanged:[self valueForKey:keyPath]];
}
- (void)dealloc {
    for (NSString *key in [self class].keyPaths) {
        [self removeObserver:self forKeyPath:key];
    }
}
@end
@interface LVThemeKit<T, V> ()
@property (nonatomic, strong, readwrite) T qd;
@property (nonatomic, strong, readwrite) T reader;
@property (nonatomic, strong, readwrite) T app;
@property (nonatomic, weak, readwrite) V view;

@property (nonatomic, weak) id readerObserver;
@property (nonatomic, weak) id appObserver;
@property (nonatomic, weak) id qdObserver;
@end
@implementation LVThemeKit
+ (instancetype)instanceWithView:(id)view {
    return [[self alloc] initWithView:view tClass:[self tClass]];
}
- (instancetype)initWithView:(id)view tClass:(Class)clz {
    self = [super init];
    if (self) {
        self.view = view;
        self.app = [[clz alloc] initWithTK:self];
        self.reader = [[clz alloc] initWithTK:self];
        self.qd = [[clz alloc] initWithTK:self];
    }
    return self;
}
+ (Class)tClass {
    @throw [[NSException alloc] initWithName:@"主动异常" reason:@"子类实现" userInfo:nil];
}
- (void)themeObject:(id)object property:(NSString *)key valueChanged:(LVThemeResource *)res {
    [self setupThemeObserve:object property:key valueChanged:res];
    [self applyProperty:key];
}
- (void)applyProperty:(NSString *)key {
    if ([QDThemeManager share].isNight && [self.qd valueForKey:key]) {
        [self apply:self.qd key:key];
    } else if ([self.reader valueForKey:key]) {
        [self apply:self.reader key:key];
    } else if ([self.app valueForKey:key]) {
        [self apply:self.app key:key];
    } else if ([self.qd valueForKey:key]) {
        [self apply:self.qd key:key];
    }
}
- (void)setupThemeObserve:(id)object property:(NSString *)key valueChanged:(LVThemeResource *)res {
    if (object == self.app) {
        [self setupAppThemeObserve];
    } else if (object == self.reader) {
        [self setupReaderThemeObserve];
    } else if (object == self.qd) {
        [self setupQdThemeObserve];
    }
}
- (void)apply:(id)object key:(NSString *)key {
    if ([self.view isKindOfClass:[CALayer class]]) {
        id resValue = ((LVThemeResource *)[object valueForKey:key]).resValue;
        if ([resValue isKindOfClass:[UIColor class]]) {
            [(CALayer *)self.view setValue:(id)((UIColor *)resValue).CGColor forKey:key];
        }
    } else {
        [self.view setValue:((LVThemeResource *)[object valueForKey:key]).resValue forKey:key];
    }
}
- (void)setupReaderThemeObserve {
    if (self.readerObserver) return;
    __weak typeof(self) weakSelf = self;
    self.readerObserver = [[NSNotificationCenter defaultCenter] addObserverForName:READER_THEME_CHANGED_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        [strongSelf apply];
    }];
}
- (void)setupAppThemeObserve {
    if (self.appObserver) return;
    __weak typeof(self) weakSelf = self;
    self.appObserver = [[NSNotificationCenter defaultCenter] addObserverForName:APP_THEME_CHANGED_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        [strongSelf apply];
    }];
}
- (void)setupQdThemeObserve {
    if (self.qdObserver) return;
    __weak typeof(self) weakSelf = self;
    self.qdObserver = [[NSNotificationCenter defaultCenter] addObserverForName:QD_THEME_CHANGED_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        [strongSelf apply];
    }];
}
- (void)_removeObserver:(id)observer {
    if (observer) [[NSNotificationCenter defaultCenter] removeObserver:observer];
}
- (void)dealloc {
    [self _removeObserver:self.readerObserver];
    [self _removeObserver:self.qdObserver];
    [self _removeObserver:self.appObserver];
}
- (void)apply {
    for (NSString *key in [[[self class] tClass] keyPaths]) {
        [self applyProperty:key];
    }
}
@end
