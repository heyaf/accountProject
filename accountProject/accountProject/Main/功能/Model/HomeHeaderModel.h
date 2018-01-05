//
//  HomeHeaderModel.h
//  accountProject
//
//  Created by 弘鼎 on 2018/1/2.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeHeaderModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*date;
@property (nonatomic, strong) NSString <Optional>*Title;
@property (nonatomic, strong) NSString <Optional>*number;
@end
