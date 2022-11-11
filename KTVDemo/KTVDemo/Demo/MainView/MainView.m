//
//  MainView.m
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import "MainView.h"
#import "Macro.h"

ViewLevel const ViewLevel1 = 1;
ViewLevel const ViewLevel2 = 2;

@interface MainView ()

@end


@implementation MainView

- (void)update {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addComponentView];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if( newSuperview) {
        [self update];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)addComponentView {
 }

#pragma mark - MainViewProtocol
- (void)addComponent:(UIView *)component {
    dispatch_block_t block = ^{
        [self addSubview:component];
    };
    RunBlockInMainThread(block);
}

- (void)addComponent:(UIView *)component atLevel:(ViewLevel)level {
    dispatch_block_t block = ^{
        [self addSubview:component atLevel:level];
    };
    RunBlockInMainThread(block);
}

- (void)replaceComponent:(UIView *)component atLevel:(ViewLevel)level {
    dispatch_block_t block = ^{
        [self replaceSubview:component atLevel:level];
        
    };
    RunBlockInMainThread(block);
}

- (void)removeComponentAtLevel:(ViewLevel)level {
    dispatch_block_t block = ^{
        UIView *exist = (UIView *) [self viewAtLevel:level];
        if (exist) {
            if ([exist superview] == self) {
                [exist removeFromSuperview];
            }
        }
    };
    RunBlockInMainThread(block);
}

- (void)removeComponentAtFloatLevel:(ViewFloatLevel)floatLevel {
    dispatch_block_t block = ^{
        UIView *exist = (UIView *) [self viewAtFloatLevel:floatLevel];
        if (exist) {
            if ([exist superview] == self) {
                [exist removeFromSuperview];
            }
        }
    };
    RunBlockInMainThread(block);
}

- (void)removeComponent:(UIView *)component {
    dispatch_block_t block = ^{
        
        if ([component superview] == self) {
            [component removeFromSuperview];
        }
    };
    RunBlockInMainThread(block);
}

- (void)addComponent:(UIView *)component atFloatLevel:(ViewFloatLevel)floatLevel {
    dispatch_block_t block = ^{
        [self addSubview:component atFloatLevel:floatLevel];
    };
    RunBlockInMainThread(block);
}


@end
