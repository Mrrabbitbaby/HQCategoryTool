//
//  NSDictionary+HQDictionary.m
//  CustomToolDemo
//
//  Created by 胡忠立 on 2016/11/23.
//  Copyright © 2016年 胡忠立. All rights reserved.
//

#import "NSDictionary+HQDictionary.h"

@implementation NSDictionary (HQDictionary)

+ (NSData*)dictionaryForData
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}

@end
