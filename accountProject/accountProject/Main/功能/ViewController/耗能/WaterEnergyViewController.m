//
//  WaterEnergyViewController.m
//  accountProject
//
//  Created by 弘鼎 on 2018/1/3.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import "WaterEnergyViewController.h"
#import "LXDateViewPickerView.h"
#import "THScrollChooseView.h"
#import <BUAdSDK/BUNativeExpressInterstitialAd.h>
#define un_splash_ID @"945641252" //插屏广告位ID


@interface WaterEnergyViewController ()<JHColumnChartDelegate,LXDateViewPickerViewDelegate,BUNativeExpresInterstitialAdDelegate>
@property (nonatomic,strong) JHColumnChart *column;
@property (nonatomic,strong) UILabel *titleLB;
@property (nonatomic,strong) NSMutableArray *buttonArr;
@property (nonatomic,strong) NSMutableArray *groupArr;
@property (nonatomic,strong) NSMutableArray *groupTitleArr;
@property (nonatomic,strong) NSString *beginData;
@property (nonatomic,strong) NSString *endData;
@property (nonatomic, strong) BUNativeExpressInterstitialAd *interstitialAd;

@end

@implementation WaterEnergyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =RGB(242, 242, 242);
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);
    
//    if (self.url.length==0) {
//        IBConfigration *configration = [[IBConfigration alloc] init];
//        configration.title = @"提示";
//        configration.message = @"暂无数据";
//
//        configration.confirmTitle=@"确定";
//
//        configration.messageAlignment = NSTextAlignmentCenter;
//
//        IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        [alerView show];
//    }else{
        _groupArr = [NSMutableArray arrayWithCapacity:0];
        _groupTitleArr = [NSMutableArray arrayWithCapacity:0];
        _beginData = [DataString getBeforeData:7];
        _endData = [DataString getNowData];
        
        [self getGroupList];
        
        [self creatChooseBtn];
    
    [self loadInterstitialWithSlotID:un_splash_ID];

}

- (void)loadInterstitialWithSlotID:(NSString *)slotID {
//    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds)-40;
//    CGFloat height = width/kScreenWidth*kScreenH;
// important: 升级的用户请注意，初始化方法去掉了imgSize参数
    self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:slotID adSize:CGSizeMake(300, 300)];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
    [self.interstitialAd showAdFromRootViewController:self];
}
- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    ASLog(@"121212121");
    

}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    [self pbud_logWithSEL:_cmd msg:@""];
    if (self.interstitialAd) {
        ASLog(@"7878787878");
       [self.interstitialAd showAdFromRootViewController:self];
    }
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
//    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}
- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    ASLog(@"SDKDemoDelegate BUNativeExpressInterstitialAd In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}
- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    self.interstitialAd = nil;
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark ---部门列表---
- (void)getGroupList{
    [_groupArr addObjectsFromArray:@[@"第一机组",@"第二机组",@"第三机组"]];
     [self getMainDataWithOrgCode:nil meterCode:nil];
    return;
    SingleUser *user = [kAppdelegate getusermodel];
    NSDictionary *dict = @{@"orgCode":user.orgCode};
    [[HttpRequest sharedInstance] postWithURLString:GroupListUrl parameters:dict success:^(id responseObject) {
        NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if ([Dic[@"success"] boolValue]) {
            
            [_groupArr addObjectsFromArray:Dic[@"rows"]];
            _titleLB.text = _groupArr[0][@"orgName"];
            for (NSDictionary *dic in _groupArr) {
                [_groupTitleArr addObject:dic[@"orgName"]];
            }
           
        }else{
            [SVProgressHUD showErrorWithStatus:Dic[@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma  mark ---请求条形数据---
- (void)getMainDataWithOrgCode:(NSString *)orgcode meterCode:(NSString *)meterCode {
   [self showColumnViewWithArray:@[] WithArray:@[]];
    return;
    NSDictionary *parameterDic = @{@"orgCode":orgcode,
                                   @"beginDate":_beginData,
                                   @"endDate":_endData
                                   };
    NSLog(@"%@,%@",parameterDic,_url);
    [SVProgressHUD show];
    [[HttpRequest sharedInstance] postWithURLString:self.url parameters:parameterDic success:^(id responseObject) {
        NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"请求条形数据%@",Dic);
        
        if ([Dic[@"success"] boolValue]) {
            if (((NSDictionary *)Dic[@"rows"]).count>0 ){
                NSMutableArray *nameArr = [NSMutableArray arrayWithCapacity:0];
                NSMutableArray *numArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *Msgdic in Dic[@"rows"]) {
                    [nameArr addObject:[Msgdic[@"useDate"] substringFromIndex:5]];
                    NSString *numberStr = Msgdic[@"useLevel"];
                    
                    [numArr addObject:@[@([numberStr integerValue])]];
                }
                
                [SVProgressHUD dismiss];
            }else{
                [SVProgressHUD showErrorWithStatus:Dic[@"msg"]];
            }
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:Dic[@"msg"]];
            [SVProgressHUD dismissWithDelay:0.5];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"数据错误"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
    
}
#pragma  mark ---界面布局----
- (void)creatChooseBtn{
    UIView *headerBgview = [[UIView alloc] initWithFrame:CGRectMake(0, HYFNavAndStatusHeight+20, kScreenWidth, 140)];
    headerBgview.backgroundColor = KWhiteColor;
    [self.view addSubview:headerBgview];
    
    
    UIView *chooseView = [[UIView alloc] initWithFrame:CGRectMake(40, 20, kScreenWidth-80, 40)];
    [headerBgview addSubview:chooseView];
    chooseView.layer.masksToBounds = YES;
    chooseView.layer.cornerRadius = 5.0f;
    chooseView.layer.borderWidth = 1.0f;
    chooseView.layer.borderColor = KSelectColor.CGColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-200, 20)];
    [chooseView addSubview:label];
    label.text = @"生产线";
    label.textColor = KGrayColor;
    _titleLB = label;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-140, 0, 50, 40)];
    [button setImage:IMAGE_NAMED(@"icon_xiala") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(chooseData) forControlEvents:UIControlEventTouchUpInside];
    [chooseView addSubview:button];
   
    LXDateViewPickerView *pickerView = [[LXDateViewPickerView alloc] initWithFrame:CGRectMake(20, 80.f+20, kScreenWidth-40, 40.f)];
    pickerView.delegate = self;
    [headerBgview addSubview:pickerView];

    NSArray *array = @[@"七日",@"一个月",@"三个月"];
    _buttonArr  =[NSMutableArray array];
    for (int i=0 ; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*kScreenWidth/3, HYFNavAndStatusHeight+150+320+20, kScreenWidth/3, 40);
        [self.view addSubview:button];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        button .layer.borderColor = RGB(225, 225, 225).CGColor;
        button.layer.borderWidth = 0.5;
        button.layer.cornerRadius = 1;
        [button setBackgroundColor:RGB(242, 242, 242)];
        if (i==0) {
            [button setBackgroundColor:KWhiteColor];
        }
        button.tag = 200+i;
        [button addTarget:self action:@selector(DatabuttonClivk:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonArr addObject:button];
    }
}
#pragma mark ---点击时间段按钮---
- (void)DatabuttonClivk:(id)sender{
    UIButton *btn = (UIButton *)sender;
    for (UIButton *button in _buttonArr) {
        [button setBackgroundColor:RGB(242, 242, 242)];
    }
    [btn setBackgroundColor:KWhiteColor];
    _endData = [DataString getNowData];
    if (btn.tag==200) {
        _beginData = [DataString getWeekBeforeData];
        
    }else if (btn.tag == 201){
        _beginData = [DataString getMonthBeforeData];
        
    }else if (btn.tag ==202){
        _beginData = [DataString getThreeMonthBeforeData];
    }
    [self getMainDataWithOrgCode:nil meterCode:nil];
}

- (void)chooseData{
    
    NSArray *titleGroupArr =@[@"第一生产线",@"第二生产线",@"第三生产线"];
    THScrollChooseView *scrollChooseView = [[THScrollChooseView alloc] initWithQuestionArray:titleGroupArr withDefaultDesc:@"选项"];
    [scrollChooseView showView];
    scrollChooseView.confirmBlock = ^(NSInteger selectedQuestion) {
        ASLog(@"---%li",selectedQuestion);
        if (selectedQuestion==3) {
            selectedQuestion=0;
        }
        _titleLB.text = titleGroupArr[selectedQuestion];
        [self getMainDataWithOrgCode:nil meterCode:nil];
    };
}
#pragma mark ---根据字段获得orgcode---
- (NSString *)GetOrgCodeWithText:(NSString *)text{
    NSInteger index=0;
    for (int i=0; i<_groupTitleArr.count; i++) {
        if ([text isEqualToString:_groupTitleArr[i]]) {
            index =i;
            break;
        }
    }
    return _groupArr[index][@"orgCode"];
}


#pragma mark ---日历Delegate---
- (void)dateViewPickerView:(LXDateViewPickerView *)view didSelectedDate:(NSDate *)date AndisStartLB:(BOOL)isStart{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"YYYY-MM-dd";
//    NSString *dateStr = [formatter stringFromDate:date];
//    if (isStart) {
//        _beginData = dateStr;
//    }else{
//        _endData = dateStr;
//
        [self getMainDataWithOrgCode:nil meterCode:nil];
//
//    }
    
}






#pragma mark ---设置柱状图---
//柱状图
- (void)showColumnViewWithArray:(NSArray *)numberArr WithArray:(NSArray *)valueArr{
    [_column removeFromSuperview];
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, HYFNavAndStatusHeight+150+20, kScreenWidth, 320)];
    _column = column;
    /*        Create an array of data sources, each array is a module data. For example, the first array can represent the average score of a class of different subjects, the next array represents the average score of different subjects in another class        */
    NSMutableArray *numDataArr = [NSMutableArray arrayWithCapacity:0];
    for (int i =0; i<5; i++) {
        NSMutableArray *numDataArr1 = [NSMutableArray arrayWithCapacity:0];

        for (int i =0; i<2; i++) {
            int x = 1 + arc4random() % 100;
            [numDataArr1 addObject:@(x)];

        }
        [numDataArr addObject:numDataArr1];

    }
    
    column.valueArr = numDataArr;
    /*       This point represents the distance from the lower left corner of the origin.         */
    column.originSize = CGPointMake(20, 20);
    /*    The first column of the distance from the starting point     */
    column.drawFromOriginX = 20;
    column.backgroundColor = [UIColor whiteColor];
    column.typeSpace = 10;
    column.isShowYLine = NO;
    column.contentInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    /*        Column width         */
    column.columnWidth = 30;
    /*        Column backgroundColor         */
    column.bgVewBackgoundColor = [UIColor whiteColor];
    /*        X, Y axis font color         */
    column.drawTextColorForX_Y = [UIColor blackColor];
    /*        X, Y axis line color         */
    column.colorForXYLine = [UIColor clearColor];
    /*    Each module of the color array, such as the A class of the language performance of the color is red, the color of the math achievement is green     */
        column.columnBGcolorsArr = @[@[KSelectColor,[UIColor greenColor]],@[[UIColor redColor],[UIColor greenColor]],@[[UIColor redColor],[UIColor greenColor]]];//如果为复合型柱状图 即每个柱状图分段 需要传入如上颜色数组 达到同时指定复合型柱状图分段颜色的效果
    /*        Module prompt         */
    column.xShowInfoText = @[@"项目一",@"项目二",@"项目三"];
  
    
    column.delegate = self;
    /*       Start animation        */
    [column showAnimation];
    [self.view addSubview:column];
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
