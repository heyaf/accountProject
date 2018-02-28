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


@interface WaterEnergyViewController ()<JHColumnChartDelegate,LXDateViewPickerViewDelegate>
@property (nonatomic,strong) JHColumnChart *column;
@property (nonatomic,strong) UILabel *titleLB;
@property (nonatomic,strong) NSMutableArray *buttonArr;
@property (nonatomic,strong) NSMutableArray *groupArr;
@property (nonatomic,strong) NSMutableArray *groupTitleArr;
@property (nonatomic,strong) NSString *beginData;
@property (nonatomic,strong) NSString *endData;

@end

@implementation WaterEnergyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =RGB(242, 242, 242);
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);
    
    _groupArr = [NSMutableArray arrayWithCapacity:0];
    _groupTitleArr = [NSMutableArray arrayWithCapacity:0];
    _beginData = [DataString getBeforeData:7];
    _endData = [DataString getNowData];
    
    [self getGroupList];
//    NSArray *array = @[
//                       @[@15],//第一组元素 如果有多个元素，往该组添加，每一组只有一个元素，表示是单列柱状图| | | | |
//                       @[@50],//第二组元素
//                       @[@10],//第三组元素
//                       @[@40],
//                       @[@19],
//                       @[@12],
//                       @[@15],
//                       ];
//    NSArray *array1 = @[@"12-01",@"12-02",@"12-03",@"12-04",@"12-05",@"12-06",@"12-07"];
//    [self showColumnViewWithArray:array WithArray:array1];
    [self creatChooseBtn];
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
            
            [self getMainDataWithOrgCode:_groupArr[0][@"orgCode"] meterCode:nil];
            
        }else{
            [SVProgressHUD showErrorWithStatus:Dic[@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma  mark ---请求条形数据---
- (void)getMainDataWithOrgCode:(NSString *)orgcode meterCode:(NSString *)meterCode {
   
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
                    [nameArr addObject:Msgdic[@"orgName"]];
                    NSString *numberStr = Msgdic[@"useLevel"];
                    
                    [numArr addObject:@[@([numberStr integerValue])]];
                }
                NSLog(@"----%@",numArr);
                [SVProgressHUD dismiss];
                [self showColumnViewWithArray:numArr WithArray:nameArr];
            }else{
                [SVProgressHUD showErrorWithStatus:Dic[@"msg"]];
            }
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:Dic[@"msg"]];
            [SVProgressHUD dismissWithDelay:0.5];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma  mark ---界面布局----
- (void)creatChooseBtn{
    UIView *headerBgview = [[UIView alloc] initWithFrame:CGRectMake(0, HYFNavAndStatusHeight, kScreenWidth, 140)];
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
   
    LXDateViewPickerView *pickerView = [[LXDateViewPickerView alloc] initWithFrame:CGRectMake(20, 80.f, kScreenWidth-40, 40.f)];
    pickerView.delegate = self;
    [headerBgview addSubview:pickerView];

    NSArray *array = @[@"七日",@"一个月",@"三个月"];
    _buttonArr  =[NSMutableArray array];
    for (int i=0 ; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*kScreenWidth/3, HYFNavAndStatusHeight+150+320, kScreenWidth/3, 40);
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
    [self getMainDataWithOrgCode:[self GetOrgCodeWithText:_titleLB.text] meterCode:nil];
}

- (void)chooseData{
    
    THScrollChooseView *scrollChooseView = [[THScrollChooseView alloc] initWithQuestionArray:_groupTitleArr withDefaultDesc:@"选项"];
    [scrollChooseView showView];
    scrollChooseView.confirmBlock = ^(NSInteger selectedQuestion) {
        
        _titleLB.text = _groupTitleArr[selectedQuestion];
        [self getMainDataWithOrgCode:[self GetOrgCodeWithText:_titleLB.text] meterCode:nil];
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    if (isStart) {
        _beginData = dateStr;
    }else{
        _endData = dateStr;
        
        [self getMainDataWithOrgCode:[self GetOrgCodeWithText:_titleLB.text] meterCode:nil];

    }
    
}






#pragma mark ---设置柱状图---
//柱状图
- (void)showColumnViewWithArray:(NSArray *)numberArr WithArray:(NSArray *)valueArr{
    [_column removeFromSuperview];
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, HYFNavAndStatusHeight+150, kScreenWidth, 320)];
    _column = column;
    /*        Create an array of data sources, each array is a module data. For example, the first array can represent the average score of a class of different subjects, the next array represents the average score of different subjects in another class        */
    column.valueArr = numberArr;
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
    column.xShowInfoText = valueArr;
  
    
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
