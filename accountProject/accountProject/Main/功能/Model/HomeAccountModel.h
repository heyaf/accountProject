//
//  HomeAccountModel.h
//  accountProject
//
//  Created by 弘鼎 on 2018/1/2.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeAccountModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*imageName;
@property (nonatomic, strong) NSString <Optional>*url;


@end
