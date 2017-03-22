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

@interface HomePageViewController ()

@property (nonatomic,strong) HYTabbarView * tabbarView;

@end

@implementation HomePageViewController


//懒加载
- (HYTabbarView *)tabbarView{
    
    if (!_tabbarView) {
        _tabbarView = ({
            
            HYTabbarView * tabbar = [[HYTabbarView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64)];
            
            RecommendViewController * vc0 = [[RecommendViewController alloc]init];
            vc0.title = @"推荐";
            [tabbar addSubItemWithViewController:vc0];
            
            BorrowInfoViewController * vc1 = [[BorrowInfoViewController alloc]init];
            vc1.title = @"热点";
            [tabbar addSubItemWithViewController:vc1];
            
            BorrowInfoViewController * vc2 = [[BorrowInfoViewController alloc]init];
            vc2.title = @"视频";
            [tabbar addSubItemWithViewController:vc2];
            
            BorrowInfoViewController * vc3 = [[BorrowInfoViewController alloc]init];
            vc3.title = @"中国好声音";
            [tabbar addSubItemWithViewController:vc3];
            
            BorrowInfoViewController * vc4 = [[BorrowInfoViewController alloc]init];
            vc4.title = @"数码";
            [tabbar addSubItemWithViewController:vc4];
            
            BorrowInfoViewController * vc5 = [[BorrowInfoViewController alloc]init];
            vc5.title = @"头条号";
            [tabbar addSubItemWithViewController:vc5];
            
            BorrowInfoViewController * vc6 = [[BorrowInfoViewController alloc]init];
            vc6.title = @"房产";
            [tabbar addSubItemWithViewController:vc6];
            
            BorrowInfoViewController * vc7 = [[BorrowInfoViewController alloc]init];
            vc7.title = @"奥运会";
            [tabbar addSubItemWithViewController:vc7];
            
            BorrowInfoViewController * vc8 = [[BorrowInfoViewController alloc]init];
            vc8.title = @"时尚";
            [tabbar addSubItemWithViewController:vc8];
            
            QueryInfoViewController * vc9 = [[QueryInfoViewController alloc]init];
            vc9.title = @"自定义控制器";
            [tabbar addSubItemWithViewController:vc9];
            
            tabbar;
        });
    }
    return _tabbarView;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

     [self.view addSubview:self.tabbarView];

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
