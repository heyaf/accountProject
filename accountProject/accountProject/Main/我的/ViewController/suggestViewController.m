//
//  suggestViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/29.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "suggestViewController.h"
#import "XXTextView.h"

@interface suggestViewController ()

@property (nonatomic,strong) UIButton *LoginBtn;

@property (nonatomic,strong) XXTextView *suggestTextview;



@end

@implementation suggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(242, 242, 242);
   
    self.navigationItem.title = @"用户反馈";
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];


    [self creatUI];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   self.navigationController.navigationBarHidden = NO;
     self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)creatUI{

    _suggestTextview = [[XXTextView alloc] initWithFrame:CGRectMake(20, HYFNavAndStatusHeight+20, kScreenWidth-40, 130)];
    _suggestTextview.backgroundColor = KWhiteColor;
    _suggestTextview.xx_placeholderFont = [UIFont systemFontOfSize:16.0f];
    _suggestTextview.xx_placeholderColor = KGrayColor;
    _suggestTextview.xx_placeholder = @"请输入您的宝贵意见，我们将第一时间关注，不断优化和改进！";
    [self.view addSubview:_suggestTextview];
 

    _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _LoginBtn.layer.masksToBounds = YES;
    _LoginBtn.layer.cornerRadius = 3.0;
    [_LoginBtn setBackgroundColor:[UIColor whiteColor]];
    [_LoginBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_LoginBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _LoginBtn.backgroundColor = KSelectColor;
    [self.view addSubview:_LoginBtn];
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_suggestTextview).with.offset(130+30);
        make.left.mas_equalTo(_suggestTextview);
        make.right.mas_equalTo(_suggestTextview);
        make.height.offset(40.0);
    }];
}

- (void)submit{
    if (_suggestTextview.text.length==0) {
        [SVProgressHUD showWithStatus:@"请输入您的宝贵意见"];
        [SVProgressHUD dismissWithDelay:1.0];
    }else{

                [SVProgressHUD showSuccessWithStatus:@"谢谢您的支持"];
                [SVProgressHUD dismissWithDelay:1.0];
                [self.navigationController popViewControllerAnimated:YES];

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
