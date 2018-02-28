//
//  AppDelegate+Serve.h
//  accountProject
//
//  Created by 弘鼎 on 2017/12/29.
//  Copyright © 2017年 贺亚飞. All rights reserved.
//

#import "AppDelegate.h"

@class SingleUser;
@interface AppDelegate (Serve)
-(void)initWindow;

-(SingleUser *)getusermodel;
- (void)checkWarningMessages;
@end
