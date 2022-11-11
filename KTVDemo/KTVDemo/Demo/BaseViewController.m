//
//  BaseViewController.m
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, strong, readwrite) UIView *player;
@property (nonatomic, strong, readwrite) MainView *mainView;
@property (nonatomic, strong, readwrite) PluginDispatcher<PluginProtocol> *pluginDispatcher;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [(id<BaseViewControllerDelegate>)self.pluginDispatcher viewControllerViewWillAppear:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [(id<BaseViewControllerDelegate>)self.pluginDispatcher viewControllerViewDidAppear:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [(id<BaseViewControllerDelegate>)self.pluginDispatcher viewControllerViewWillDisAppear:self];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [(id<BaseViewControllerDelegate>)self.pluginDispatcher viewControllerViewDidDisAppear:self];
}


- (void)dealloc {
    [(id<PluginProtocol>) _pluginDispatcher pluginWillUnload];
    [(id<PluginProtocol>) _pluginDispatcher pluginDidUnload];
}

- (void)addPlugin:(__strong id<PluginProtocol>)plugin {
    NSAssert(plugin, @"Parameter not nil");
    
    if (plugin) {
        if ([plugin conformsToProtocol:@protocol(PluginProtocol)]) {
            plugin.viewController = self;
            plugin.mainView = self.mainView;
        }
        // plugin的didload事件不会重复发送
        if (![_pluginDispatcher.allPlugins containsObject:plugin]) {
            [_pluginDispatcher addPlugin:(id<BaseViewControllerDelegate>)plugin];
            if (self.mainView
                && self.player
                && [plugin conformsToProtocol:@protocol(PluginProtocol)]
                && [plugin respondsToSelector:@selector(pluginDidLoad)] ) {
                [plugin pluginDidLoad];
            }
        }
    }
}

- (void)removePlugin:(__strong id<PluginProtocol>)plugin {
    [_pluginDispatcher removePlugin:plugin];
    
    if ([plugin conformsToProtocol:@protocol(PluginProtocol)]
       && [plugin respondsToSelector:@selector(pluginDidUnload)]) {
        [plugin pluginDidUnload];
        plugin.viewController = nil;
        plugin.mainView = nil;
    }
}


- (void)loadWithModel:(Model *)model {
    [self setupPlugins];
}

- (void)setupPlugins {
    
}

- (PluginDispatcher<PluginProtocol> *)pluginDispatcher {
    if (!_pluginDispatcher ) {
        _pluginDispatcher = [[PluginDispatcher<PluginProtocol> alloc] init];
    }
    return _pluginDispatcher;
}

@end
