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
@end

@implementation WaterEnergyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =RGB(242, 242, 242);
    self.navigationItem.title = @"水耗能";
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);
    NSArray *array = @[
                       @[@15],//第一组元素 如果有多个元素，往该组添加，每一组只有一个元素，表示是单列柱状图| | | | |
                       @[@50],//第二组元素
                       @[@10],//第三组元素
                       @[@40],
                       @[@19],
                       @[@12],
                       @[@15],
                       ];
    NSArray *array1 = @[@"12-01",@"12-02",@"12-03",@"12-04",@"12-05",@"12-06",@"12-07"];
    [self showColumnViewWithArray:array WithArray:array1];
    [self creatChooseBtn];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
#pragma  mark ---下拉选择框----
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
    label.text = @"纺纱生产线";
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
- (void)DatabuttonClivk:(id)sender{
    UIButton *btn = (UIButton *)sender;
    for (UIButton *button in _buttonArr) {
        [button setBackgroundColor:RGB(242, 242, 242)];
    }
    [btn setBackgroundColor:KWhiteColor];
}

- (void)chooseData{
    NSArray *questionArray = @[@"纺纱生产线",@"第五车间"];
    THScrollChooseView *scrollChooseView = [[THScrollChooseView alloc] initWithQuestionArray:questionArray withDefaultDesc:@"选项三"];
    [scrollChooseView showView];
    scrollChooseView.confirmBlock = ^(NSInteger selectedQuestion) {
        
        _titleLB.text = questionArray[selectedQuestion];
    };
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






#pragma mark ---设置柱状图---
//柱状图
- (void)showColumnViewWithArray:(NSArray *)numberArr WithArray:(NSArray *)valueArr{
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, HYFNavAndStatusHeight+150, kScreenWidth, 320)];
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
