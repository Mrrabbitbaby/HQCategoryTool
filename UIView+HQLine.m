//
//  UIView+HQLine.m
//  CustomToolDemo
//
//  Created by 胡忠立 on 16/9/20.
//  Copyright © 2016年 胡忠立. All rights reserved.
//

#import "UIView+HQLine.h"

#define LINECOLOR  [UIColor colorWithDisplayP3Red:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0]

@implementation UIView (HQLine)

+ (UIView*)creatLineFromHorizontalOriginX:(CGFloat)x originY:(CGFloat)y width:(CGFloat)width
{
    return [self initWithViewRect:CGRectMake(x, y, width, 0.5) color:LINECOLOR];
}

+ (UIView*)creatLineFromVerticalOriginX:(CGFloat)x originY:(CGFloat)y height:(CGFloat)height
{
    return [self initWithViewRect:CGRectMake(x, y, 0.5, height) color:LINECOLOR];
}

+ (UIView*)initWithViewRect:(CGRect)frame color:(UIColor*)color
{
    UIView* lineView = [UIView new];
    lineView.backgroundColor = color;
    lineView.frame = frame;
    return lineView;
}
@end
