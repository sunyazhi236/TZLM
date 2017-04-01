//
//  GuideHomePageViewController.m
//  TZLM
//
//  Created by  sun on 2017/3/8.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "GuideHomePageViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ProvinceViewController.h"
#import "CityViewController.h"

@interface GuideHomePageViewController ()<SDCycleScrollViewDelegate,UISearchBarDelegate>{
    UIScrollView *_scrollView;
    UISearchBar *customSearchBar;
//    UIButton *button;
    UIView *_headerView;
    UIImageView *imgV;
    
}
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation GuideHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kAutoHEX(kScreenW * 112 / 320)) ];
    _scrollView =[[UIScrollView alloc]initWithFrame:_headerView.bounds];
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"banner1.png",
                            @"banner2.png",
                            @"banner3.png",
                            // 本地图片请填写全名
                            ];
    
    // 情景二：采用网络图片实现
    //    NSArray *imagesURLStrings = @[
    //                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
    //                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
    //                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
    //                                  ];
    // 情景三：图片配文字
    //    NSArray *titles = @[@"新建交流QQ群：185534916 ",
    //                        @"感谢您的支持，如果下载的",
    //                        @"如果代码在使用过程中出现问题",
    //                        @"您可以发邮件到gsdios@126.com"
    //                        ];
    
    //
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:_scrollView.frame shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [_scrollView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 4.0;
    
    
    // -------------------------网络加载 --- 创建带标题的图片轮播器------
    //    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:_scrollView.frame delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //
    //    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //    cycleScrollView2.titlesGroup = titles;
    //    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    //    [_scrollView addSubview:cycleScrollView2];
    //
    //    //         --- 模拟加载延迟
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    //    });
    
    _scrollView.contentSize = CGSizeMake(kScreenW*imageNames.count, _headerView.frame.size.height);
    [self.view addSubview:_scrollView];
    AppDelegate *app =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    imgV=[[UIImageView alloc]init];
    imgV.frame=CGRectMake(kAutoWEX(5), (15), kAutoWEX(80), (20));
    UIImage *image=[UIImage imageNamed:@"touzi"];
    imgV.image =image;
    [app.viewController.navigationController.navigationBar addSubview:imgV];
    

    CGRect mainViewBounds = app.viewController.navigationController.navigationBar.bounds;
    customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake((CGRectGetWidth(mainViewBounds)/2-imgV.frame.size.width+10), (CGRectGetMinY(mainViewBounds)+10), (CGRectGetWidth(mainViewBounds)/2+30), (25))];
    customSearchBar.delegate = self;
    [customSearchBar setPlaceholder:@"搜索"];
    customSearchBar.backgroundImage = [UIImage new];
    customSearchBar.showsCancelButton = NO;
    customSearchBar.searchBarStyle = UIBarMetricsDefault;
    customSearchBar.keyboardType = UIKeyboardTypeDefault;
    customSearchBar.returnKeyType = UIReturnKeySearch;
    [app.viewController.navigationController.navigationBar addSubview:customSearchBar];
    
    

    
//    button=[UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake((5), (10), kAutoWEX(60), kAutoHEX(25));
////    button.backgroundColor=[UIColor redColor];
//     button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    button.titleLabel.font = [UIFont systemFontOfSize_5:14]; 
//    [button addTarget:self action:@selector(ClickCity:) forControlEvents:UIControlEventTouchUpInside];
//    UIImage *image=[UIImage imageNamed:@"Xjiantou"];
//    [button setImage:image forState:UIControlStateNormal];
//    [button setImageEdgeInsets:UIEdgeInsetsMake(kAutoHEX(5), kAutoWEX(40), kAutoHEX(5),kAutoWEX(5))];
//    
//    [app.viewController.navigationController.navigationBar addSubview:button];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    [self loadGuideView];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if (IOSSystemVersion >= 10) {
        searchBar.searchTextPositionAdjustment = UIOffsetMake(25, 2);
    }
    return YES;
}

-(void)loadGuideView{
    //借贷信息
    UIButton *JDXXBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    JDXXBtn.frame = CGRectMake(0, _headerView.frame.size.height+kAutoHEX(2), kAutoWEX(105), kAutoHEX(112));
    JDXXBtn.backgroundColor = RGBColor(50, 126, 196);
    UIButton *JDIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    JDIcon.frame = CGRectMake(kAutoWEX(28),kAutoHEX(15), kAutoWEX(40),  kAutoHEX(45));
    [JDIcon setBackgroundImage:[UIImage imageNamed:@"jiedai"] forState:UIControlStateNormal];
    UILabel *jdLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(18), kAutoHEX(62), kAutoWEX(70), kAutoHEX(25))];
    jdLabel.text = @"借贷信息";
    jdLabel.textColor = [UIColor whiteColor];
    jdLabel.font = [UIFont systemFontOfSize_5:16];
    [JDXXBtn addSubview:jdLabel];
    [JDXXBtn addSubview:JDIcon];
    [self.view addSubview:JDXXBtn];
    [JDIcon addTarget:self action:@selector(ClickJDXX:) forControlEvents:UIControlEventTouchUpInside];
    [JDXXBtn addTarget:self action:@selector(ClickJDXX:) forControlEvents:UIControlEventTouchUpInside];
    
    //债券转让
    UIButton *ZZZRBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    ZZZRBtn.frame = CGRectMake(JDXXBtn.frame.size.width+kAutoWEX(3), _headerView.frame.size.height+kAutoHEX(2), kAutoWEX(105), kAutoHEX(112));
    ZZZRBtn.backgroundColor = RGBColor(50, 126, 196);
    UIButton *ZZIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    ZZIcon.frame = CGRectMake(kAutoWEX(28),kAutoHEX(15), kAutoWEX(51),  kAutoHEX(43));
    [ZZIcon setBackgroundImage:[UIImage imageNamed:@"zhaiquan"] forState:UIControlStateNormal];
    UILabel *ZZLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(18), kAutoHEX(62), kAutoWEX(70), kAutoHEX(25))];
    ZZLabel.text = @"债券转让";
    ZZLabel.textColor = [UIColor whiteColor];
    ZZLabel.font = [UIFont systemFontOfSize_5:16];
    [ZZZRBtn addSubview:ZZLabel];
    [ZZZRBtn addSubview:ZZIcon];
    [self.view addSubview:ZZZRBtn];
    [ZZIcon addTarget:self action:@selector(ClickZZZR:) forControlEvents:UIControlEventTouchUpInside];
    [ZZZRBtn addTarget:self action:@selector(ClickZZZR:) forControlEvents:UIControlEventTouchUpInside];
    
    //金融公司
    UIButton *JRGSBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    JRGSBtn.frame = CGRectMake(JDXXBtn.frame.size.width+ZZZRBtn.frame.size.width+kAutoWEX(6), _headerView.frame.size.height+kAutoHEX(2), kAutoWEX(105), kAutoHEX(112));
    JRGSBtn.backgroundColor = RGBColor(50, 126, 196);
    UIButton *JRIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    JRIcon.frame = CGRectMake(kAutoWEX(28),kAutoHEX(15), kAutoWEX(38), kAutoHEX(49));
    [JRIcon setBackgroundImage:[UIImage imageNamed:@"jinrong"] forState:UIControlStateNormal];
    UILabel *JRLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(18), kAutoHEX(62), kAutoWEX(70), kAutoHEX(25))];
    JRLabel.text = @"金融公司";
    JRLabel.textColor = [UIColor whiteColor];
    JRLabel.font = [UIFont systemFontOfSize_5:16];
    [JRGSBtn addSubview:JRLabel];
    [JRGSBtn addSubview:JRIcon];
    [self.view addSubview:JRGSBtn];
    [JRIcon addTarget:self action:@selector(ClickJRGS:) forControlEvents:UIControlEventTouchUpInside];
    [JRGSBtn addTarget:self action:@selector(ClickJRGS:) forControlEvents:UIControlEventTouchUpInside];
    
    //查询老赖
    UIButton *CXLLBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    CXLLBtn.frame = CGRectMake(0, _headerView.frame.size.height+JDXXBtn.frame.size.height +kAutoHEX(5), kAutoWEX(160), kAutoHEX(118));
    CXLLBtn.backgroundColor = RGBColor(57, 141, 148);
    UIButton *CXIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    CXIcon.frame = CGRectMake(kAutoWEX(50),kAutoHEX(25), kAutoWEX(51), kAutoHEX(54));
    [CXIcon setBackgroundImage:[UIImage imageNamed:@"chaxun"] forState:UIControlStateNormal];
    UILabel *CXLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(45), kAutoHEX(80), kAutoWEX(70), kAutoHEX(25))];
    CXLabel.text = @"查询老赖";
    CXLabel.textColor = [UIColor whiteColor];
    CXLabel.font = [UIFont systemFontOfSize_5:16];
    [CXLLBtn addSubview:CXLabel];
    [CXLLBtn addSubview:CXIcon];
    [self.view addSubview:CXLLBtn];
     [CXIcon addTarget:self action:@selector(ClickCXLL:) forControlEvents:UIControlEventTouchUpInside];
    [CXLLBtn addTarget:self action:@selector(ClickCXLL:) forControlEvents:UIControlEventTouchUpInside];
    
    //钱来啦！
    UIButton *QLLBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    QLLBtn.frame = CGRectMake(CXLLBtn.frame.size.width + kAutoWEX(3), _headerView.frame.size.height+JDXXBtn.frame.size.height +kAutoHEX(5), kAutoWEX(158), kAutoHEX(58));
    QLLBtn.backgroundColor = RGBColor(57, 141, 148);
    UIButton *QLLIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    QLLIcon.frame = CGRectMake(kAutoWEX(10),kAutoHEX(10), kAutoWEX(38), kAutoHEX(38));
    [QLLIcon setBackgroundImage:[UIImage imageNamed:@"qianlaile"] forState:UIControlStateNormal];
    UILabel *QLLLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(60), kAutoHEX(18), kAutoWEX(70), kAutoHEX(25))];
    QLLLabel.text = @"钱来啦！";
    QLLLabel.textColor = [UIColor whiteColor];
    QLLLabel.font = [UIFont systemFontOfSize_5:16];
    [QLLBtn addSubview:QLLLabel];
    [QLLBtn addSubview:QLLIcon];
    [self.view addSubview:QLLBtn];
    [QLLIcon addTarget:self action:@selector(ClickQLL:) forControlEvents:UIControlEventTouchUpInside];
    [QLLBtn addTarget:self action:@selector(ClickQLL:) forControlEvents:UIControlEventTouchUpInside];
    
    //悬赏广告
    UIButton *XSGGBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    XSGGBtn.frame = CGRectMake(CXLLBtn.frame.size.width + kAutoWEX(3), _headerView.frame.size.height+JDXXBtn.frame.size.height +QLLBtn.frame.size.height +kAutoHEX(7), kAutoWEX(158), kAutoHEX(58));
    XSGGBtn.backgroundColor = RGBColor(57, 141, 148);
    UIButton *XSGGIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    XSGGIcon.frame = CGRectMake(kAutoWEX(10),kAutoHEX(10), kAutoWEX(36), kAutoHEX(37));
    [XSGGIcon setBackgroundImage:[UIImage imageNamed:@"xuanshang"] forState:UIControlStateNormal];
    UILabel *XSGGLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(60), kAutoHEX(18), kAutoWEX(70), kAutoHEX(25))];
    XSGGLabel.text = @"悬赏广告";
    XSGGLabel.textColor = [UIColor whiteColor];
    XSGGLabel.font = [UIFont systemFontOfSize_5:16];
    [XSGGBtn addSubview:XSGGLabel];
    [XSGGBtn addSubview:XSGGIcon];
    [self.view addSubview:XSGGBtn];
    [XSGGIcon addTarget:self action:@selector(ClickXSGG:) forControlEvents:UIControlEventTouchUpInside];
    [XSGGBtn addTarget:self action:@selector(ClickXSGG:) forControlEvents:UIControlEventTouchUpInside];
    
    //有问有答
    UIButton *YWYDBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    YWYDBtn.frame = CGRectMake(0, _headerView.frame.size.height+JDXXBtn.frame.size.height +CXLLBtn.frame.size.height +kAutoHEX(8), kAutoWEX(105), kAutoHEX(112));
    YWYDBtn.backgroundColor = RGBColor(64, 151, 110);
    UIButton *YWYDIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    YWYDIcon.frame = CGRectMake(kAutoWEX(28),kAutoHEX(15), kAutoWEX(34), kAutoHEX(47));
    [YWYDIcon setBackgroundImage:[UIImage imageNamed:@"youwen"] forState:UIControlStateNormal];
    UILabel *YWYDLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(18), kAutoHEX(62), kAutoWEX(70), kAutoHEX(25))];
    YWYDLabel.text = @"有问有答";
    YWYDLabel.textColor = [UIColor whiteColor];
    YWYDLabel.font = [UIFont systemFontOfSize_5:16];
    [YWYDBtn addSubview:YWYDLabel];
    [YWYDBtn addSubview:YWYDIcon];
    [self.view addSubview:YWYDBtn];
    [YWYDIcon addTarget:self action:@selector(ClickYWYD:) forControlEvents:UIControlEventTouchUpInside];
    [YWYDBtn addTarget:self action:@selector(ClickYWYD:) forControlEvents:UIControlEventTouchUpInside];

    //联盟论坛
    UIButton *LMLTBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    LMLTBtn.frame = CGRectMake(YWYDBtn.frame.size.width+kAutoWEX(3), _headerView.frame.size.height+JDXXBtn.frame.size.height +CXLLBtn.frame.size.height +kAutoHEX(8), kAutoWEX(213), kAutoHEX(112));
    LMLTBtn.backgroundColor = RGBColor(64, 151, 110);
    UIButton *LMLTIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    LMLTIcon.frame = CGRectMake(kAutoWEX(66),kAutoHEX(15), kAutoWEX(63), kAutoHEX(55));
    [LMLTIcon setBackgroundImage:[UIImage imageNamed:@"lianmeng"] forState:UIControlStateNormal];
    UILabel *LMLTLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(68), kAutoHEX(70), kAutoWEX(70), kAutoHEX(25))];
    LMLTLabel.text = @"联盟论坛";
    LMLTLabel.textColor = [UIColor whiteColor];
    LMLTLabel.font = [UIFont systemFontOfSize_5:16];
    [LMLTBtn addSubview:LMLTLabel];
    [LMLTBtn addSubview:LMLTIcon];
    [self.view addSubview:LMLTBtn];
     [LMLTIcon addTarget:self action:@selector(ClickLMLT:) forControlEvents:UIControlEventTouchUpInside];
    [LMLTBtn addTarget:self action:@selector(ClickLMLT:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)ClickJDXX:(UIButton *)sender{
    NSLog(@"JDXX");
    HomePageViewController *home=[[HomePageViewController alloc]init];
    [self.navigationController pushViewController:home animated:YES];
}

-(void)ClickZZZR:(UIButton *)sender{
    NSLog(@"ZZZR");
}
-(void)ClickJRGS:(UIButton *)sender{
    NSLog(@"JRGS");
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    [userdefault setObject:@"jrgs" forKey:@"JRGS"];
    [userdefault synchronize];
    
    HomePageViewController *home=[[HomePageViewController alloc]init];
    [self.navigationController pushViewController:home animated:YES];
}

-(void)ClickCXLL:(UIButton *)sender{
    NSLog(@"CXLL");
}
-(void)ClickQLL:(UIButton *)sender{
    NSLog(@"QLL");
}

-(void)ClickXSGG:(UIButton *)sender{
    NSLog(@"XSGG");
}

-(void)ClickYWYD:(UIButton *)sender{
    NSLog(@"YWYD");
}
-(void)ClickLMLT:(UIButton *)sender{
    NSLog(@"LMLT");
}


-(void)ClickCity:(UIButton*)sender{
    ProvinceViewController *province=[[ProvinceViewController alloc]init];
    [self.navigationController pushViewController:province animated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
    //    [你的CycleScrollview adjustWhenControllerViewWillAppera];
    customSearchBar.hidden=NO;
//    button.hidden=NO;
    imgV.hidden = NO;
//    if ([[CityViewController shareInstance].cityStr isEqualToString:@""]) {
//        [button setTitle:@"邢台" forState:UIControlStateNormal];
//    }else{
//        [button setTitle:[CityViewController shareInstance].cityStr forState:UIControlStateNormal];
//    }
}

//#pragma mark - CLLocationManangerDelegate
////定位成功以后调用
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    
//    [self.locationManager stopUpdatingLocation];
//    CLLocation *location = locations.lastObject;
//    [self reverseGeocoder:location];
//}

#pragma mark Geocoder
//- (void)reverseGeocoder:(CLLocation *)currentLocation {
//    
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    
//    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks,NSError *error) {
//        if(error || placemarks.count ==0){
//            [button setTitle:@"邢台" forState:UIControlStateNormal];
//            NSLog(@"error = %@",error);
//        }else{
//            CLPlacemark  *placemark = placemarks.firstObject;
//            NSLog(@"省：%@",[[placemark addressDictionary] objectForKey:@"State"]);
//            NSLog(@"您所在的城市为:%@",[[placemark addressDictionary]objectForKey:@"City"]);
//            NSString * CityStr=[[placemark addressDictionary]objectForKey:@"City"];
//            [button setTitle:CityStr forState:UIControlStateNormal];
//        }
//    }];
//}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if ([customSearchBar isFirstResponder]) {
        //取消第一响应者。收回键盘
        [customSearchBar resignFirstResponder];
    }
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    customSearchBar.hidden=YES;
//    button.hidden=YES;
    imgV.hidden=YES;
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
