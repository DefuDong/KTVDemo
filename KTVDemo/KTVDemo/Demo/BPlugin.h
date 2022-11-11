//
//  BPlugin.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import <Foundation/Foundation.h>
#import "PluginProtocol.h"
#import "BaseViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPlugin : NSObject <PluginProtocol, BaseViewControllerDelegate>

@end

NS_ASSUME_NONNULL_END
