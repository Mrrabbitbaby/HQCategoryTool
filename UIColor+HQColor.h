//
//  UIColor+HQColor.h
//  CustomToolDemo
//
//  Created by 胡忠立 on 2016/10/26.
//  Copyright © 2016年 胡忠立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HQColor)

/**
 根据哈希码取得颜色
 
 @param hex 哈希码
 
 @return 颜色对象
 */
+ (UIColor *)colorWithHex:(uint)hex;

/**
 *  十六进制字符串转颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)HexString;

@end
