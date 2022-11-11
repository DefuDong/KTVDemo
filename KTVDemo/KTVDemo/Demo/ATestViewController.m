//
//  ATestViewController.m
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import "ATestViewController.h"
#import "APlugin.h"
#import "BPlugin.h"
#import "ASocket.h"
#import "WeakProxy.h"

@interface ATestViewController ()

@end

@implementation ATestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ASocket *socket = [[ASocket alloc] init];
    [socket.pluginDispatcher addPlugin:[WeakProxy weak:self.pluginDispatcher]];
}

- (void)setupPlugins {
    [super setupPlugins];
    [self addPlugin:[[APlugin alloc] init]];
 }



@end
