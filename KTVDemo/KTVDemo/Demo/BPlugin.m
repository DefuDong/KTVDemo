//
//  BPlugin.m
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import "BPlugin.h"
#import "MainView.h"

@implementation BPlugin
@synthesize viewController;
@synthesize mainView;

- (void)pluginDidLoad {
    [self.mainView addComponent:[UIView new]];
}

- (void)pluginDidUnload {
    
}

- (void)viewControllerViewWillAppear:(BaseViewController *)viewController {
    NSLog(@"%s", __func__);
}

- (void)viewControllerViewDidAppear:(BaseViewController *)viewController {
    NSLog(@"%s", __func__);
}

@end
