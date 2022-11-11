//
//  MainView.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import <UIKit/UIKit.h>
#import "LevelView.h"

UIKIT_EXTERN const ViewLevel ViewLevel1;
UIKIT_EXTERN const ViewLevel ViewLevel2;


NS_ASSUME_NONNULL_BEGIN

@interface MainView : LevelView

@property (nonatomic, readonly, strong) UIView *player;
// 默认加载view
@property (nonatomic, strong) UIView *loadingView;
// 默认失败view
@property (nonatomic, strong) UIView *failView;


- (void)addComponent:(UIView *)component;

- (void)addComponent:(UIView *)component atLevel:(ViewLevel)level;

- (void)replaceComponent:(UIView *)component atLevel:(ViewLevel)level;

- (void)removeComponentAtLevel:(ViewLevel)level;

- (void)removeComponent:(UIView *)component;


@end

NS_ASSUME_NONNULL_END
