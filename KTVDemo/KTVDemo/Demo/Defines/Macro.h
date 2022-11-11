//
//  Macro.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import <Foundation/Foundation.h>

#ifndef Macro_h
#define Macro_h

/// 在主线程执行Block
#define RunBlockInMainThread(block) if ([NSThread isMainThread]) { \
block(); \
} else { \
dispatch_async(dispatch_get_main_queue(), block); \
}


#endif
