//
//  APlugin.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PluginProtocol.h"
#import "BaseViewControllerDelegate.h"
#import "MainView.h"
#import "ASocketDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface APlugin : NSObject <PluginProtocol, BaseViewControllerDelegate, ASocketDelegate>

@end

NS_ASSUME_NONNULL_END
