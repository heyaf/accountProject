//
//  SubnameViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/30.
//  Copyright © 2017年 rongcloud. All rights reserved.
//
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？


#import "SubnameViewController.h"
#import "ZXTextField.h"
#import <Masonry.h>

@interface SubnameViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) ZXTextField *TelText;
@property (nonatomic,strong) ZXTextField *PassText;
@property (nonatomic,strong) ZXTextField *MakeSureText;

@property (nonatomic,strong) UIButton *LoginBtn;


@end

@implementation SubnameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =RGB(242, 242, 242);
    self.navigationItem.title = @"重置密码";
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);

    [self AddViewloginOrOut];
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)AddViewloginOrOut{
    
    
    CGRect accountF = CGRectMake(10, HYFNavAndStatusHeight+30, kScreenWidth-20, 40);
    ZXTextField *TELText = [[ZXTextField alloc]initWithFrame:accountF withIcon:nil withPlaceholderText:@"当前密码"];
    TELText.inputText.tag=204;
    TELText.inputText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    TELText.inputText.autocorrectionType = UITextAutocorrectionTypeNo;
    TELText.inputText.keyboardType = UIKeyboardTypeASCIICapable;
    TELText.inputText.textColor = KBlackColor;
    TELText.frame = accountF;
    TELText.inputText.delegate = self;
    [self.view addSubview:TELText];
    self.TelText = TELText;
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = KGrayColor;
    [self.view addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TELText).with.offset(40);
        make.left.mas_equalTo(TELText).with.offset(30);
        make.right.mas_equalTo(TELText).with.offset(-30);
        make.height.offset(1);
    }];
    
    ZXTextField *textfild = [[ZXTextField alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 40) withIcon:nil withPlaceholderText:@"新密码"];
    textfild.inputText.tag = 205;
    textfild.inputText.textColor = KBlackColor;
    textfild.inputText.secureTextEntry = YES;
    textfild.inputText.autocorrectionType = UITextBorderStyleNone;
    textfild.inputText.autocorrectionType = UITextAutocorrectionTypeNo;
    textfild.inputText.keyboardType = UIKeyboardTypeASCIICapable;
    textfild.inputText.delegate = self;
    [self.view addSubview:textfild];
    self.PassText = textfild;
    
    [textfild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TELText).with.offset(65);
        make.left.mas_equalTo(TELText);
        make.right.mas_equalTo(TELText);
        make.height.offset(40);
    }];
    UIView *lineview1 = [[UIView alloc] init];
    lineview1.backgroundColor = KGrayColor;
    [self.view addSubview:lineview1];
    [lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild).with.offset(40);
        make.left.mas_equalTo(TELText).with.offset(30);
        make.right.mas_equalTo(TELText).with.offset(-30);
        make.height.offset(1);
    }];
    
    ZXTextField *textfild1 = [[ZXTextField alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 40) withIcon:nil withPlaceholderText:@"确认新密码"];
    textfild1.inputText.tag = 206;
    textfild1.inputText.secureTextEntry = YES;
    textfild1.inputText.autocorrectionType = UITextBorderStyleNone;
    textfild1.inputText.autocorrectionType = UITextAutocorrectionTypeNo;
    textfild1.inputText.keyboardType = UIKeyboardTypeASCIICapable;
    textfild1.inputText.delegate = self;
    textfild1.inputText.textColor = KBlackColor;
    [self.view addSubview:textfild1];
    self.MakeSureText = textfild1;
    
    [textfild1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild).with.offset(65);
        make.left.mas_equalTo(textfild);
        make.right.mas_equalTo(textfild);
        make.height.offset(40);
    }];
    UIView *lineview2 = [[UIView alloc] init];
    lineview2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineview2];
    [lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild1).with.offset(40);
        make.left.mas_equalTo(TELText).with.offset(30);
        make.right.mas_equalTo(TELText).with.offset(-30);
        make.height.offset(1);
    }];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"长度在6位以上，密码应包含字母和数字";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textColor = KGrayColor;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild1).with.offset(45);
        make.left.mas_equalTo(TELText).with.offset(30);
        make.right.mas_equalTo(TELText).with.offset(-30);
        make.height.offset(20);
    }];
    
   
    _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _LoginBtn.layer.masksToBounds = YES;
    _LoginBtn.layer.cornerRadius = 3.0;
    [_LoginBtn setBackgroundColor:[UIColor whiteColor]];
    
    [_LoginBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_LoginBtn addTarget:self action:@selector(makeSureBtn) forControlEvents:UIControlEventTouchUpInside];
    _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _LoginBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_LoginBtn];
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild1).with.offset(40+50+30);
        make.left.offset(40);
        make.right.offset(-40);
        make.height.offset(40.0);
    }];
    
    UITapGestureRecognizer *r5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    r5.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:r5];
    
}
-(void)makeSureBtn{
    [self.view endEditing:YES];
    if (self.MakeSureText.inputText.text.length==0||self.PassText.inputText.text.length==0||self.TelText.inputText.text.length==0) {
        return;
    }
    if ([self.MakeSureText.inputText.text isEqualToString:self.PassText.inputText.text]) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        [SVProgressHUD dismissWithDelay:1.0];
        [self.navigationController popViewControllerAnimated:YES];

    }else{
        IBConfigration *configration = [[IBConfigration alloc] init];
        configration.title = @"温馨提示";
        configration.message = @"请保持密码一致";
        configration.cancelTitle = @"取消";
        configration.confirmTitle = @"确定";
        configration.tintColor = KSelectColor;
        configration.messageAlignment = NSTextAlignmentLeft;
        
        IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
            if (index == 2) {
               
            }
        }];
        [alerView show];

    }
    
}

//点击
-(void)doTapChange:(UITapGestureRecognizer *)sender{
    [self.view endEditing:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.text.length <= 0 && textField.tag ==204) {
        
        [self.TelText textBeginEditing];
        
    }else if (textField.text.length <= 0 && textField.tag ==205){
        
        [self.PassText textBeginEditing];
        
    }else if (textField.text.length <= 0 && textField.tag ==206){
        [self.MakeSureText textBeginEditing];
    }

    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length <= 0 && textField.tag ==204) {
        [self.TelText textEndEditing];
    }else if (textField.text.length <= 0 && textField.tag ==205){
        [self.PassText textEndEditing];
    }else if (textField.text.length <= 0 && textField.tag ==206){
        [self.MakeSureText textEndEditing];
    }
    if (self.TelText.inputText.text.length>0&&self.PassText.inputText.text.length>0&&self.MakeSureText.inputText.text.length>0){
        
        [self.LoginBtn setBackgroundColor:KSelectColor];
    }else{
        
        [self.LoginBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.TelText.inputText.text.length>0&&self.PassText.inputText.text.length>0&&self.MakeSureText.inputText.text.length>0){
        [self.LoginBtn setBackgroundColor:KSelectColor];
    }else{
        [self.LoginBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    return YES;
}
- (void)endEditing{
    [self.TelText textEndEditing];
    [self.PassText textEndEditing];
    [self.MakeSureText textEndEditing];

}


-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.TelText resignFirstResponder];
    [self.PassText resignFirstResponder];
    //    [self.PassText textEndEditing];
    //    [self.TelText textEndEditing];
    //
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
