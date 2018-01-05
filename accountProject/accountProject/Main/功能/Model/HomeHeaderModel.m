//
//  HomeHeaderModel.m
//  accountProject
//
//  Created by 弘鼎 on 2018/1/2.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import "HomeHeaderModel.h"

@implementation HomeHeaderModel
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"id":@"Id"}];
}
@end
