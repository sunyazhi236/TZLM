//
//  FinancialFirmsViewController.m
//  TZLM
//
//  Created by  sun on 2017/3/31.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "FinancialFirmsViewController.h"

@interface FinancialFirmsViewController ()

@end

@implementation FinancialFirmsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(206, 206, 206);
    //上条白色背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kAutoHEX(55))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    //金融公司button label
    UIButton *jrgsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jrgsBtn.frame = CGRectMake(kAutoWEX(16), kAutoHEX(7), kAutoWEX(42), kAutoHEX(42));
    [jrgsBtn setBackgroundImage:[UIImage imageNamed:@"jrgs_01"] forState:UIControlStateNormal];
    [bgView addSubview:jrgsBtn];
    UILabel *jrgsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW/2, kAutoHEX(55))];
    jrgsLabel.text = @"         金融公司";
    jrgsLabel.textAlignment = NSTextAlignmentCenter;
    [jrgsLabel setFont:[UIFont systemFontOfSize_5:16]];
    jrgsLabel.textColor  = [UIColor redColor];
    [bgView addSubview:jrgsLabel];
    //中间线
    UIView *LineV =[[UIView alloc]initWithFrame:CGRectMake(kScreenW/2, kAutoHEX(5), 1, kAutoHEX(45))];
    LineV.backgroundColor = RGBColor(202, 202, 202);
    [bgView addSubview:LineV];
    //金融顾问button label
    UIButton *jrgwBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jrgwBtn.frame = CGRectMake(kAutoWEX(194), kAutoHEX(7), kAutoWEX(42), kAutoHEX(42));
    [jrgwBtn setBackgroundImage:[UIImage imageNamed:@"jrgs_02"] forState:UIControlStateNormal];
    [bgView addSubview:jrgwBtn];
    UILabel *jrgwLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2, 0, kScreenW/2, kAutoHEX(55))];
    jrgwLabel.text = @"                   金融顾问";
    jrgwLabel.textAlignment = NSTextAlignmentCenter;
    [jrgwLabel setFont:[UIFont systemFontOfSize_5:16]];
    jrgwLabel.textColor  = [UIColor blackColor];
    [bgView addSubview:jrgwLabel];
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
