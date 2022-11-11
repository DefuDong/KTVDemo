//
//  LevelView.h
//  KTVDemo
//
//  Created by 董德富 on 2022/11/6.
//

#import <UIKit/UIKit.h>

typedef NSUInteger ViewLevel;
typedef CGFloat ViewFloatLevel;


NS_ASSUME_NONNULL_BEGIN

@interface LevelView : UIView

- (UIView *)viewAtLevel:(ViewLevel)level;
- (void)addSubview:(UIView *)view atLevel:(ViewLevel)level;
- (void)replaceSubview:(UIView *)view atLevel:(ViewLevel)level;
- (void)updateSubviewLevels;

- (UIView *)viewAtFloatLevel:(ViewFloatLevel)floatLevel;
- (void)addSubview:(UIView *)view atFloatLevel:(ViewFloatLevel)floatLevel;
- (void)replaceSubview:(UIView *)view atFloatLevel:(ViewFloatLevel)floatLevel;

@end


@interface UIView (LevelManagement)

@property(nonatomic, assign) ViewLevel viewLevel;

@property(nonatomic, assign) ViewFloatLevel viewFloatLevel;

@end


NS_ASSUME_NONNULL_END
