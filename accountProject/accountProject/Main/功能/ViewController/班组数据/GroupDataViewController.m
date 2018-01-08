//
//  GroupDataViewController.m
//  accountProject
//
//  Created by 弘鼎 on 2018/1/5.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import "GroupDataViewController.h"
#import "LXDateViewPickerView.h"


@interface GroupDataViewController ()<LXDateViewPickerViewDelegate>
@property (nonatomic,strong) NSMutableArray *buttonArr;
@property (nonatomic,strong) NSMutableArray *buttonArr1;

@end

@implementation GroupDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGB(242, 242, 242);
    self.navigationItem.title = @"班组数据";
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);
    [self creatUI];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
    NSArray *array = @[@"一班",@"二班",@"三班"];
    _buttonArr  =[NSMutableArray array];
    for (int i=0 ; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*(kScreenWidth-20)/3, 10, (kScreenWidth-20)/3, 40);
        [headerView addSubview:button];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        button .layer.borderColor = KSelectColor.CGColor;
        button.layer.borderWidth = 0.5;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 1;
        [button setBackgroundColor:KWhiteColor];
        if (i==0) {
            [button setBackgroundColor:KSelectColor];
            [button setTitleColor:KWhiteColor forState:UIControlStateNormal];
            
        }
        button.tag = 200+i;
        [button addTarget:self action:@selector(DatabuttonClivk:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonArr addObject:button];
    }
}
- (void)DatabuttonClivk:(id)sender{
    UIButton *btn = (UIButton *)sender;
    for (UIButton *button in _buttonArr) {
        [button setBackgroundColor:KWhiteColor];
        [button setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];

    }
    [btn setBackgroundColor:KSelectColor];
    [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
}
#pragma mark ---主题UI---
- (void) creatMianUI{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, HYFNavAndStatusHeight+70, kScreenWidth, 320)];
    view.backgroundColor = KWhiteColor;
    [self.view addSubview:view];
    

    LXDateViewPickerView *pickerView = [[LXDateViewPickerView alloc] initWithFrame:CGRectMake(20, 10.f, kScreenWidth-40, 40.f)];
    pickerView.delegate = self;
    [view addSubview:pickerView];
    
    
    JHPieChart *pie = [[JHPieChart alloc] initWithFrame:CGRectMake(10, 50, kScreenWidth-20, 270)];
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
        button.frame = CGRectMake(i*kScreenWidth/3, HYFNavAndStatusHeight+320+70, kScreenWidth/3, 40);
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
