//
//  LVThemeKit.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "LVThemeKit.h"
#import "LVThemeResource.h"
#import "NSString+LVThemeKit.h"

@implementation LVThemeKitConfig
@end

@interface LVThemeObject ()
@property (nonatomic, weak, readwrite) id<LVThemeObjectProtocol> tk;
@end
@implementation LVThemeObject
- (instancetype)initWithTK:(id<LVThemeObjectProtocol>)tk {
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
- (BOOL)hasValueForKey:(NSString *)key {
    return [self valueForKey:key] != nil;
}
- (void)addObserverForKeyPath:(NSString *)key {
    if ([key isUndefined]) return;
    [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self.tk themeObject:self property:keyPath valueChanged:[self valueForKey:keyPath]];
}
- (void)dealloc {
    for (NSString *key in [self class].keyPaths) {
        if ([key isUndefined]) continue;
        [self removeObserver:self forKeyPath:key];
    }
}
@end

@interface LVThemeKit<T, V> () <LVThemeObjectProtocol>
@property (nonatomic, strong, readwrite) NSArray<T> *themes;
@property (nonatomic, weak, readwrite) V view;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, id> *observers;
@property (nonatomic, weak) id readerObserver;
@property (nonatomic, weak) id appObserver;
@property (nonatomic, weak) id qdObserver;
@end
@implementation LVThemeKit
static LVThemeKitConfig *_config = nil;
+ (void)setConfig:(LVThemeKitConfig *)config {
    if (_config != config) {
        _config = config;
    }
}
+ (LVThemeKitConfig *)config {
    return _config;
}
+ (Class)tClass {
    @throw [[NSException alloc] initWithName:@"主动异常" reason:@"子类实现" userInfo:nil];
}
- (LVThemeObject *)theme {
    return self.themes[0];
}
+ (instancetype)instanceWithView:(id)view {
    return [[self alloc] initWithView:view tClass:[self tClass]];
}
- (instancetype)initWithView:(id)view tClass:(Class)clz {
    self = [super init];
    if (self) {
        self.view = view;
        NSAssert(LVThemeKit.config != nil, @"LVThemeKit.config 不能为空");
        NSAssert(LVThemeKit.config.generators.count != 0, @"LVThemeKit.config.generators 不能为空");
        NSMutableArray *themes = @[].mutableCopy;
        for (int i = 0; i < LVThemeKit.config.generators.count; i++) {
            [themes addObject:[[clz alloc] initWithTK:self]];
        }
        self.themes = themes.copy;
        self.observers = @{}.mutableCopy;
    }
    return self;
}
- (void)themeObject:(LVThemeObject *)object property:(NSString *)key valueChanged:(LVThemeResource *)res {
    [self setupThemeObserve:object property:key valueChanged:res];
    [self applyProperty:key];
}
- (void)applyProperty:(NSString *)key {
    if (LVThemeKit.config.applyProperty) {
        __weak typeof(self) weakSelf = self;
        LVThemeKit.config.applyProperty(self, key, ^(LVThemeObject * _Nonnull theme) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) return;
            [strongSelf apply:theme key:key];
        });
        return;
    }
    for (LVThemeObject *theme in self.themes) {
        if ([theme hasValueForKey:key]) {
            [self apply:theme key:key];
            return;
        }
    }
}
- (void)setupThemeObserve:(LVThemeObject *)object property:(NSString *)key valueChanged:(LVThemeResource *)res {
    NSInteger index = -1;
    for (id t in self.themes) {
        index += 1;
        if (object == t) break;
    }
    if (index < 0 || index >= self.themes.count) return;
    if (self.observers[@(index)]) return;
    __weak typeof(self) weakSelf = self;
    Class clz = LVThemeKit.config.generators[index];
    id<LVThemeKitObserverGenerator> generator = [[clz alloc] init];
    [generator lvThemeKitObserverGeneratorCompletion:(^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        [strongSelf apply];
    })];
    self.observers[@(index)] = generator;
}
- (void)apply:(LVThemeObject *)object key:(NSString *)key {
    if ([self.view isKindOfClass:[CALayer class]]) {
        id resValue = ((LVThemeResource *)[object valueForKey:key]).resValue;
        if ([resValue isKindOfClass:[UIColor class]]) {
            [(CALayer *)self.view setValue:(id)((UIColor *)resValue).CGColor forKey:key];
        }
    } else {
        [self.view setValue:((LVThemeResource *)[object valueForKey:key]).resValue forKey:key];
    }
}
- (void)apply {
    for (NSString *key in [[[self class] tClass] keyPaths]) {
        [self applyProperty:key];
    }
}
@end
