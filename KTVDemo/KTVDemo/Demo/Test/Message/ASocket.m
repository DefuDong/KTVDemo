//
//  ASocket.m
//  KTVDemo
//
//  Created by 董德富 on 2022/11/7.
//

#import "ASocket.h"
#import "ASocketDelegate.h"

@implementation ASocket

- (void)test {
    [(id<ASocketDelegate>)self.pluginDispatcher didConnect];
}

@end
