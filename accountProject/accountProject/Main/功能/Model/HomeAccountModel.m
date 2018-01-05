//
//  HomeAccountModel.m
//  accountProject
//
//  Created by 弘鼎 on 2018/1/2.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import "HomeAccountModel.h"

@implementation HomeAccountModel
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"id":@"Id"}];
    //    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Id"}];
}
@end
