//
//  WeakProxy.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakProxy : NSProxy

@property(nonatomic, weak) id value;

+ (id)weak:(__weak id)value;
+ (id)strong:(__strong id)value;

@end

NS_ASSUME_NONNULL_END
