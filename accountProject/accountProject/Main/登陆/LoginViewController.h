//
//  LoginViewController.h
//  accountProject
//
//  Created by 弘鼎 on 2018/1/8.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^RegistBlock)(void);

@interface LoginViewController : UIViewController
@property (nonatomic,copy) RegistBlock myRegistblock;

@end
