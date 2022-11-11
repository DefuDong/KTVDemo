//
//  LevelView.m
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import "LevelView.h"
#import <objc/runtime.h>
#import "Macro.h"

@implementation LevelView

- (UIView *)viewAtLevel:(ViewLevel)level {
    return [self viewAtFloatLevel:(ViewFloatLevel)level];
}

- (UIView *)viewAtFloatLevel:(ViewFloatLevel)floatLevel {
    for (UIView *view in [self subviews]) {
        if ([view viewFloatLevel] == floatLevel) {
            return view;
        }
    }
    return nil;
}

- (void)addSubview:(UIView *)view atLevel:(ViewLevel)level {
    [self addSubview:view atFloatLevel:(ViewFloatLevel)level];
}

- (void)addSubview:(UIView *)view atFloatLevel:(ViewFloatLevel)floatLevel {
    view.viewFloatLevel = floatLevel;
    [self addSubview:view];
}

- (void)addSubview:(UIView *)view {
    dispatch_block_t block = ^{
        [super addSubview:view];
        if ([view viewFloatLevel] > 0) {
            [self updateSubviewLevels];
        }
    };
    RunBlockInMainThread(block);
}

- (void)replaceSubview:(UIView *)view atLevel:(ViewLevel)level {
    [self replaceSubview:view atFloatLevel:(ViewFloatLevel)level];
}

- (void)replaceSubview:(UIView *)view atFloatLevel:(ViewFloatLevel)floatLevel {
    view.viewFloatLevel = floatLevel;
    [self addSubview:view];
}

- (void)updateSubviewLevels {
    NSArray *sorted = [[self subviews] sortedArrayUsingComparator:^NSComparisonResult(UIView *obj1, UIView *obj2) {
        CGFloat diff = (CGFloat)obj1.viewFloatLevel - (CGFloat)obj2.viewFloatLevel;
        if (diff == 0) {
            return NSOrderedSame;
        } else if (diff > 0) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    
    for (UIView *view in sorted) {
        [self bringSubviewToFront:view];
        if ([[view class] isSubclassOfClass:[LevelView class]]) {
            [(LevelView *)view updateSubviewLevels];
        }
    }
}



@end


static char kViewFloatLevel;

@implementation UIView (LevelManagement)

@dynamic viewLevel;
@dynamic viewFloatLevel;

- (void)setViewLevel:(ViewLevel)viewLevel {
    [self setViewFloatLevel:(ViewFloatLevel)viewLevel];
}

- (void)setViewFloatLevel:(ViewFloatLevel)viewFloatLevel {
    objc_setAssociatedObject(self, &kViewFloatLevel, @(viewFloatLevel), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ViewLevel)viewLevel {
    return (ViewLevel)[self viewFloatLevel];
}

- (ViewFloatLevel)viewFloatLevel {
    return [(NSNumber *)objc_getAssociatedObject(self, &kViewFloatLevel) floatValue];
}

@end
