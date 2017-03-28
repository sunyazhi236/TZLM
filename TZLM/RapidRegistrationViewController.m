//
//  RapidRegistrationViewController.m
//  TZLM
//
//  Created by  sun on 2017/3/28.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "RapidRegistrationViewController.h"

@interface RapidRegistrationViewController ()

@end

@implementation RapidRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"急速注册";
    self.view.backgroundColor = RGBColor(205, 205, 205);
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kAutoHEX(50))];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    UILabel *JSZClabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW/2, kAutoHEX(50))];
    JSZClabel.text = @"急速注册";
    [JSZClabel setTextColor:RGBColor(251, 38, 50)];
    JSZClabel.textAlignment = NSTextAlignmentCenter;
    JSZClabel.font =[UIFont systemFontOfSize_5:18];
    [bgView addSubview:JSZClabel];
    UILabel *FBDKlabel =[[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2, 0, kScreenW/2, kAutoHEX(50))];
    FBDKlabel.text = @"发布贷款";
    [FBDKlabel setTextColor:RGBColor(158, 158, 158)];
    FBDKlabel.font =[UIFont systemFontOfSize_5:18];
    FBDKlabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:FBDKlabel];
    //12  16   288 205
    UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW/2-kAutoWEX(26), kAutoHEX(50), kAutoWEX(26), kAutoHEX(50))];
    imgV.image = [UIImage imageNamed:@"jisuzhuceArrow"];
    [bgView addSubview:imgV];
    
    UIView *sencondBGV = [[UIView alloc]initWithFrame:CGRectMake(kAutoWEX(18), kAutoHEX(85), kAutoWEX(288), kAutoHEX(205))];
    sencondBGV.backgroundColor = [UIColor whiteColor];
    sencondBGV.layer.cornerRadius = 14.0f;
    sencondBGV.layer.masksToBounds = YES;
    [self.view addSubview:sencondBGV];
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
