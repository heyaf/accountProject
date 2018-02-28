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
@property (nonatomic,strong) SingleUser *myUsermodel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger i=4;
    NSLog(@"----%ld",(long)(i+=6));
    NSLog(@"---%ld",(long)(i+=12));
    
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = KWhiteColor;

    self.view.backgroundColor = RGB(245, 245, 249);
    _headerArray = [NSMutableArray arrayWithCapacity:0];
    _footArray = [NSMutableArray arrayWithCapacity:0];
    [self creatData];
    [self FindNewVersion];
 
    [self showLoginVC];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [kAppdelegate checkWarningMessages];
    
    SingleUser *user = [kAppdelegate getusermodel];
    if (_myUsermodel.account.length>0&&![_myUsermodel.account isEqualToString:user.account]) {
        [self getHeaderHotData];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    _myUsermodel = [kAppdelegate getusermodel];
}

#pragma mark ---是否弹出登陆页---
- (void)showLoginVC{
    SingleUser *user = [kAppdelegate getusermodel];
    if (user.userId.length==0) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:^{
            
        }];
        loginVC.myRegistblock = ^{
            [self refreshData];
        };
    }else{
        [self getHeaderHotData];
        
    }
    
    
}
#pragma mark ---刷新数据---
- (void)refreshData{
    NSLog(@"刷新数据");
}
- (void)creatData{
//    HomeHeaderModel *headerModel = [[HomeHeaderModel alloc] init];
//    headerModel.date = @"2017年01月02日";
//    headerModel.Title = @"电耗能";
//    headerModel.number = @"100KW.h";
//    
//    
//    HomeHeaderModel *headerModel1 = [[HomeHeaderModel alloc] init];;
//    headerModel1.date = @"2017年01月02日";
//    headerModel1.Title = @"天然气耗能";
//    headerModel1.number = @"100m^3";
//    NSArray *arr = [NSArray arrayWithObjects:headerModel,headerModel1,nil];
//    [_headerArray addObjectsFromArray:arr];
    
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



    
}
- (void)creatUI{
   
    
}
#pragma mark ---检测是否有新版本更新---
- (void)FindNewVersion{
    
    NSDictionary *dict = @{@"phoneType":@"2"};
    [[HttpRequest sharedInstance] postWithURLString:NewVersionUrl parameters:dict success:^(id responseObject) {
        NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        

        //此获取的版本号对应version，打印出来对应为1.2.3.4.5这样的字符串
        NSString *app_build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if ([Dic[@"success"] boolValue]&&![app_build isEqualToString:Dic[@"data"][@"version"]]) {


                IBConfigration *configration = [[IBConfigration alloc] init];
                configration.title = @"温馨提示";
                configration.message = @"提示信息有新版本";
                configration.cancelTitle = @"取消";
                configration.confirmTitle = @"去更新";
                configration.tintColor = KSelectColor;
                configration.messageAlignment = NSTextAlignmentLeft;
                
                IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
                    if (index == 2) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id493901993?mt=8"]];
                        
                    }
                }];
                [alerView show];

            

        }
        
    } failure:^(NSError *error) {
        ASLog(@"请求失败%@",error.description);
    }];
}
#pragma mark  刷新控件准备
-(void)refreshWidgetPrepare{
    
    [self.tableview headerSetState:CoreHeaderViewRefreshStateRefreshing];
    //添加顶部刷新控件
    [self.tableview addHeaderWithTarget:self action:@selector(headerRefresh)];
    
    
    //添加底部刷新
    [self.tableview addFooterWithTarget:self action:@selector(foorterRefresh)];
}



#pragma mark  顶部刷新
-(void)headerRefresh{
    NSLog(@"....顶部刷新");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableview headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
    });
    
}


#pragma mark  底部刷新
-(void)foorterRefresh{
    NSLog(@"底部刷新。。。");
    
}
#pragma mark ---获取首页头部数据---
- (void)getHeaderHotData{
    
    SingleUser *user = [kAppdelegate getusermodel];
    NSLog(@"---%@",user);
    NSDictionary *parmaryDic = @{@"orgCode":user.orgCode,
                                 @"beginDate":[DataString getYesterdayData],
                                 @"endDate":@"",
                                 @"groupLevel":@"0"
                                 
                                 };
    NSLog(@"---%@",parmaryDic);

    [SVProgressHUD show];
    [SVProgressHUD setForegroundColor:KBlackColor];
    [[HttpRequest sharedInstance] postWithURLString:HomeHeaderUrl parameters:parmaryDic success:^(id responseObject) {
        NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"正确-----%@-----",Dic);
        NSArray *DataArr = [HomeHeaderModel arrayOfModelsFromDictionaries:Dic[@"rows"] error:nil];
        [_headerArray removeAllObjects];
        [_headerArray addObjectsFromArray:DataArr];
        [self setheaderView];
        [self.tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"错误-----%@-----",error.description);
    }];
}
#pragma mark ---Getter---
- (UITableView *)tableview{
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, HYFStatusBarHeight, kScreenWidth, kScreenHeight-HYFStatusBarHeight-HYFTabBarAndBottomHeight)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = RGB(245, 245, 245);
//        [self refreshWidgetPrepare];
        
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
- (UIView *)setheaderView{
    
        CGFloat viewW = (kScreenWidth-20)/2;
        CGFloat subViewH =viewW/9*9;
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
            CGRect frame = CGRectMake(10+i%2*viewW, i/2*subViewH+2*i, viewW, subViewH);
            UIView *view = [self creatHeaderSubViewWithFrame:frame AndModel:headermodel];
            [_headerView addSubview:view];
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
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, frame.size.width-20, 1)];
    lineView.backgroundColor = RGB(240, 240, 240);
    [view addSubview:lineView];
    UILabel *dateLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, 20)];
    [view addSubview:dateLB];
    dateLB.text = headermodel.useDate;
    dateLB.textAlignment = NSTextAlignmentCenter;
    dateLB.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    
    UILabel *dateLB1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, frame.size.height-30-40)];
    [view addSubview:dateLB1];
    NSString *title;
    if ([headermodel.EnergyKind isEqualToString:@"electric"]) {
        title = @"电耗能";
    }else if ([headermodel.EnergyKind isEqualToString:@"fuel"]){
        title = @"天然气耗能";
    }else if ([headermodel.EnergyKind isEqualToString:@"water"]){
        title = @"水耗能";
    }
    dateLB1.text = title;
    dateLB1.textAlignment = NSTextAlignmentCenter;
    dateLB1.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    
    UILabel *dateLB2 = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-50, frame.size.width, 30)];
    [view addSubview:dateLB2];
    dateLB2.text = headermodel.useLevel;
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
    CGFloat subViewH =viewW;
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
        energyVC.url = WaterUrl;
        [self.navigationController pushViewController:energyVC animated:YES];
    }else if (indexPath.row ==1){
        WaterEnergyViewController *energyVC = [[WaterEnergyViewController alloc] init];
        energyVC.navigationItem.title = @"电耗能";
        energyVC.url = ElectricUrl;
        [self.navigationController pushViewController:energyVC animated:YES];
        
    }else if (indexPath.row ==2){
        WaterEnergyViewController *energyVC = [[WaterEnergyViewController alloc] init];
        energyVC.navigationItem.title = @"蒸汽耗能";
        energyVC.url = SteamUrl;
        [self.navigationController pushViewController:energyVC animated:YES];
    }else if (indexPath.row ==3){
        WaterEnergyViewController *energyVC = [[WaterEnergyViewController alloc] init];
        energyVC.navigationItem.title = @"燃气耗能";
        energyVC.url = GasUrl;
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
