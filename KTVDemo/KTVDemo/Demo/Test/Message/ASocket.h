//
//  ASocket.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/7.
//

#import <Foundation/Foundation.h>
#import "PluginDispatcher.h"
#import "ASocketDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASocket : NSObject<ASocketDelegate>

@property (nonatomic, strong) PluginDispatcher *pluginDispatcher;

@end

NS_ASSUME_NONNULL_END
