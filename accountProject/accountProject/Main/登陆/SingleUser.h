//
//  SingleUser.h
//  accountProject
//
//  Created by 弘鼎 on 2018/1/29.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleUser : NSObject<NSCopying,NSMutableCopying>
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *realName;
@property (nonatomic,copy) NSString *orgCode;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *departid;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *mobilphone;
@property (nonatomic,copy) NSString *signatureFile; //>头像图片路径
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,assign) BOOL *success;

//实例化一个类方法、返回一个单例对象
+ (instancetype)shareTools;
@end
