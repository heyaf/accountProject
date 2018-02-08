//
//  DataString.m
//  accountProject
//
//  Created by 弘鼎 on 2018/2/1.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import "DataString.h"

@implementation DataString
//获取当前日期
+ (NSString *)getNowData{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
    
    return currentDateStr;
}
+ (NSString *)getYesterdayData{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //一周的秒数
    NSTimeInterval time = 1 * 24 * 60 * 60;
    //下周就把"-"去掉
    NSDate *lastWeek = [date dateByAddingTimeInterval:-time];
    NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
    return startDate;
}

//获取一周前日期
+ (NSString *)getWeekBeforeData{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //一周的秒数
    NSTimeInterval time = 7 * 24 * 60 * 60;
    //下周就把"-"去掉
    NSDate *lastWeek = [date dateByAddingTimeInterval:-time];
    NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
    return startDate;
}

//获取一月前日期
+ (NSString *)getMonthBeforeData{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    //一周的秒数
    NSTimeInterval time = 30 * 24 * 60 * 60;
    //下周就把"-"去掉
    NSDate *lastWeek = [date dateByAddingTimeInterval:-time];
    NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
    return startDate;
}
+ (NSString *)getThreeMonthBeforeData{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    //一周的秒数
    NSTimeInterval time = 90 * 24 * 60 * 60;
    //下周就把"-"去掉
    NSDate *lastWeek = [date dateByAddingTimeInterval:-time];
    NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
    return startDate;
}
+ (NSString *)getBeforeData:(NSInteger ) number{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //一周的秒数
    NSTimeInterval time = number * 24 * 60 * 60;
    //下周就把"-"去掉
    NSDate *lastWeek = [date dateByAddingTimeInterval:-time];
    NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
    return startDate;
}
@end
