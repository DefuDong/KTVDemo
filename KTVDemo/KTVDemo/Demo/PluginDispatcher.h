//
//  PluginDispatcher.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import <Foundation/Foundation.h>

typedef void(^PluginDispatcherBlock)(id _Nonnull plugin, BOOL * _Nonnull stop);

NS_ASSUME_NONNULL_BEGIN

@interface PluginDispatcher<__covariant ObjectType> : NSObject

@property(nonatomic, strong, readonly) NSArray<ObjectType> *allPlugins;

- (void)addPlugin:(__strong ObjectType)plugin;
- (void)removePlugin:(__strong ObjectType)plugin;
- (void)removeAllPlugins;
- (BOOL)containsPlugin:(__strong ObjectType)plugin;

- (NSArray<ObjectType> *)pluginsConformsToProtocol:(nullable Protocol *)protocol;
- (NSArray<ObjectType> *)pluginsConformsToProtocol:(nullable Protocol *)protocol respondsToSelector:(SEL)selector;

- (void)dispatchEvent:(SEL)event executeBlock:(PluginDispatcherBlock)executeBlock;


@end

NS_ASSUME_NONNULL_END
