//
//  HomeHeaderModel.h
//  accountProject
//
//  Created by 弘鼎 on 2018/1/2.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeHeaderModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*EnergyKind;
@property (nonatomic, strong) NSString <Optional>*companyCode;
@property (nonatomic, strong) NSString <Optional>*groupCode;
@property (nonatomic, strong) NSString <Optional>*orgName;
@property (nonatomic, strong) NSString <Optional>*useDate;
@property (nonatomic, strong) NSString <Optional>*useLevel;

@end
