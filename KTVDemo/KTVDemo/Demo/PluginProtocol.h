//
//  PluginProtocol.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import <Foundation/Foundation.h>

@class BaseViewController;
@class MainView;
@class Model;

NS_ASSUME_NONNULL_BEGIN

@protocol PluginProtocol <NSObject>

@required

@property (nonatomic, weak) BaseViewController *viewController;
@property (nonatomic, weak) MainView *mainView;

/// 插件初始化
- (void)pluginDidLoad;

/// 插件卸载
- (void)pluginDidUnload;

@optional

/// 插件初始化
- (void)pluginWillLoad;

/// 插件卸载
- (void)pluginWillUnload;

@end

NS_ASSUME_NONNULL_END
