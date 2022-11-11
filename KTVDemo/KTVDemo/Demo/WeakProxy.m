//
//  WeakProxy.m
//  KTVDemo
//
//  Created by 董德富 on 2022/11/7.
//

#import "WeakProxy.h"
#import <objc/runtime.h>

@interface WeakProxy ()

@property(nonatomic, strong) id strongedValue;

@end

@implementation WeakProxy

- (instancetype)initWithValue:(__weak id)value {
    self.value = value;
    return self;
}

- (instancetype)initWithStrongValue:(__strong id)value {
    self.strongedValue = value;
    self.value = value;
    return self;
}

+ (id)weak:(__weak id)value {
    return [[self alloc] initWithValue:value];
}

+ (id)strong:(__strong id)value {
    return [[self alloc] initWithStrongValue:value];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _value;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *signature = [_value methodSignatureForSelector:selector];
    if (signature) {
        return signature;
    }
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_value respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_value isEqual:object];
}

- (NSUInteger)hash {
    return [_value hash];
}

- (Class)superclass {
    return [_value superclass];
}

- (Class)class {
    return [_value class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_value isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_value isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_value conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_value description];
}

- (NSString *)debugDescription {
    return [_value debugDescription];
}

@end
