//
//  BaseViewControllerDelegate.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import <Foundation/Foundation.h>

@class BaseViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol BaseViewControllerDelegate <NSObject>

@optional
- (void)viewControllerViewWillAppear:(BaseViewController *)viewController;
- (void)viewControllerViewDidAppear:(BaseViewController *)viewController;
- (void)viewControllerViewWillDisAppear:(BaseViewController *)viewController;
- (void)viewControllerViewDidDisAppear:(BaseViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
