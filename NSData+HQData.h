//
//  NSData+HQData.h
//  CustomToolDemo
//
//  Created by 胡忠立 on 2016/10/26.
//  Copyright © 2016年 胡忠立. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HQData)

/**
 Data类型转换为Base64
 
 @param length 长度
 
 @return base64字符串
 */
- (NSString *)base64StringLength:(NSUInteger)length;

/**
 转成字典

 @return 返回字典 
 */
- (NSDictionary*)dataForDictionary;

@end
