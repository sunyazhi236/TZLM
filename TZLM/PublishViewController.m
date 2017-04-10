//
//  PublishViewController.m
//  TZLM
//
//  Created by  sun on 2017/4/8.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "PublishViewController.h"

#define Start_X         (0.0f)      // 第一个按钮的X坐标
#define Start_Y         (0.0f)     // 第一个按钮的Y坐标
#define Width_Space     (2.0f)      // 2个按钮之间的横间距
#define Height_Space    (2.0f)     // 竖间距
#define Button_Height   (97.0f)    // 高
#define Button_Width    (105.0f)    // 宽

#define Start_XI         (30.0f)      // 第一个按钮的X坐标
#define Start_YI         (9.0f)     // 第一个按钮的Y坐标
#define Width_SpaceI     (60.0f)      // 2个按钮之间的横间距
#define Height_SpaceI    (46.0f)     // 竖间距
#define Button_HeightI   (51.0f)    // 高
#define Button_WidthI    (45.0f)    // 宽

#define Start_XX         (0.0f)      // 第一个按钮的X坐标
#define Start_YX         (62.0f)     // 第一个按钮的Y坐标
#define Width_SpaceX     (0.0f)      // 2个按钮之间的横间距
#define Height_SpaceX    (80.0f)     // 竖间距
#define Button_HeightX   (20.0f)    // 高
#define Button_WidthX    (105.0f)    // 宽

@interface PublishViewController (){
    UIView *_maskView;
    UIButton *QXBtn;
    UIScrollView *_scrollView;
}
@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(215, 215, 215);
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, kAutoHEX(125), kScreenW, kAutoHEX(46))];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];

    QXBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    QXBtn.frame = CGRectMake(kAutoWEX(280), kAutoHEX(12), kAutoWEX(23), kAutoHEX(23));
    [QXBtn setBackgroundImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [QXBtn addTarget:self action:@selector(Clickdiss:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:QXBtn];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kAutoHEX(174), kScreenW, kAutoHEX(394))];
    _scrollView.backgroundColor  = RGBColor(215, 215, 215);
    _scrollView.contentSize = CGSizeMake(kScreenW, kAutoHEX(493));
    [self.view addSubview:_scrollView];
    

    NSArray *images = @[@"fabu1",@"fabu2",@"fabu3",@"fabu4",@"fabu5",@"fabu6",@"fabu7",@"fabu8",@"fabu9",@"fabu10",@"fabu11",@"fabu12",@"fabu13"];
    NSArray *labeltexts = @[@"借款信息",@"放款信息",@"申请贷款",@"金融公司",@"金融顾问",@"抵押车转让",@"其他债权转让",@"网贷口子",@"信用卡秘笈",@"联盟寻车",@"租赁抵押联盟",@"联盟论坛",@"发布老赖"];
    for (int i = 0; i < images.count; i++) {
         NSInteger index = i % 3;
        NSInteger page = i / 3;
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bgBtn.frame = CGRectMake(kAutoWEX(index * (Button_Width + Width_Space) + Start_X), kAutoHEX (page  * (Button_Height + Height_Space)+Start_Y),kAutoWEX(Button_Width), kAutoWEX(Button_Height));
        bgBtn.tag = 1000 + i;
        bgBtn.backgroundColor = [UIColor whiteColor];
   
        [bgBtn addTarget:self action:@selector(didClickbgBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:bgBtn];
        UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = CGRectMake(kAutoWEX(index * (Button_WidthI + Width_SpaceI) + Start_XI), kAutoHEX (page  * (Button_HeightI + Height_SpaceI)+Start_YI),kAutoWEX([UIImage imageNamed:images[i]].size.width), kAutoWEX([UIImage imageNamed:images[i]].size.height));
        imageBtn.tag = 1000 + i;
        [imageBtn addTarget:self action:@selector(didClickbgBtn:) forControlEvents:UIControlEventTouchUpInside];
        [imageBtn setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [_scrollView addSubview:imageBtn];
        
    UILabel *labelT = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(index * (Button_WidthX + Width_SpaceX) + Start_XX), kAutoHEX (page  * (Button_HeightX + Height_SpaceX)+Start_YX),kAutoWEX(Button_WidthX), kAutoWEX(Button_HeightX))];
        labelT.text  = labeltexts[i];
        labelT.textAlignment = NSTextAlignmentCenter;
        labelT.font = [UIFont systemFontOfSize_5:16];
        [_scrollView addSubview:labelT];
    }
    
}

-(void)didClickbgBtn:(UIButton*)sender{
    if (sender.tag == 1000) {
           NSLog(@"1000");
    }else{
        NSLog(@"123456789");

    }
    
}

-(void)Clickdiss:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)addMaskView{
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        _maskView.alpha= 0.5;
    }];
    [self.view addSubview:_maskView];
    
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
