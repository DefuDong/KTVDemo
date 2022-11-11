//
//  ASocketDelegate.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ASocketDelegate <NSObject>

@optional
- (void)didConnect;

@end

NS_ASSUME_NONNULL_END
