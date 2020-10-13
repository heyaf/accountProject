//
//  SummerDataViewController.m
//  accountProject
//
//  Created by 弘鼎 on 2018/1/5.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import "SummerDataViewController.h"
#import "LXDateViewPickerView.h"
@interface SummerDataViewController ()<LXDateViewPickerViewDelegate,JHTableChartDelegate>
@property (nonatomic,strong) UIView *mainview;

@property (nonatomic,strong) NSMutableArray *buttonArr1;
@property (nonatomic,strong) NSString *beginDate;
@property (nonatomic,strong) NSString *endDate;

@property (nonatomic,strong) NSMutableArray *ElectArr; //>能源元素数组，用于饼状图
@property (nonatomic,strong) NSMutableArray *NumArr;  //>能源元素数量数组，用于饼图
@property (nonatomic,strong) NSMutableArray *TableTitleArr; //>表格头部数组，用于表格
@property (nonatomic,strong) NSMutableArray *TableNumArr;  //>表格数量数组，用于表格

@property (nonatomic,strong) JHPieChart *pieChart; //>饼状图
@property (nonatomic,strong) JHTableChart *tableChart; //>表格
@end

@implementation SummerDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGB(242, 242, 242);
    self.navigationItem.title = @"耗能概况";
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);
    
    //初始化数组
    _ElectArr = [NSMutableArray arrayWithObjects:@"一组",@"二组",@"三组", nil];
    _TableTitleArr = [NSMutableArray arrayWithCapacity:0];
    [_TableTitleArr addObject:@"班组"];
    
    //设置初始班组和日期
    _beginDate = [DataString getWeekBeforeData];
    _endDate = [DataString getNowData];
    [self creatUI];
    [self getData];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark ---数据请求---
- (void)getData{
    
    [self drawJHPieChart];
    return;
    SingleUser *usermodel = [kAppdelegate getusermodel];
    NSDictionary *paraDic = @{@"orgCode":usermodel.orgCode,
//                              @"timeScope":@"",
                              @"beginDate":_beginDate,
                              @"endDate":_endDate
                              };
    NSLog(@"能耗参数%@",paraDic);
    [SVProgressHUD show];
    [[HttpRequest sharedInstance] postWithURLString:GroupElectUrl parameters:paraDic success:^(id responseObject) {
        NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if ([Dic[@"success"] boolValue]) {
//            SLog(@"能耗概况：%@",Dic);
            [_NumArr removeAllObjects];
            [_TableTitleArr removeAllObjects];
            [_TableTitleArr addObject:@"班组"];
            NSMutableArray *Arr1 = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *Arr2 = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *Arr3 = [NSMutableArray arrayWithCapacity:0];
            
            NSArray *dataArr = (NSArray *)Dic[@"rows"];
            for (int i=0; i<dataArr.count; i++) {
                NSString *groupStr = dataArr[i][@"timeScope"];
                if ([groupStr isEqualToString:@"1"]) {
                    NSArray *DetailArr = dataArr[i][@"datas"];
                    [Arr1 addObjectsFromArray:DetailArr];
                    
                }else if ([groupStr isEqualToString:@"2"]){
                    NSArray *DetailArr = dataArr[i][@"datas"];
                    [Arr2 addObjectsFromArray:DetailArr];
                }else if ([groupStr isEqualToString:@"3"]){
                    NSArray *DetailArr = dataArr[i][@"datas"];
                    [Arr3 addObjectsFromArray:DetailArr];
                }
                
            }
            NSMutableArray *oneArr = [NSMutableArray arrayWithObject:@"一组"];
            NSMutableArray *twoArr = [NSMutableArray arrayWithObject:@"二组"];
            NSMutableArray *thrArr = [NSMutableArray arrayWithObject:@"三组"];
            
            //计算各组数组的总和
            NSInteger oneGroup = 0;
            NSInteger twoGroup = 0;
            NSInteger thrGroup = 0;
            for (NSDictionary *DetailDic in Arr1) {
                [_TableTitleArr addObject:DetailDic[@"EnergyKind"]];
                [oneArr addObject:DetailDic[@"useLevel"]];
                NSString *numStr = DetailDic[@"useLevel"];
                oneGroup += [numStr integerValue];
            }
            for (NSDictionary *DetailDic in Arr2) {
                
                [twoArr addObject:DetailDic[@"useLevel"]];
                NSString *numStr = DetailDic[@"useLevel"];
                twoGroup += [numStr integerValue];
            }
            for (NSDictionary *DetailDic in Arr3) {
                
                [thrArr addObject:DetailDic[@"useLevel"]];
                NSString *numStr = DetailDic[@"useLevel"];
                thrGroup += [numStr integerValue];
            }
            _TableNumArr = [NSMutableArray arrayWithObjects:oneArr,twoArr,thrArr,nil];
            
            _NumArr = [NSMutableArray arrayWithObjects:@(oneGroup),@(twoGroup),@(thrGroup),nil];
//            SLog(@"表格列数%lu",(unsigned long)_TableTitleArr.count);
//            SLog(@"%@,%@,%@",_TableTitleArr,_TableNumArr,_NumArr);
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showErrorWithStatus:Dic[@"msg"]];
            [SVProgressHUD dismissWithDelay:1.0];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
}
- (void)creatUI{
    [self creatHeader];
    
    [self creatMianUI];
}
#pragma mark ---头部视图---
- (void)creatHeader{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, HYFNavAndStatusHeight, kScreenWidth, 60)];
    headerView.backgroundColor = KWhiteColor;
    [self.view addSubview:headerView];
    LXDateViewPickerView *pickerView = [[LXDateViewPickerView alloc] initWithFrame:CGRectMake(20, 10.f, kScreenWidth-40, 40.f)];
    pickerView.delegate = self;
    [headerView addSubview:pickerView];
}
#pragma mark ---主题UI---
- (void) creatMianUI{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, HYFNavAndStatusHeight+70, 500, 470)];
    view.backgroundColor = KWhiteColor;
    [self.view addSubview:view];
    _mainview = view;
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth-40, 20)];
    titleLB.text = @"能耗与产出";
    titleLB.font = [UIFont fontWithName:@"18" size:20];
    titleLB.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleLB];
    
    
    NSArray *array = @[@"七日",@"一个月",@"三个月"];
    _buttonArr1 = [NSMutableArray array];
    for (int i=0 ; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*kScreenWidth/3, HYFNavAndStatusHeight+470+70, kScreenWidth/3, 40);
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
        button.tag = 220+i;
        [button addTarget:self action:@selector(DatabuttonClivk1:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonArr1 addObject:button];
    }
}
#pragma mark ---绘制饼状图---
- (void) drawJHPieChart{
    if (_pieChart) {
        [_pieChart removeFromSuperview];
        [_tableChart removeFromSuperview];
    }
    JHPieChart *pie = [[JHPieChart alloc] initWithFrame:CGRectMake(10, 200, kScreenWidth-20, 270)];
    pie.backgroundColor = [UIColor whiteColor];
    //    pie.center = CGPointMake(CGRectGetMaxX(self.view.frame)/2, CGRectGetMaxY(self.view.frame)/2);
    /* Pie chart value, will automatically according to the percentage of numerical calculation */
    NSMutableArray *numDataArr = [NSMutableArray arrayWithCapacity:0];
    for (int i =0; i<5; i++) {
        int x = 1 + arc4random() % 100;
        [numDataArr addObject:@(x)];
    }
    
    pie.valueArr =  numDataArr;
//    pie.valueArr = @[@18,@14,@25];

    /* The description of each sector must be filled, and the number must be the same as the pie chart. */
    pie.descArr = @[@"第一个元素",@"第二个元素",@"第三个元素",@"第四个元素",@"元素图"];
//    ASLog(@"......%@,%@",_NumArr,_ElectArr);
    //    pie.backgroundColor = [UIColor whiteColor];
    pie.didClickType =     JHPieChartDidClickNormalType;
    pie.animationDuration = 0.5;
    [_mainview addSubview:pie];
    /*    When touching a pie chart, the animation offset value     */
    pie.positionChangeLengthWhenClick = 15;
    pie.showDescripotion = YES;
    pie.animationType = JHPieChartAnimationByOrder;
    pie.colorArr = @[[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor yellowColor]];
    /*        Start animation         */
    [pie showAnimation];
    _pieChart = pie;
    
    JHTableChart *table = [[JHTableChart alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth-20, 150)];
    /*       Table name         */
    /*        Each column of the statement, one of the first to show if the rows and columns that can use the vertical segmentation of rows and columns         */
    //    table.colTitleArr = @[@"属性|配置",@"外观",@"内饰",@"数量",@"",@"",@"",@"",@"",@""];
    table.colTitleArr = _TableTitleArr;//@[@"班组",@"水能",@"电能",@"蒸汽",@"燃气",@"纺纱",@"织布"];    /*        The width of the column array, starting with the first column         */
    table.colWidthArr = @[@80.0,@100.0,@70,@40,@100];
    //    table.colWidthArr = @[@80.0,@30.0,@70,@50,@50,@50,@50,@50,@50,@50];
    //    table.beginSpace = 30;
    UIColor *textColor = [UIColor grayColor];
    /*        Text color of the table body         */
    table.bodyTextColor = textColor;
    
    table.bodyTextFont = [UIFont systemFontOfSize:15];
    /*        Text color for every column         */
    table.bodyTextColorArr = @[textColor,textColor,textColor,textColor,[UIColor blueColor]];
    /*        Minimum grid height         */
    table.minHeightItems = 30;
    /*        The height of the column title*/
    table.colTitleHeight = 80;
    /*        Text color of the column title*/
    table.colTitleColor = KSelectColor;
    /*        Font of the column title*/
    table.colTitleFont = [UIFont systemFontOfSize:17];
    
    table.lineColor = [UIColor clearColor];
    
    table.backgroundColor = [UIColor whiteColor];
    
    table.dataArr = _TableNumArr;//@[
//                      @[@"一班",@"3000",@"3500",@"3500",@"3500",@"12",@"10"],
//                      @[@"二班",@"3000",@"3500",@"3500",@"3500",@"12",@"10"],
//                      @[@"三班",@"3000",@"3500",@"3500",@"3500",@"12",@"10"]
//                      ];
    table.delegate = self;
    /*        show                            */
    [table showAnimation];
    [_mainview addSubview:table];
    _tableChart = table;
}

- (void)DatabuttonClivk1:(id)sender{
    UIButton *btn = (UIButton *)sender;
    for (UIButton *button in _buttonArr1) {
        [button setBackgroundColor:RGB(242, 242, 242)];
    }
    [btn setBackgroundColor:KWhiteColor];
    if (btn.tag == 220) {
        _beginDate = [DataString getWeekBeforeData];
    }else if (btn.tag == 221){
        _beginDate = [DataString getMonthBeforeData];
    }else if (btn.tag == 222){
        _beginDate = [DataString getThreeMonthBeforeData];
    }
    _endDate = [DataString getNowData];
    [self getData];
}

#pragma mark ---日历Delegate---
- (void)dateViewPickerView:(LXDateViewPickerView *)view didSelectedDate:(NSDate *)date AndisStartLB:(BOOL)isStart{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    if (isStart) {
        _beginDate = dateStr;
    }else{
        _endDate = dateStr;
        [self getData];
        
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
