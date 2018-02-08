//
//  AlarmModel.h
//  accountProject
//
//  Created by 弘鼎 on 2018/1/2.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AlarmModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*content;
@property (nonatomic, strong) NSString <Optional>*lookStatus;
@property (nonatomic, strong) NSString <Optional>*sendTime;
@property (nonatomic, strong) NSString <Optional>*smsId;

@end
