//
//  AlarmViewController.m
//  accountProject
//
//  Created by 弘鼎 on 2017/12/29.
//  Copyright © 2017年 贺亚飞. All rights reserved.
//

#import "AlarmViewController.h"
#import "AlertTableViewCell.h"
#import "AlarmModel.h"
@interface AlarmViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation AlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报警信息";
    self.navigationController.navigationBar.barTintColor = RGB(44, 50, 59);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    self.view.backgroundColor = RGB(242, 242, 242);
    [self creatData];
}
- (void)creatData{
    AlarmModel *alertmodel = [[AlarmModel alloc] init];
    alertmodel.name = @"5#车间电表";
    alertmodel.errorStr = @"[17:53:01]电量消耗异常";
    alertmodel.date = @"2018-01-02";
    alertmodel.numStr = @"报警值为[506.3KW.h]";
    
    AlarmModel *alertmodel1 = [[AlarmModel alloc] init];
    alertmodel1.name = @"5#车间电表";
    alertmodel1.errorStr = @"[17:53:01]电量消耗异常";
    alertmodel1.date = @"2018-01-02";
    alertmodel1.numStr = @"报警值为[506.3KW.h]";
    
    AlarmModel *alertmodel2 = [[AlarmModel alloc] init];
    alertmodel2.name = @"5#车间电表";
    alertmodel2.errorStr = @"[17:53:01]电量消耗异常";
    alertmodel2.date = @"2018-01-02";
    alertmodel2.numStr = @"报警值为[506.3KW.h]";
    _dataArr = [NSArray arrayWithObjects:alertmodel,alertmodel1,alertmodel2, nil];
    [self tableview];
}
#pragma mark ---Getter---
- (UITableView *)tableview{
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-HYFTabBarAndBottomHeight)];
        [self.tableview registerNib:[UINib nibWithNibName:@"AlertTableViewCell" bundle:nil] forCellReuseIdentifier:@"AlarmCell"];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = RGB(245, 245, 245);
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
#pragma mark ---UItableviewDelegate---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlertTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AlarmCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"AlertTableViewCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.BGView.layer.masksToBounds = YES;
    cell.BGView.layer.cornerRadius = 10.0f;
    cell.BGView.layer.borderWidth = 1;
    cell.BGView.layer.borderColor = RGB(235, 235, 235).CGColor;
    
    AlarmModel *model = _dataArr[indexPath.section];
    cell.nameLB.text = model.name;
    cell.dateLB.text = model.date;
    cell.titleLB.text = model.errorStr;
    cell.numLB.text = model.numStr;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
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
