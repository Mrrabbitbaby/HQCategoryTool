//
//  UIView+HQLine.h
//  CustomToolDemo
//
//  Created by 胡忠立 on 16/9/20.
//  Copyright © 2016年 胡忠立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HQLine)

+ (UIView*)creatLineFromHorizontalOriginX:(CGFloat)x originY:(CGFloat)y width:(CGFloat)width;

+ (UIView*)creatLineFromVerticalOriginX:(CGFloat)x originY:(CGFloat)y height:(CGFloat)height;

@end
