//
//  MineViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/9.
//  Copyright © 2017年 rongcloud. All rights reserved.
//
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？


#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "SDImageCache.h"
#import "IBAlertView.h"
#import "SubnameViewController.h"
#import "suggestViewController.h"
#import "MBProgressHUD+MJ.h"
#import "LoginViewController.h"
//#import "OwnerViewController.h"
//#import "LoginInViewController.h"
#import "UIImageView+WebCache.h"
//#import "CollectionViewController.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UIImageView *headerImageV;
@property (nonatomic,strong) UILabel *nameLB;
@property (nonatomic,strong) UIButton *loginBTN;
@property (nonatomic,strong) UIButton *regietBtn;
@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UIButton *quitBtn;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    self.navigationController.navigationBar.tintColor = KWhiteColor;
    [self creatData];
    [self creatUI];
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:^{
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]; //去掉 bar 下面有一条黑色的线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [kAppdelegate checkWarningMessages];

//    [self refreshUI];
}
-(void)viewDidAppear:(BOOL)animated{
}
-(void)viewWillDisappear:(BOOL)animated{
    

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationitem"] forBarMetrics:UIBarMetricsDefault]; //去掉 bar 下面有一条黑色的线
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@""]];
    
}
-(void)creatData{
    _dataArr = [NSMutableArray array];
    
    
    
    
}


-(void)creatUI{
    //    [self.view setBackgroundColor:RGB(242, 242, 242)];
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/375*188)];
    headerView.backgroundColor = RGB(85, 85, 85);
    headerView.image = [UIImage imageNamed: @"banner"];
    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    
    UIImageView *picImv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    picImv.image = IMAGE_NAMED(@"icon_head");
    picImv.layer.masksToBounds = YES;
    picImv.layer.cornerRadius = 35;
    picImv.layer.shadowRadius=2;
    picImv.layer.shadowColor = KWhiteColor.CGColor;
    picImv.center = headerView.center;
    picImv.userInteractionEnabled = YES;
    [headerView addSubview:picImv];
    _headerImageV = picImv;
    
    //    userModel *user = [kApp getusermodel];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, picImv.frame.origin.y+80, 200, 20)];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = KWhiteColor;
    [headerView addSubview:label];
    _nameLB =label;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(kScreenWidth/2-50, picImv.frame.origin.y+80, 100, 20);
    SingleUser *user = [kAppdelegate getusermodel];
    [btn1 setTitle:user.realName forState:UIControlStateNormal];
    
    [headerView addSubview:btn1];
    _loginBTN = btn1;
    
    
    
    
    
    
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, kScreenWidth/375*188, kScreenWidth, 220)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"mineCell"];
    [self.view addSubview:_tableView];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [picImv addGestureRecognizer:tapGesturRecognizer];
    
    UILabel *VersionLB = [[UILabel alloc] init];
    [self.view addSubview:VersionLB];
    NSString *Versionstring = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    VersionLB.text = [NSString stringWithFormat:@"当前版本 ：v%@",Versionstring];
    VersionLB.textAlignment = NSTextAlignmentCenter;
    VersionLB.font = [UIFont systemFontOfSize:14.0f];
    VersionLB.textColor = KGrayColor;
    [VersionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_tableView.mas_right);
        
        make.top.equalTo(_tableView.mas_bottom).with.offset(-10);
        
        make.width.equalTo(_tableView.mas_width);
        
        make.height.mas_equalTo(@30);
        
    }];
    
    _quitBtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, kScreenHeight-HYFTabBarAndBottomHeight-100, kScreenWidth-60, 40)];
    [_quitBtn setBackgroundColor:KSelectColor];
    _quitBtn.layer.masksToBounds = YES;
    _quitBtn.layer.cornerRadius = 5.0f;
    [_quitBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
    [_quitBtn addTarget:self action:@selector(LoginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_quitBtn];
    
    
}

#pragma mark    ------登陆注册------
- (void)loginin{
    
    
}
- (void)LoginOut{
    // 创建归档时所需的data 对象.
    NSMutableData *data = [NSMutableData data];
    // 归档类.
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 开始归档（@"model" 是key值，也就是通过这个标识来找到写入的对象）.
    [archiver encodeObject:nil forKey:kUserinfoKey];
    // 归档结束.
    [archiver finishEncoding];
    // 写入本地（@"weather" 是写入的文件名）.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weather"];
    [data writeToFile:file atomically:YES];

    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:^{
    
        
        
    }];
    loginVC.myRegistblock = ^{
        
    };
}
- (void)setUserInfoWithDictionary:(NSDictionary *)dic{
    SingleUser *user = [[SingleUser alloc] init];
    user.account = dic[@"account"];
    user.departid = dic[@"departid"];
    user.email = dic[@"email"];
    user.departid = dic[@"mobilephone"];
    user.msg = dic[@"msg"];
    user.orgCode = dic[@"orgCode"];
    user.realName = dic[@"realName"];
    user.signature = dic[@"signature"];
    user.signatureFile = dic[@"signatureFile"];
    user.userId = dic[@"userId"];
    
    
    // 创建归档时所需的data 对象.
    NSMutableData *data = [NSMutableData data];
    // 归档类.
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 开始归档（@"model" 是key值，也就是通过这个标识来找到写入的对象）.
    [archiver encodeObject:user forKey:kUserinfoKey];
    // 归档结束.
    [archiver finishEncoding];
    // 写入本地（@"weather" 是写入的文件名）.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weather"];
    [data writeToFile:file atomically:YES];
}



-(void)tapAction:(id)tap
{
//    ASLog(@"换头像");
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0&&indexPath.row==0) {
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleImage.image = IMAGE_NAMED(@"icon_push");
        cell.titleLB.text = @"推送";
        cell.subimv.image = IMAGE_NAMED(@"icon_close");
        
        
        return cell;
    }else if (indexPath.section==0&&indexPath.row==1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.imageView.image = IMAGE_NAMED(@"icon_key");
        cell.textLabel.text = @"密码重置";
        cell.detailTextLabel.text = @">";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section ==0&&indexPath.row==2){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.imageView.image = IMAGE_NAMED(@"icon_suggest");
        cell.textLabel.text = @"意见反馈";
        cell.detailTextLabel.text = @">";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if(indexPath.section ==0&&indexPath.row==3){
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.imageView.image = IMAGE_NAMED(@"icon_delete");
        cell.textLabel.text = @"清除缓存";
        CGFloat size = [self folderSizeAtPath:[self getCachesPath]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",size];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = RGB(242, 242, 242);
    return view;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        
        IBConfigration *configration = [[IBConfigration alloc] init];
        configration.title = @"提示";
        configration.message = @"要打开推送通知，请在【设置-通知-允许通知】进行操作";
        
        configration.confirmTitle=@"确定";
        
        configration.messageAlignment = NSTextAlignmentCenter;
        
        IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
            
        }];
        [alerView show];
        
    }else if (indexPath.row==1){
        
        SubnameViewController *subnameVC = [[SubnameViewController alloc] init];
        [self.navigationController pushViewController:subnameVC animated:YES];
        
    }else if(indexPath.row==2){
        
        suggestViewController *subnameVC = [[suggestViewController alloc] init];
        [self.navigationController pushViewController:subnameVC animated:YES];
        
        
        
    }else if(indexPath.row==3){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self cleanCaches:[self getCachesPath]];
        
    }else if(indexPath.row==4){
        
        
    }
    
}
// 获取Caches目录路径
- (NSString *)getCachesPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
    NSString *cachesDir = [paths lastObject];
    return cachesDir;
}
- (CGFloat)folderSizeAtPath:(NSString *)path{
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 目录下的文件计算大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        } //SDWebImage的缓存计算
        size += [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}
- (void)cleanCaches:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) { // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName]; // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil]; } }
    //SDWebImage的清除功能
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showSuccess:@"清除成功" toView:self.view];
    }];
    [[SDImageCache sharedImageCache] clearMemory]; }



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

