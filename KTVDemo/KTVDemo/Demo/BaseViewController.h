//
//  BaseViewController.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "MainView.h"
#import "PluginDispatcher.h"
#import "PluginProtocol.h"
#import "Model.h"
#import "BaseViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, strong, readonly) UIView *player;

@property (nonatomic, strong, readonly) MainView *mainView;

@property (nonatomic, strong, readonly) PluginDispatcher<PluginProtocol> *pluginDispatcher;

- (void)addPlugin:(__strong id<PluginProtocol>)plugin;
- (void)removePlugin:(__strong id<PluginProtocol>)plugin;


- (void)loadWithModel:(Model *)model;
- (void)setupPlugins;


@end

NS_ASSUME_NONNULL_END
