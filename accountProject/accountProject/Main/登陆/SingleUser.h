//
//  SingleUser.h
//  accountProject
//
//  Created by 弘鼎 on 2018/1/29.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleUser :JSONModel <NSCopying,NSMutableCopying,NSCoding>
@property (nonatomic,copy) NSString <Optional>*account;
@property (nonatomic,copy) NSString <Optional>*departid;
@property (nonatomic,copy) NSString <Optional>*email;
@property (nonatomic,copy) NSString <Optional>*mobilephone;
@property (nonatomic,copy) NSString <Optional>*orgCode;
@property (nonatomic,copy) NSString <Optional>*realName;
@property (nonatomic,copy) NSString <Optional>*signature;
@property (nonatomic,copy) NSString <Optional>*signatureFile; //>头像图片路径
@property (nonatomic,copy) NSString <Optional>*msg;
@property (nonatomic,copy) NSString <Optional>*userId;
@property (nonatomic,copy) NSString <Optional>*orgType;


@property (nonatomic,assign) BOOL success;

////实例化一个类方法、返回一个单例对象
//+ (instancetype)shareTools;
@end
