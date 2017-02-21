//
//  NSString+HQString.h
//  CustomToolDemo
//
//  Created by 胡忠立 on 2016/10/26.
//  Copyright © 2016年 胡忠立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (HQString)


#pragma mark  减方法(-方法)
/**
 计算self这个文件夹\文件的大小
 
 @return 文件大小
 */
- (unsigned long long)getFileSize;

/**
 将self这个字符串进行MD5加密
 
 @return 加密好的字符串
 */
- (NSString*)md5HexDigest;

/**
 根据self字符串和文字大小返回宽高
 
 @param font 字体大小
 
 @return 字体宽高
 */
- (CGSize)getCharactersWithFont:(UIFont*)font;

/**
 检查字符串中是否包含空格
 
 @return YES:有，NO:无
 */
- (BOOL)checkContainSpace;

/**
 检查字符串中是否全是数字
 
 @return YES:是；NO:不是
 */
- (BOOL)checkIsAllNumber;

/**
 检查是否为邮箱
 
 @return YES:是；NO:不是
 */
- (BOOL)checkIsEmail;

/**
 验证手机号码合法性（正则）
 
 @return yes: 合法 no: 非法
 */
- (BOOL)checkIsPhoneNumber;

/**
 有效的字母数字密码
 
 @return YES:是；NO:不是
 */
- (BOOL)checkIsValidAlphaNumberPassword;

/**
 计算self这个时间与当前时间的差（精确）
 
 @return 提示字符串
 */
- (NSString *)compareWithCurrentTimeDistance;

+ (NSInteger)compareWithTwoTimeByJetLag:(NSDate *)timeOne timeTwo:(NSDate*)timeTwo;

/**
 去掉前后空格
 
 @return 去掉后的字符串
 */
- (NSString *)removeAfterAndBeforeSpace;

#pragma mark -- 类方法（+方法）

/**
 通过时间戳和格式显示时间
 
 @param timestamp 时间戳
 @param formatter 日期格式
 
 @return 日期字符串
 */
+ (NSString *)getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString*)formatter;

@end
