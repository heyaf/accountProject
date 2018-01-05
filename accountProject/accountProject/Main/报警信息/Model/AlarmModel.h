//
//  AlarmModel.h
//  accountProject
//
//  Created by 弘鼎 on 2018/1/2.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AlarmModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*errorStr;
@property (nonatomic, strong) NSString <Optional>*numStr;
@property (nonatomic, strong) NSString <Optional>*date;
@end
