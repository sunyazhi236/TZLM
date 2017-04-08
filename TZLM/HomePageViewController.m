//
//  HomePageViewController.m
//  TZLM
//
//  Created by  sun on 2017/2/25.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "HomePageViewController.h"
#import "HYTabbarView.h"
#import "RecommendViewController.h"
#import "ProvinceViewController.h"
#import "CityViewController.h"
#import "FinancialFirmsViewController.h"
#import "DebentureTransferViewController.h"
#import "NetCreditViewController.h"
#import "AllianceViewController.h"
#import "PublishViewController.h"


@interface HomePageViewController ()<CLLocationManagerDelegate,UISearchBarDelegate>{
     UIButton *button;
}

@property (nonatomic,strong) HYTabbarView * tabbarView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic,strong) UISearchBar *customSearchBar;
@property(nonatomic,strong) UIButton *FBBtn;
@end

@implementation HomePageViewController


//懒加载
- (HYTabbarView *)tabbarView{
    
    if (!_tabbarView) {
        _tabbarView = ({
            
            HYTabbarView * tabbar = [[HYTabbarView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64)];
            
            RecommendViewController * vc0 = [[RecommendViewController alloc]init];
            vc0.title = @"借贷信息";
            [tabbar addSubItemWithViewController:vc0];
            
            DebentureTransferViewController * vc1 = [[DebentureTransferViewController alloc]init];
            vc1.title = @"债券转让";
            [tabbar addSubItemWithViewController:vc1];
            
            FinancialFirmsViewController * vc2 = [[FinancialFirmsViewController alloc]init];
            vc2.title = @"金融公司";
            [tabbar addSubItemWithViewController:vc2];
            
            NetCreditViewController * vc3 = [[NetCreditViewController alloc]init];
            vc3.title = @"网贷口子";
            [tabbar addSubItemWithViewController:vc3];
            
            AllianceViewController * vc4 = [[AllianceViewController alloc]init];
            vc4.title = @"质押联盟";
            [tabbar addSubItemWithViewController:vc4];
            
            QueryInfoViewController * vc5 = [[QueryInfoViewController alloc]init];
            vc5.title = @"查询老赖";
            [tabbar addSubItemWithViewController:vc5];
            
            QueryInfoViewController * vc6 = [[QueryInfoViewController alloc]init];
            vc6.title = @"联盟论坛";
            [tabbar addSubItemWithViewController:vc6];
            
            tabbar;
        });
    }
    return _tabbarView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.view addSubview:self.tabbarView];
       AppDelegate *app =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake((kScreenW-60), (10), (60), (25));
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleLabel.font = [UIFont systemFontOfSize_5:14];
    [button addTarget:self action:@selector(ClickCity:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image=[UIImage imageNamed:@"Xjiantou"];
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake((5), (45), (5),(5))];
    
    [self.navigationController.navigationBar addSubview:button];

    CGRect mainViewBounds = app.viewController.navigationController.navigationBar.bounds;

    _customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds), CGRectGetWidth(mainViewBounds)-120, 40)];
    _customSearchBar.delegate = self;
    [_customSearchBar setPlaceholder:@"搜你想搜的"];
    _customSearchBar.backgroundImage = [UIImage new];
    _customSearchBar.showsCancelButton = NO;
    _customSearchBar.searchBarStyle = UIBarMetricsDefault;
    _customSearchBar.keyboardType = UIKeyboardTypeDefault;
    _customSearchBar.returnKeyType = UIReturnKeySearch;
    [app.viewController.navigationController.navigationBar addSubview:_customSearchBar];
    
    //城市定位功能
    if(!_locationManager){
        self.locationManager = [[CLLocationManager alloc] init];
        if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];
        }
        //设置代理
        [self.locationManager setDelegate:self];
        //设置定位精度
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //设置距离筛选
        [self.locationManager setDistanceFilter:200];
        //开始定位
        [self.locationManager startUpdatingLocation];
        //设置开始识别方向
        [self.locationManager startUpdatingHeading];
    }

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    //最前端发布按钮
//    AppDelegate *app =(AppDelegate*)[UIApplication sharedApplication].delegate;
    _FBBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _FBBtn.frame = CGRectMake(kScreenW - kAutoWEX(58), kAutoHEX(500), kAutoWEX(58), kAutoHEX(53));
    [_FBBtn setBackgroundImage:[UIImage imageNamed:@"fb"] forState:UIControlStateNormal];
    [_FBBtn addTarget:self action:@selector(didClickFBBtn:) forControlEvents:UIControlEventTouchUpInside];
    [app.window addSubview:_FBBtn];
}


-(void)didClickFBBtn:(UIButton*)sender{
    PublishViewController *publicVC = [[PublishViewController alloc]init];
    [self presentViewController:publicVC animated:YES completion:nil];
    
    
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if ([_customSearchBar isFirstResponder]) {
        //取消第一响应者。收回键盘
        [_customSearchBar resignFirstResponder];
    }
}

#pragma mark - CLLocationManangerDelegate
//定位成功以后调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [self.locationManager stopUpdatingLocation];
    CLLocation *location = locations.lastObject;
    [self reverseGeocoder:location];
}

-(void)ClickCity:(UIButton*)sender{
    ProvinceViewController *province=[[ProvinceViewController alloc]init];
    [self.navigationController pushViewController:province animated:YES];
    
}
#pragma mark Geocoder
- (void)reverseGeocoder:(CLLocation *)currentLocation {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks,NSError *error) {
        if(error || placemarks.count ==0){
            [button setTitle:@"邢台" forState:UIControlStateNormal];
            NSLog(@"error = %@",error);
        }else{
            CLPlacemark  *placemark = placemarks.firstObject;
            NSLog(@"省：%@",[[placemark addressDictionary] objectForKey:@"State"]);
            NSLog(@"您所在的城市为:%@",[[placemark addressDictionary]objectForKey:@"City"]);
            NSString * CityStr=[[placemark addressDictionary]objectForKey:@"City"];
            [button setTitle:CityStr forState:UIControlStateNormal];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _customSearchBar.hidden=NO;
    button.hidden=NO;
    if ([[CityViewController shareInstance].cityStr isEqualToString:@""]) {
        [button setTitle:@"邢台" forState:UIControlStateNormal];
    }else{
        [button setTitle:[CityViewController shareInstance].cityStr forState:UIControlStateNormal];
    }
    _FBBtn.hidden=NO;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if (IOSSystemVersion >= 10) {
        searchBar.searchTextPositionAdjustment = UIOffsetMake(25, 2);
    }
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    button.hidden=YES;
    _customSearchBar.hidden=YES;
    if ([_customSearchBar isFirstResponder]) {
        //取消第一响应者。收回键盘
        [_customSearchBar resignFirstResponder];
    }
    _FBBtn.hidden=YES;
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
