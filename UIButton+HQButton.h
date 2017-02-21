//
//  UIButton+HQButton.h
//  CustomToolDemo
//
//  Created by 胡忠立 on 16/9/26.
//  Copyright © 2016年 胡忠立. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HQPostionType) {
    HQPostionWithTypeLeft = 0,
    HQPostionWithTypeRight,
    HQPostionWithTypeTop,
    HQPostionWithTypeBottom,
};

@interface UIButton (HQButton)

#pragma mark -- 类方法

+ (UIButton*)aq_initWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)titleColor clickBlock:(void(^)(id sender))finish;

+ (UIButton*)aq_initWithFrame:(CGRect)frame image:(NSString*)image clickBlock:(void(^)(id sender))finish;

+ (UIButton*)aq_initWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)titleColor image:(NSString*)image iType:(HQPostionType)iType clickBlock:(void(^)(id sender))finish;

#pragma mark -- 减方法（—）

/**
 时间计时按钮

 @param timeout    总时间
 @param tittle     默认显示标题
 @param waitTittle 计时中的显示标题
 */
-(void)aq_startTime:(NSInteger )timeout title:(NSString *)tittle waitTitle:(NSString *)waitTittle;

/**
 计算button文字和图片位置

 @param iType   位置类型
 @param spacing 间隔
 */
- (void)aq_setImagePostionType:(HQPostionType)iType spacing:(CGFloat)spacing;


@end

typedef void(^touchFinishBlock)(id sender);

@interface UIButton (HQButtonBlock)

- (void)addButtonClickBlock:(touchFinishBlock)finish;

@end
