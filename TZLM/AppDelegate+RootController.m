//
//  AppDelegate+RootController.m
//  TZLM
//
//  Created by  sun on 2017/2/25.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//
#import "TZConfig.h"
#import "pchFile.pch"
#import "AppDelegate+RootController.h"

@interface AppDelegate ()<RDVTabBarControllerDelegate,UIScrollViewDelegate>

@end

@implementation AppDelegate (RootController)

/**
 *  根视图
 */
- (void)setRootViewController
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isOne"])
    {//不是第一次安装
     
        [self setRoot];
        //   self.window.rootViewController = self.viewController;
        
    }
    else
    {
        UIViewController *emptyView = [[ UIViewController alloc ]init ];
        self. window .rootViewController = emptyView;
        [self createLoadingScrollView];
    }
}

- (void)setRoot
{
    UINavigationController * navc = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    navc.navigationBar.barTintColor = Main_Color;
    
    navc.navigationBar.shadowImage = [[UIImage alloc] init];
    [navc.navigationBar setTranslucent:NO];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    
    [navc.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize_5:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    navc.navigationBar.tintColor = [UIColor whiteColor];
    self.window.rootViewController = navc;
}

/**
 *  tabbar实例
 */
#pragma mark - Windows
- (void)setTabbarController{
    
    GuideHomePageViewController *home = [[GuideHomePageViewController alloc]init];
//     UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:home];
    
    BorrowInfoViewController *borrow  = [[BorrowInfoViewController alloc]init];
//      UINavigationController *borrowNav = [[UINavigationController alloc]initWithRootViewController:borrow];
    
    QueryInfoViewController *query = [[QueryInfoViewController alloc]init];
//     UINavigationController *queryNav = [[UINavigationController alloc]initWithRootViewController:query];
    
    AboutMyViewController *about = [[AboutMyViewController alloc]init];
//      UINavigationController *aboutNav = [[UINavigationController alloc]initWithRootViewController:about];
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
//    tabBarController.navigationItem.title = @"投资联盟";
    [tabBarController setViewControllers:@[home,borrow,query,about]];
    self.viewController = tabBarController;
    tabBarController.delegate = self;
    [self customizeTabBarForController:tabBarController];
    
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController
{
    
    UIImage *finishedImage = [VTGeneralTool createImageWithColor:[UIColor colorWithRed:37.0f/255.0f green:165.0f/255.0f blue:129.0f/255.0f alpha:1.0]];
    UIImage *unfinishedImage = [VTGeneralTool createImageWithColor: Main_Color];
                    
//    NSArray *tabBarItemImages = @[@"tpo_tab_home",@"tpo_tab_found",@"tab_children",@"tpo_tab_course",@"tpo_tab_user"];
//    NSArray *selectedImages = @[@"tpo_tab_home_pre",@"tpo_tab_found_pre",@"tab_children_pre",@"tpo_tab_course_pre",@"tpo_tab_user_pre"];
    
    //    NSArray *tabBarItemImages = @[@"tab_home",@"tab_Community",@"-child-dynamic.png",@"tab_relation",@"tab_me"];
    //    NSArray *selectedImages = @[@"tab_home_pre",@"tab_Community_pre",@"-child-dynamic.png",@"tab_relation_pre",@"tab_me_pre"];
    
    NSInteger index = 0;
    [[tabBarController tabBar] setTranslucent:YES];
    for (RDVTabBarItem *item in [[tabBarController tabBar] items])
    {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
//        UIImage *selectedimage = [UIImage imageNamed:[selectedImages objectAtIndex:index]];
//        UIImage *unselectedimage = [UIImage imageNamed:[tabBarItemImages objectAtIndex:index]];
        //        item.imagePositionAdjustment = UIOffsetMake(0, -5);
//        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        NSDictionary *unseleAtrr = @{
                                     NSFontAttributeName: [UIFont systemFontOfSize_5:15],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
        NSDictionary *seleAtrr = @{
                                   NSFontAttributeName: [UIFont systemFontOfSize_5:15],
                                   NSForegroundColorAttributeName: [UIColor whiteColor],
                                   };
        [item setUnselectedTitleAttributes:unseleAtrr];
        [item setSelectedTitleAttributes:seleAtrr];
        
        [item setTitle:@[@"主页",@"发布",@"联盟论坛",@"我的"][index]];
        
        index++;
    }
}
/**
 *  window实例
 */
-(void)setAppWindows{
    self.window =[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
}

/**
 *  首次启动轮播图
 */
#pragma mark - 引导页
-(void)createLoadingScrollView{//引导页
    UIScrollView *sc =[[UIScrollView alloc]initWithFrame:self.window.bounds];
    sc.pagingEnabled=YES;
    sc.delegate=self;
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    [self.window.rootViewController.view addSubview:sc];
    
    NSArray *arr=@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    for (NSInteger i=0; i<arr.count; i++) {
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW*i, 0, kScreenW, self.window.frame.size.height)];
        
        img.image=[UIImage imageNamed:arr[i]];
        [sc addSubview:img];
        img.userInteractionEnabled=YES;
        if (i == arr.count - 1) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame=CGRectMake((self.window.frame.size.width/2)-50, kScreenH-110, 100, 40);
            btn.backgroundColor=Main_Color;
            [btn setTitle:@"开始体验" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goToMain) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor= Main_Color.CGColor;
            
        }
    }
    sc.contentSize = CGSizeMake(kScreenW*arr.count, self.window.frame.size.height);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x>kScreenW*4+30) {
        [self goToMain];
    }
}


-(void)goToMain{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:@"isOne" forKey:@"isOne"];
    [user synchronize];
    [self setRoot];
    
    
}

-(void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if ([viewController isKindOfClass:[GuideHomePageViewController class]])
    {
        tabBarController.navigationController.navigationBarHidden=NO;
        tabBarController.navigationItem.title = @"";
    }
    if ([viewController isKindOfClass:[BorrowInfoViewController class]])
    {
        tabBarController.navigationController.navigationBarHidden=NO;
        tabBarController.navigationItem.title = @"发布";
    }
    if ([viewController isKindOfClass:[QueryInfoViewController class]])
    {
        tabBarController.navigationController.navigationBarHidden=NO;
        tabBarController.navigationItem.title = @"联盟论坛";
    }

    if ([viewController isKindOfClass:[AboutMyViewController class]])
    {
        tabBarController.navigationController.navigationBarHidden=YES;
        tabBarController.navigationItem.title = @"我的";
    }
    
}


@end
