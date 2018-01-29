//
//  LoginViewController.m
//  accountProject
//
//  Created by 弘鼎 on 2018/1/8.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import "LoginViewController.h"
#import "ZXTextField.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) ZXTextField *TelText;
@property (nonatomic,strong) ZXTextField *PassText;

@property (nonatomic,strong) UIButton *LoginBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:KWhiteColor];
    [self creatmianUI];
}
-(void)creatmianUI {
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 194, 28)];
    imageview.center = CGPointMake(kScreenWidth/2, 150);
    [self.view addSubview:imageview];
    imageview.image = IMAGE_NAMED(@"bgimage");
    
    CGRect accountF = CGRectMake(30, 250, kScreenWidth-60, 40);
    ZXTextField *TELText = [[ZXTextField alloc]initWithFrame:accountF withIcon:@"ICON_login" withPlaceholderText:@"请输入手机号码"];
    TELText.inputText.textColor = KBlackColor;
    TELText.inputText.tag=204;
    TELText.inputText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    TELText.inputText.autocorrectionType = UITextAutocorrectionTypeNo;
    TELText.inputText.keyboardType = UIKeyboardTypeASCIICapable;
    TELText.frame = accountF;
    TELText.inputText.delegate = self;
    [self.view addSubview:TELText];
    self.TelText = TELText;
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = RGB(204, 204, 204);
    [self.view addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TELText).with.offset(40);
        make.left.mas_equalTo(TELText).with.offset(10);
        make.right.mas_equalTo(TELText).with.offset(-10);
        make.height.offset(1);
    }];
    
    ZXTextField *textfild = [[ZXTextField alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 40) withIcon:@"ICON_mima" withPlaceholderText:@"密码"];
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
    lineview1.backgroundColor = RGB(204, 204, 204);
    [self.view addSubview:lineview1];
    [lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild).with.offset(40);
        make.left.mas_equalTo(TELText).with.offset(10);
        make.right.mas_equalTo(TELText).with.offset(-10);
        make.height.offset(1);
    }];
    
    _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _LoginBtn.layer.masksToBounds = YES;
    _LoginBtn.layer.cornerRadius = 20.0;
    [_LoginBtn setBackgroundColor:[UIColor whiteColor]];
    
    [_LoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_LoginBtn addTarget:self action:@selector(makeSureBtn) forControlEvents:UIControlEventTouchUpInside];
    _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _LoginBtn.backgroundColor = KSelectColor;
    [self.view addSubview:_LoginBtn];
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild).with.offset(40+50+30+50);
        make.left.offset(40);
        make.right.offset(-40);
        make.height.offset(40.0);
    }];
    UITapGestureRecognizer *r5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    r5.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:r5];
    
    

}
- (void)makeSureBtn{
    
    NSDictionary *dict = @{@"phoneType":@"2"};
    if (self.TelText.inputText.text.length==0) {
        [SVProgressHUD showInfoWithStatus:@"手机号不能为空"];
        [SVProgressHUD setForegroundColor:KBlackColor];
        [SVProgressHUD setBackgroundColor:KWhiteColor];
        [SVProgressHUD dismissWithDelay:1.0];
    }else if (self.PassText.inputText.text.length==0){
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        [SVProgressHUD setForegroundColor:KBlackColor];
        [SVProgressHUD setBackgroundColor:KWhiteColor];
        [SVProgressHUD dismissWithDelay:1.0];
    }else{
        [[HttpRequest sharedInstance] postWithURLString:LogininUrl parameters:dict success:^(id responseObject) {
            NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            if ([Dic[@"success"] isEqualToString:@"false"]) {
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [SVProgressHUD dismissWithDelay:1.0];

                [self dismissViewControllerAnimated:YES completion:nil];
            }
            NSLog(@"登录接口：%@",Dic);
            
            
        } failure:^(NSError *error) {
            ASLog(@"请求失败%@",error.description);
        }];
        
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
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length <= 0 && textField.tag ==204) {
        [self.TelText textEndEditing];
    }else if (textField.text.length <= 0 && textField.tag ==205){
        [self.PassText textEndEditing];
    }
}
- (void)endEditing{
    [self.TelText textEndEditing];
    [self.PassText textEndEditing];
   
    
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
