//
//  PluginDemo.m
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import "PluginDispatcher.h"

@interface PluginDispatcher ()

@property(nonatomic, strong, readwrite) NSMutableDictionary *caches;
@property(nonatomic, strong, readwrite) NSMutableArray<id> *allPlugins;

@end


@implementation PluginDispatcher

- (void)dealloc {
    [self removeAllPlugins];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _allPlugins = [NSMutableArray array];
        _caches = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addPlugin:(__strong id)plugin {
    NSAssert(plugin, @"plugin can't be nil!!!!");
    if (!plugin) {
        return;
    }
    @synchronized (self) {
        if (![_allPlugins containsObject:plugin]) {
            [_allPlugins addObject:plugin];
            [_caches removeAllObjects];
        }
    }
}

- (void)removePlugin:(__strong id)plugin {
    NSAssert(plugin, @"plugin can't be nil!!!!");
    if (!plugin) {
        return;
    }
    @synchronized (self) {
        if ([_allPlugins containsObject:plugin]) {
            [_allPlugins removeObject:plugin];
            [_caches removeAllObjects];
        }
    }
}

- (void)removeAllPlugins {
    @synchronized (self) {
        [_allPlugins removeAllObjects];
        [_caches removeAllObjects];
    }
}

- (BOOL)containsPlugin:(__strong id)plugin {
    if (!plugin) {
        return NO;
    }
    @synchronized (self) {
        if ([_allPlugins containsObject:plugin]) {
            return YES;
        }
        return NO;
    }
}


- (void)dispatchEvent:(SEL)event executeBlock:(PluginDispatcherBlock)executeBlock {
    for (id plugin in [self pluginsConformsToProtocol:nil]) {
        if ([plugin isKindOfClass:[PluginDispatcher class]]) {
            [plugin dispatchEvent:event executeBlock:executeBlock];
        } else {
            BOOL stop = NO;
            if ([plugin respondsToSelector:event]) {

//                IMP imp = [plugin methodForSelector:event];
//                id (*func)(id, SEL) = (void *)imp;
//                id ret = func(plugin, event);
                executeBlock(plugin, &stop);
                if (stop) {
                    return;
                }
            }
        }
    }
}

- (NSArray *)pluginsConformsToProtocol:(nullable Protocol *)protocol {
    @synchronized (self) {
        NSArray *plugins = [self.caches objectForKey:protocol?NSStringFromProtocol(protocol):@""];
        if (plugins) {
            return plugins;
        }
        
        NSMutableArray *array = [NSMutableArray array];
        for (id object in _allPlugins) {
            if (!protocol || [object conformsToProtocol:protocol]) {
                [array addObject:object];
            }
        }
        [self.caches setObject:array forKey:protocol ? NSStringFromProtocol(protocol) : @""];
        return array;
    }
}

- (NSArray *)pluginsConformsToProtocol:(nullable Protocol *)protocol respondsToSelector:(SEL)selector {
    @synchronized (self) {
        NSString *key = [NSString stringWithFormat:@"%@#%@", NSStringFromProtocol(protocol), NSStringFromSelector(selector)];
        NSArray *plugins = [self.caches objectForKey:key];
        if (plugins) {
            return plugins;
        }
        
        NSMutableArray *array = [NSMutableArray array];
        for (id object in _allPlugins) {
            if ([object conformsToProtocol:protocol] && [object respondsToSelector:selector]) {
                [array addObject:object];
            }
        }
        [self.caches setObject:array forKey:key];
        return array;
    }
}

- (BOOL)respondsToSelector:(SEL)selector {
    if ([super respondsToSelector:selector]) {
        return YES;
    }
    
    NSArray *newAllPlugins = nil;
    @synchronized (self) {
        newAllPlugins = [_allPlugins copy];
    }
    for (id plugin in newAllPlugins) {
        if (plugin && [plugin respondsToSelector:selector]) {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (signature)
        return signature;
    
    NSArray *newAllPlugins = nil;
    @synchronized (self) {
        newAllPlugins = [_allPlugins copy];
    }
    
    for (id plugin in newAllPlugins) {
        if ([plugin respondsToSelector:selector]) {
            signature = [plugin methodSignatureForSelector:selector];
            if (signature)
                return signature;
        }
    }
    
    // return any selector
    return [self methodSignatureForSelector:@selector(class)];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL selector = [invocation selector];
    for (id plugin in [self pluginsConformsToProtocol:nil]) {
        if (plugin && [plugin respondsToSelector:selector]) {
            [invocation invokeWithTarget:plugin];
        }
    }
}

@end
