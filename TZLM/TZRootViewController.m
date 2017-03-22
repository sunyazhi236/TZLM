//
//  TZRootViewController.m
//  TZLM
//
//  Created by  sun on 2017/2/25.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "TZRootViewController.h"

@interface TZRootViewController ()
{

    UIImageView *_barImage;
    NSTimer * _flashMessageBtnTimer;
}
@property (nonatomic,strong) UIImageView* noDataView;
@end

@implementation TZRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackGround_Color;
    
    _isShowTabbar = YES;
    
    self.hidesBottomBarWhenPushed = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize_5:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setUpNav];
    
    [self createNavBar];
    
    [SZNotificationCenter addObserver:self selector:@selector(getMessage) name:@"GETNotifation" object:nil];
    
    [SZNotificationCenter addObserver:self selector:@selector(cancelFlash) name:@"cancelMessageButtonFlash" object:nil];
    
}
#pragma mark - viewController.lifeCircle
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if ([self isKindOfClass:[GuideHomePageViewController class]])
    {
        [self messageBar];
    }
    else
    {
        [self rdv_tabBarController].navigationItem.rightBarButtonItem = nil;
        [self rdv_tabBarController].navigationItem.leftBarButtonItem = nil;
        [self rdv_tabBarController].navigationItem.titleView = nil;
    }
    
    [self rdv_tabBarController].navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    if (self.rdv_tabBarController.isTabBarHidden == _isShowTabbar)
    {//返回正常Tabbar
        [self.rdv_tabBarController setTabBarHidden:!_isShowTabbar];
    }
    
    if ([SZUserDefault boolForKey:@"GETNotifation"])
    {
        [self getMessage];
    }
    else
    {
        _barImage.image = [UIImage imageNamed:@"lanmu"];
    }
    
    
    [self setNeedsStatusBarAppearanceUpdate];
}

/**
 显示没有数据页面
 */
-(void)showNoDataImage
{
    _noDataView=[[UIImageView alloc] init];
    [_noDataView setImage:[UIImage imageNamed:@"generl_nodata"]];
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            [_noDataView setFrame:CGRectMake(0, 0,obj.frame.size.width, obj.frame.size.height)];
            [obj addSubview:_noDataView];
        }
    }];
}
/**
 移除无数据页面
 */
-(void)removeNoDataImage{
    if (_noDataView) {
        [_noDataView removeFromSuperview];
    }
}


- (void)createNavBar
{
    self.view.backgroundColor = RGBColor(241, 241, 241);
}

#pragma mark - NavgationItem.set
- (void)setUpNav
{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
    [self messageBar];
}

- (void)messageBar
{
    _barImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lanmu"] ];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickMessage)];
    [_barImage addGestureRecognizer:tap];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:_barImage];
    
    [self rdv_tabBarController].navigationItem.rightBarButtonItem = bar;
}

- (void)getMessage
{
    _barImage.image = [UIImage imageNamed:@"tixing_xiaoxi_pre"];
    
    if (!_flashMessageBtnTimer.isValid) {
        _flashMessageBtnTimer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(flash) userInfo:nil repeats:YES];
    }
}

-(void)cancelFlash{
    [_flashMessageBtnTimer invalidate];
    _barImage.image = [UIImage imageNamed:@"lanmu"];
}

-(void)flash{
    _barImage.hidden = !_barImage.isHidden;
}

- (void)clickMessage
{
    [SZUserDefault setBool:NO forKey:@"GETNotifation"];
    [SZUserDefault synchronize];
    
    [SZNotificationCenter postNotificationName:@"cancelMessageButtonFlash" object:nil];
    
//    if ([HHUserInfo getUserId].length == 0)
//    {
        [self showShouldLoginPoint];
//    }
//    else
//    {
//        MessageViewController *mess = [[MessageViewController alloc]init];
//        _barImage.image = [UIImage imageNamed:@"tixing_xiaoxi"];
//        [self.navigationController pushViewController:mess animated:YES];
//    }
}

/**
 *  登录提示窗
 */
- (void)showShouldLoginPoint
{
    if (!self.actionSheet) {
        self.actionSheet = [MSAlertController alertControllerWithTitle:@"温馨提示" message:@"只有登录账户才能做此操作" preferredStyle:MSAlertControllerStyleAlert];
        self.actionSheet.titleFont = [UIFont systemFontOfSize_5:16];
        self.actionSheet.titleColor = [VTGeneralTool colorWithHex:@"#666666"];
        self.actionSheet.messageColor = [VTGeneralTool colorWithHex:@"#999999"];
        
        MSAlertAction *action1 = [MSAlertAction actionWithTitle:@"已有账号，立即登录" style:MSAlertActionStyleDefault handler:^(MSAlertAction *action) {
            
            [self goLogin];
        }];
        action1.titleColor = [VTGeneralTool colorWithHex:@"#275996"];
        action1.font = [UIFont systemFontOfSize_5:14];
        [self.actionSheet addAction:action1];
        
        MSAlertAction *action2 = [MSAlertAction actionWithTitle:@"没有账号？立即注册" style:MSAlertActionStyleDefault handler:^(MSAlertAction *action) {
            
            RegisterViewController *reg = [[RegisterViewController alloc]init];
            reg.navigationItem.title = @"注册";
            [[AppDelegate rootNavigationController] pushViewController:reg animated:YES];
            
        }];
        action2.font = [UIFont systemFontOfSize_5:14];
        action2.titleColor = [VTGeneralTool colorWithHex:@"#275996"];
        [self.actionSheet addAction:action2];
        
        MSAlertAction *action = [MSAlertAction actionWithTitle:@"暂不登录" style:MSAlertActionStyleDefault handler:^(MSAlertAction *action) {
            return ;
        }];
        action.font = [UIFont systemFontOfSize_5:14];
        action.titleColor = [VTGeneralTool colorWithHex:@"#275996"];
        [self.actionSheet addAction:action];
    }
    
    [self presentViewController:self.actionSheet animated:YES completion:^{
        
        //        [self.actionSheet dismissViewControllerAnimated:YES completion:^{
        //
        //        }];
    }];
}

//去登陆
- (void)goLogin{
    LoginViewController *login = [[LoginViewController alloc]init];
    login.navigationItem.title = @"登录";
    [[AppDelegate rootNavigationController] pushViewController:login animated:YES];
    
}

-(void)dealloc{
    [SZNotificationCenter removeObserver:self name:@"GETNotifation" object:nil];
    [SZNotificationCenter removeObserver:self name:@"cancelMessageButtonFlash" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
