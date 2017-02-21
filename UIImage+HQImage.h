//
//  UIImage+HQImage.h
//  CustomToolDemo
//
//  Created by 胡忠立 on 2016/10/26.
//  Copyright © 2016年 胡忠立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HQImage)

/**
 根据颜色获取图片
 
 @param color 颜色
 
 @return 返回图片
 */
+ (UIImage*)imageFromRGB:(UIColor*)color;

@end
