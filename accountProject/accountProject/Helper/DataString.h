//
//  DataString.h
//  accountProject
//
//  Created by 弘鼎 on 2018/2/1.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataString : NSObject
//获取当前日期
+ (NSString *)getNowData;
//获取当前日期
+ (NSString *)getYesterdayData;
//获取一周前日期
+ (NSString *)getWeekBeforeData;
//获取一月前日期
+ (NSString *)getMonthBeforeData;
//获取三个月前日期
+ (NSString *)getThreeMonthBeforeData;
+ (NSString *)getBeforeData:(NSInteger )number;
@end
