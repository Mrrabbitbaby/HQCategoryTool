//
//  UIButton+HQButton.m
//  CustomToolDemo
//
//  Created by 胡忠立 on 16/9/26.
//  Copyright © 2016年 胡忠立. All rights reserved.
//

#import "UIButton+HQButton.h"
#import <objc/runtime.h>

@implementation UIButton (HQButton)

+ (UIButton*)aq_initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor clickBlock:(void (^)(id))finish
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addButtonClickBlock:finish];
    return btn;
}

+ (UIButton*)aq_initWithFrame:(CGRect)frame image:(NSString *)image clickBlock:(void (^)(id))finish
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addButtonClickBlock:finish];
    return btn;
}

+ (UIButton*)aq_initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor image:(NSString *)image iType:(HQPostionType)iType clickBlock:(void (^)(id))finish
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [UIColor greenColor].CGColor;
    [btn setAdjustsImageWhenHighlighted:NO];
    btn.layer.borderWidth = 0.5;
    [btn addButtonClickBlock:finish];
    [btn aq_setImagePostionType:iType spacing:2.0];
    
    return btn;
}

#pragma mark -- 减方法（—）

-(void)aq_startTime:(NSInteger )timeout title:(NSString *)tittle waitTitle:(NSString *)waitTittle{
    __block NSInteger timeOut = timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut <= 0){
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:tittle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeOut % 60 == 0 ? 60 : timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,waitTittle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (void)aq_setImagePostionType:(HQPostionType)iType spacing:(CGFloat)spacing
{
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    CGFloat imageOffsetX = (imageWith + labelWidth) / 2 - imageWith / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWith + labelWidth / 2) - (imageWith + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    switch (iType) {
        case HQPostionWithTypeLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            break;
            
        case HQPostionWithTypeRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight + spacing/2), 0, imageHeight + spacing/2);
            break;
            
        case HQPostionWithTypeTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            break;
            
        case HQPostionWithTypeBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            break;
            
        default:
            break;
    }
}

@end

#pragma mark -- BlockButton

static const char btnKey;

@implementation UIButton (HQButtonBlock)

- (void)addButtonClickBlock:(touchFinishBlock)finish
{
    if (finish) {
        objc_setAssociatedObject(self, &btnKey, finish, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionClick:(id)sender
{
    touchFinishBlock block = objc_getAssociatedObject(self, &btnKey);
    block(sender);
}

@end

