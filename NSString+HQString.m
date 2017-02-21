//
//  NSString+HQString.m
//  CustomToolDemo
//
//  Created by 胡忠立 on 2016/10/26.
//  Copyright © 2016年 胡忠立. All rights reserved.
//

#import "NSString+HQString.h"
#import <CommonCrypto/CommonDigest.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation NSString (HQString)

#pragma mark -- 减方法（-方法）

- (unsigned long long)getFileSize
{
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 文件类型
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    NSString *fileType = attrs.fileType;
    if ([fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
        // 获得文件夹的遍历器
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        // 总大小
        unsigned long long fileSize = 0;
        // 遍历所有子路径
        for (NSString *subpath in enumerator) {
            // 获得子路径的全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        return fileSize;
    }
    // 文件
    return attrs.fileSize;
}

- (CGSize)getCharactersWithFont:(UIFont *)font
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:NULL].size;
    return size;
}

- (NSString*)md5HexDigest
{
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];//%02x:当x为小写时，加密结果为小写，X为大写时加密结果为大写。
    }
    return ret;
}

- (BOOL)checkContainSpace
{
    BOOL containSpace = NO;
    NSString *space = @" ";
    for (NSInteger i = 0; i < self.length; i++) {
        NSString *text = [self substringWithRange:NSMakeRange(i, 1)];
        if ([text isEqualToString:space]) {
            containSpace = YES;
            break;
        }
    }
    return containSpace;
}

- (BOOL)checkIsAllNumber
{
    NSScanner * scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)checkIsEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)checkIsPhoneNumber
{
    NSString* const mobile = @"^1(3|4|5|7|8)\\d{9}$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    return [predicate evaluateWithObject:self];
}

- (BOOL)checkIsValidAlphaNumberPassword
{
    NSString *regex = @"^(?!\\d+$|[a-zA-Z]+$)\\w{6,12}$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [identityCardPredicate evaluateWithObject:self];
}

- (NSString*)compareWithCurrentTimeDistance
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * date = [NSDate date];
    NSDate * compareDate = [formatter dateFromString:self];
    
    //时区问题
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    NSDate * localDate = [date dateByAddingTimeInterval:interval];
    compareDate = [compareDate dateByAddingTimeInterval:interval];
    
    formatter = nil;
    
    NSTimeInterval compareInterval = [compareDate timeIntervalSince1970]*1;
    NSTimeInterval nowInterval = [localDate timeIntervalSince1970]*1;
    NSTimeInterval cha = nowInterval - compareInterval;
    
    NSString * result;
    
    if (cha/3600 < 1) {
        result = [NSString stringWithFormat:@"%f",cha/60];
        //去掉小数点后的长度
        result = [result substringToIndex:result.length-7];
        result = [NSString stringWithFormat:@"%@分钟前",result];
    }
    if (cha/60 < 1) {
        result = @"刚刚";
    }
    if (cha/3600 > 1 && cha/86400 < 1) {
        result = [NSString stringWithFormat:@"%f",cha/3600];
        result = [result substringToIndex:result.length - 7];
        result = [NSString stringWithFormat:@"%@小时前",result];
    }
    if (cha/86400 > 1) {
        result = [NSString stringWithFormat:@"%f",cha/86400];
        result = [result substringToIndex:result.length - 7];
        result = [NSString stringWithFormat:@"%@天前",result];
    }
    if (cha/(86400*30)>1) {
        result = [self substringToIndex:10];
    }
    
    return result;
}

+ (NSInteger)compareWithTwoTimeByJetLag:(NSDate *)timeOne timeTwo:(NSDate*)timeTwo
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *d = [cal components:unitFlags fromDate:timeOne toDate:timeTwo options:0];
    NSInteger sec = [d day];
    return sec;
}


//去掉前后空格
- (NSString *)removeAfterAndBeforeSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
}

#pragma mark -- 类方法（+方法）

+ (NSString*)getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString *)formatter
{
    if ([NSString stringWithFormat:@"%@", @(timestamp)].length == 13) {
        timestamp /= 1000.0f;
    }
    NSDate*timestampDate=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *strDate = [dateFormatter stringFromDate:timestampDate];
    
    return strDate;
}

@end
