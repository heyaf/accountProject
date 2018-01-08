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
@property (nonatomic,strong) NSMutableArray *buttonArr1;

@end

@implementation SummerDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGB(242, 242, 242);
    self.navigationItem.title = @"耗能概况";
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);
    [self creatUI];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
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
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth-40, 20)];
    titleLB.text = @"能耗与产出";
    titleLB.font = [UIFont fontWithName:@"18" size:20];
    titleLB.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleLB];
    
    JHTableChart *table = [[JHTableChart alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth-20, 200)];
    /*       Table name         */
    /*        Each column of the statement, one of the first to show if the rows and columns that can use the vertical segmentation of rows and columns         */
    //    table.colTitleArr = @[@"属性|配置",@"外观",@"内饰",@"数量",@"",@"",@"",@"",@"",@""];
    table.colTitleArr = @[@"班组",@"水能",@"电能",@"蒸汽",@"燃气",@"纺纱",@"织布"];    /*        The width of the column array, starting with the first column         */
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
    
    table.dataArr = @[
                      @[@"一班",@"3000",@"3500",@"3500",@"3500",@"12",@"10"],
                      @[@"二班",@"3000",@"3500",@"3500",@"3500",@"12",@"10"],
                      @[@"三班",@"3000",@"3500",@"3500",@"3500",@"12",@"10"]
                      ];
    table.delegate = self;
    /*        show                            */
    [table showAnimation];
    [view addSubview:table];
    
    
    
    
    JHPieChart *pie = [[JHPieChart alloc] initWithFrame:CGRectMake(10, 180, kScreenWidth-20, 270)];
    pie.backgroundColor = [UIColor whiteColor];
    //    pie.center = CGPointMake(CGRectGetMaxX(self.view.frame)/2, CGRectGetMaxY(self.view.frame)/2);
    /* Pie chart value, will automatically according to the percentage of numerical calculation */
    pie.valueArr = @[@18,@14,@25,@40,@70];
    /* The description of each sector must be filled, and the number must be the same as the pie chart. */
    pie.descArr = @[@"第一个元素",@"第二个元素",@"第三个元素",@"第四个元素",@"元素图"];
    //    pie.backgroundColor = [UIColor whiteColor];
    pie.didClickType =     JHPieChartDidClickTranslateToBig;
    pie.animationDuration = 0.5;
    [view addSubview:pie];
    /*    When touching a pie chart, the animation offset value     */
    pie.positionChangeLengthWhenClick = 15;
    pie.showDescripotion = YES;
    pie.animationType = JHPieChartAnimationByOrder;
    //    pie.colorArr = @[[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor yellowColor]];
    /*        Start animation         */
    [pie showAnimation];
    
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
        button.tag = 200+i;
        [button addTarget:self action:@selector(DatabuttonClivk1:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonArr1 addObject:button];
    }
}

- (void)DatabuttonClivk1:(id)sender{
    UIButton *btn = (UIButton *)sender;
    for (UIButton *button in _buttonArr1) {
        [button setBackgroundColor:RGB(242, 242, 242)];
    }
    [btn setBackgroundColor:KWhiteColor];
}

#pragma mark ---日历Delegate---
- (void)dateViewPickerView:(LXDateViewPickerView *)view didSelectedDate:(NSDate *)date AndisStartLB:(BOOL)isStart{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYYMMdd";
    NSString *dateStr = [formatter stringFromDate:date];
    if (isStart) {
        NSLog(@"开始-----%@",dateStr);
    }else{
        NSLog(@"结束-----%@",dateStr);
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
