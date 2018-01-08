//
//  HomeViewController.m
//  accountProject
//
//  Created by 弘鼎 on 2017/12/29.
//  Copyright © 2017年 贺亚飞. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeAccountModel.h"
#import "HomeHeaderModel.h"
#import "WaterEnergyViewController.h"
#import "GroupDataViewController.h"
#import "SummerDataViewController.h"
#import "LoginViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *headerArray; ///>头部数组
@property (nonatomic,strong) UIView *headerView; ///>头部视图

@property (nonatomic,strong) NSMutableArray *footArray; ///>底部数组
@property (nonatomic,strong) UITableView *tableview; ///>主tableview

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = KWhiteColor;

    self.view.backgroundColor = RGB(245, 245, 249);
    _headerArray = [NSMutableArray arrayWithCapacity:0];
    _footArray = [NSMutableArray arrayWithCapacity:0];
    [self creatData];

    [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:^{
        
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;

}
- (void)viewWillDisappear:(BOOL)animated{
}
- (void)creatData{
    HomeHeaderModel *headerModel = [[HomeHeaderModel alloc] init];
    headerModel.date = @"2017年01月02日";
    headerModel.Title = @"电耗能";
    headerModel.number = @"100KW.h";
    
    
    HomeHeaderModel *headerModel1 = [[HomeHeaderModel alloc] init];;
    headerModel1.date = @"2017年01月02日";
    headerModel1.Title = @"天然气耗能";
    headerModel1.number = @"100m^3";
    NSArray *arr = [NSArray arrayWithObjects:headerModel,headerModel1,nil];
    [_headerArray addObjectsFromArray:arr];
    
    HomeAccountModel *homemodel = [[HomeAccountModel alloc] init];
    homemodel.imageName = @"icon_water";
    homemodel.title = @"水能耗";
    
    HomeAccountModel *homemodel1 = [[HomeAccountModel alloc] init];
    homemodel1.imageName = @"icon_flash";
    homemodel1.title = @"电能耗";
    
    HomeAccountModel *homemodel2 = [[HomeAccountModel alloc] init];
    homemodel2.imageName = @"icon_cloud";
    homemodel2.title = @"蒸汽能耗";
    
    HomeAccountModel *homemodel3 = [[HomeAccountModel alloc] init];
    homemodel3.imageName = @"icon_fire";
    homemodel3.title = @"燃气能耗";
    
    HomeAccountModel *homemodel4 = [[HomeAccountModel alloc] init];
    homemodel4.imageName = @"icon_gaikuang";
    homemodel4.title = @"能耗概况";
    
    HomeAccountModel *homemodel5 = [[HomeAccountModel alloc] init];
    homemodel5.imageName = @"icon_group";
    homemodel5.title = @"班组数据";
    NSArray *Arr1 = [NSArray arrayWithObjects:homemodel,homemodel1,homemodel2,homemodel3,homemodel4,homemodel5, nil];
    [_footArray addObjectsFromArray:Arr1];
    [self tableview];
    [self headerView];



}
- (void)creatUI{
   
    
}

#pragma mark ---Getter---
- (UITableView *)tableview{
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, HYFStatusBarHeight, kScreenWidth, kScreenHeight-HYFStatusBarHeight-HYFTabBarAndBottomHeight)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = RGB(245, 245, 245);
        
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
- (UIView *)headerView{
    if (!_headerView) {
        CGFloat viewW = (kScreenWidth-20)/2;
        CGFloat subViewH =viewW/9*10;
        NSInteger Hnumber = _headerArray.count/2;
        NSInteger doubleF = _headerArray.count%2;
        if (doubleF==1) {
            Hnumber++;
        }
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, subViewH*Hnumber)];
        _headerView.backgroundColor = KClearColor;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, subViewH*Hnumber)];
        imageView.image = IMAGE_NAMED(@"image_bgmy");
        [_headerView addSubview:imageView];
        for (int i=0; i<_headerArray.count; i++) {
            HomeHeaderModel *headermodel = _headerArray[i];
            CGRect frame = CGRectMake(10+i%2*viewW, i/2*subViewH, viewW, subViewH);
            UIView *view = [self creatHeaderSubViewWithFrame:frame AndModel:headermodel];
            [_headerView addSubview:view];
        }
    }
    return _headerView;
}
#pragma mark ---头部视图的子视图---
- (UIView *)creatHeaderSubViewWithFrame:(CGRect )frame AndModel:(HomeHeaderModel *)headermodel {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = KClearColor;
//    view.layer.borderWidth = 1;
//    view.layer.borderColor = RGB(235, 235, 235).CGColor;
//    view.layer.masksToBounds = YES;
//    view.layer.cornerRadius = 5.0f;
    
    UILabel *dateLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 20)];
    [view addSubview:dateLB];
    dateLB.text = headermodel.date;
    dateLB.textAlignment = NSTextAlignmentCenter;
    dateLB.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    
    UILabel *dateLB1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, frame.size.height-30-40)];
    [view addSubview:dateLB1];
    dateLB1.text = headermodel.Title;
    dateLB1.textAlignment = NSTextAlignmentCenter;
    dateLB1.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    
    UILabel *dateLB2 = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-40, frame.size.width, 30)];
    [view addSubview:dateLB2];
    dateLB2.text = headermodel.number;
    dateLB2.textColor = KSelectColor;
    dateLB2.textAlignment = NSTextAlignmentCenter;
    dateLB2.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    return view;
    
}
#pragma mark ---UItableviewDelegate---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _footArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat viewW = (kScreenWidth-20)/2;
    CGFloat subViewH =viewW/9*10;
    NSInteger Hnumber = _headerArray.count/2;
    NSInteger doubleF = _headerArray.count%2;
    if (doubleF==1) {
        Hnumber++;
    }
    return subViewH*Hnumber+10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    HomeAccountModel *acmodel = _footArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = IMAGE_NAMED(acmodel.imageName);
    cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 24.0, 24.0);
    cell.textLabel.text = acmodel.title;
    cell.detailTextLabel.text = @">";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        WaterEnergyViewController *energyVC = [[WaterEnergyViewController alloc] init];
        energyVC.navigationItem.title = @"水耗能";
        [self.navigationController pushViewController:energyVC animated:YES];
    }else if (indexPath.row ==4){
        SummerDataViewController *sumVC = [[SummerDataViewController alloc] init];
        [self.navigationController pushViewController:sumVC animated:YES];
        
    }else if (indexPath.row ==5){
        GroupDataViewController *groupVC = [[GroupDataViewController alloc] init];
        [self.navigationController pushViewController:groupVC animated:YES];
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
