//
//  RapidRegistrationViewController.m
//  TZLM
//
//  Created by  sun on 2017/3/28.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "RapidRegistrationViewController.h"
#import "PublishLoanViewController.h"

@interface RapidRegistrationViewController (){
    UITextField *_nameTF;
    UITextField *_moneyTF;
    UITextField *_phoneTF;
    UITextField *_verificationTF;
    UIButton *_manBtn;
    UIButton *_womanBtn;
    UIButton *_captureVerBtn;
    UIButton *_submitVBtn;
}

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
    UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW/2-kAutoWEX(13), 0, kAutoWEX(26), kAutoHEX(50))];
    imgV.image = [UIImage imageNamed:@"jisuzhuceBigArrow"];
    [bgView addSubview:imgV];
    
    UIView *sencondBGV = [[UIView alloc]initWithFrame:CGRectMake(kAutoWEX(18), kAutoHEX(85), kAutoWEX(288), kAutoHEX(205))];
    sencondBGV.backgroundColor = [UIColor whiteColor];
    sencondBGV.layer.cornerRadius = 14.0f;
    sencondBGV.layer.masksToBounds = YES;
    [self.view addSubview:sencondBGV];

    _nameTF =[[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(100), 0, kAutoWEX(168), kAutoHEX(205/5))];
    [_nameTF setFont:[UIFont systemFontOfSize_5:14]];
    [sencondBGV addSubview:_nameTF];
    
    _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _manBtn.frame=CGRectMake(kAutoWEX(130), kAutoHEX(205/5+15), kAutoWEX(16), kAutoHEX(16));
    [_manBtn setBackgroundImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateNormal];
    [_manBtn addTarget:self action:@selector(didClickManBtn:) forControlEvents:UIControlEventTouchUpInside];
    [sencondBGV addSubview:_manBtn];
    UILabel *manlabel =[[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(150), kAutoHEX(205/5+15), kAutoWEX(25), kAutoHEX(15))];
    manlabel.text = @"先生";
    [manlabel setFont:[UIFont systemFontOfSize_5:12]];
    [sencondBGV addSubview:manlabel];
    _womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _womanBtn.frame=CGRectMake(kAutoWEX(210), kAutoHEX(205/5+15), kAutoWEX(16), kAutoHEX(16));
    [_womanBtn setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [_womanBtn addTarget:self action:@selector(didClickWomanBtn:) forControlEvents:UIControlEventTouchUpInside];
    [sencondBGV addSubview:_womanBtn];
    UILabel *womanlabel =[[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(230), kAutoHEX(205/5+15), kAutoWEX(25), kAutoHEX(15))];
    womanlabel.text = @"女士";
    [womanlabel setFont:[UIFont systemFontOfSize_5:12]];
    [sencondBGV addSubview:womanlabel];
    
    
    
    _moneyTF = [[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(100), kAutoHEX(205/5)*2, kAutoWEX(168), kAutoHEX(205/5))];
    [_moneyTF setFont:[UIFont systemFontOfSize_5:14]];
    _moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    [sencondBGV addSubview:_moneyTF];
    _phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(100), kAutoHEX(205/5)*3, kAutoWEX(168), kAutoHEX(205/5))];
    [_phoneTF setFont:[UIFont systemFontOfSize_5:14]];
      _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [sencondBGV addSubview:_phoneTF];
    _verificationTF = [[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(100), kAutoHEX(205/5)*4, kAutoWEX(168-80), kAutoHEX(205/5))];
    [_verificationTF setFont:[UIFont systemFontOfSize_5:14]];
      _verificationTF.keyboardType = UIKeyboardTypeNumberPad;
    [sencondBGV addSubview:_verificationTF];
    _captureVerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _captureVerBtn.frame = CGRectMake(kAutoWEX(208), kAutoHEX(205/5)*4, kAutoWEX(80), kAutoHEX(205/5));
    [_captureVerBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_captureVerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_captureVerBtn.titleLabel setFont:[UIFont systemFontOfSize_5:14]];
    [sencondBGV addSubview:_captureVerBtn];
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(kAutoWEX(208), kAutoHEX(205/5)*4, 1, kAutoHEX(205/5))];
    lineV.backgroundColor = [UIColor blackColor];
    [sencondBGV addSubview:lineV];
    
    
    NSArray *textArray=@[@"请输入姓名:",@"请选择性别:",@"输入金额(万元):",@"手机号:",@"验证码:"];
    for (int i=0; i<5; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, kAutoHEX(205/5)*i, kAutoWEX(100), kAutoHEX(205/5))];
        label.text = [textArray objectAtIndex:i];
        [label setFont:[UIFont systemFontOfSize_5:14]];
        [label setTextColor:[UIColor blackColor]];
        label.textAlignment = NSTextAlignmentCenter;
        [sencondBGV addSubview:label];
    }
    
    for (int i=1; i<5; i++) {
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(kAutoWEX(10), kAutoHEX(205/5)*i, kAutoWEX(268), 1)];
        lineView.backgroundColor = RGBColor(233, 233, 233);
        [sencondBGV addSubview:lineView];
    }
    
    _submitVBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitVBtn.frame = CGRectMake(kAutoWEX(70), kAutoHEX(335), kAutoWEX(188), kAutoHEX(36));
    [_submitVBtn setBackgroundImage:[UIImage imageNamed:@"submitzhuce"] forState:UIControlStateNormal];
    [_submitVBtn addTarget:self action:@selector(ClickSubmitVBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitVBtn];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)ClickSubmitVBtn:(UIButton*)sender{
    PublishLoanViewController *pubLoanV = [[PublishLoanViewController alloc]init];
    [self.navigationController pushViewController:pubLoanV animated:YES];
    
}

-(void)didClickManBtn:(UIButton*)sender{
    
    [_womanBtn setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [_manBtn setBackgroundImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateNormal];
}

-(void)didClickWomanBtn:(UIButton*)sender{
    [_womanBtn setBackgroundImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateNormal];
    [_manBtn setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
}

-(void)keyboardHide{
    if ([_nameTF isFirstResponder]) {
        [_nameTF resignFirstResponder];
    }if ([_moneyTF isFirstResponder]) {
        [_moneyTF resignFirstResponder];
    }if ([_phoneTF isFirstResponder]) {
        //取消第一响应者。收回键盘
        [_phoneTF resignFirstResponder];
    }
    else if ([_verificationTF isFirstResponder]) {
        [_verificationTF resignFirstResponder];
    }
}

- (void)keyboardWillShow:(NSNotification *)info
{
    CGRect keyboardBounds = [[[info userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float f =  keyboardBounds.size.height;
    self.view.frame = CGRectMake(0, -f+kAutoHEX(230),self.view.frame.size.width, self.view.frame.size.height);
    
}
- (void)keyboardWillHide:(NSNotification *)info
{
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
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
