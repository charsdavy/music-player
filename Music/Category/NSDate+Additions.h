//
//  NSDate+Additions.h
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

/**
 *  获取点分格式日期字符串
 */
-(NSString *)dateDotString;

/**
 *  获取短横线分割格式日期字符串
 */
-(NSString *)dateStrigulaString;

/**
 *  获取点分格式时间字符串
 */
-(NSString *)dateTimeDotString;

/**
 *  获取短横线分割格式时间字符串
 */
-(NSString *)dateTimeStrigulaString;

-(NSString *)shortDateString;
-(NSString *)shortTimeString;

-(NSString *)longTimeString;
-(NSString *)shortDateTimeString;

-(long long)milseconds;

+(NSDate *)dateFromYYYYMMDD:(NSString *)dateString;
+(NSDate *)dateWithYear:(int)year;

+ (NSString *) getTimeDiffString:(NSDate *) temp;

@end
