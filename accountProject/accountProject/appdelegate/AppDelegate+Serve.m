//
//  AppDelegate+Serve.m
//  accountProject
//
//  Created by 弘鼎 on 2017/12/29.
//  Copyright © 2017年 贺亚飞. All rights reserved.
//

#import "AppDelegate+Serve.h"
#import "DWTabBarController.h"

@implementation AppDelegate (Serve)
#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    self.window.rootViewController = [[DWTabBarController alloc] init];;
    
    
}

@end
