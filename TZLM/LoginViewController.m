//
//  LoginViewController.m
//  TZLM
//
//  Created by  sun on 2017/2/27.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (){
    UITextField *_phoneTF;
    UITextField *_passwordTF;
    UIButton *_loginBtn;
    UIButton *_WXLoginBtn;
    UIButton *_QQLoginBtn;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.view.backgroundColor = RGBColor(235, 230, 229);
    UIImageView  *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kAutoWEX(110), kAutoHEX(70), kAutoWEX(112), kAutoHEX(147))];
    imageV.image = [UIImage imageNamed:@"loginUSER"];
    [self.view addSubview:imageV];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(80), kAutoHEX(237), kAutoWEX(40), kAutoHEX(20))];
    label.text = @"登录";
    label.textColor =[UIColor blackColor];
    [label setFont:[UIFont systemFontOfSize_5:13]];
    [self.view addSubview:label];
    UIButton *regisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regisBtn.frame = CGRectMake(kAutoWEX(210), kAutoHEX(237), kAutoWEX(60), kAutoHEX(20));
    [regisBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [regisBtn setTitleColor:RGBColor(58, 93, 216) forState:UIControlStateNormal];
    [regisBtn.titleLabel setFont:[UIFont systemFontOfSize_5:13]];
    [regisBtn addTarget:self action:@selector(ClickRegist:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regisBtn];
    
    _phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(70), kAutoHEX(262), kAutoWEX(185), kAutoHEX(28))];
    _phoneTF.backgroundColor = [UIColor whiteColor];
    _phoneTF.layer.cornerRadius = 14.0f;
    _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTF.layer.masksToBounds = YES;
    _phoneTF.placeholder =  @"手机号";
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTF];
    
    _passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(70), kAutoHEX(300), kAutoWEX(185), kAutoHEX(28))];
    _passwordTF.backgroundColor = [UIColor whiteColor];
    _passwordTF.layer.cornerRadius = 14.0f;
    _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTF.layer.masksToBounds = YES;
    _passwordTF.placeholder =  @"密码";
    [self.view addSubview:_passwordTF];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(kAutoWEX(77), kAutoHEX(350), kAutoWEX(168), kAutoHEX(34));
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize_5:18]];
    _loginBtn.backgroundColor = RGBColor(179, 0, 4);
    _loginBtn.layer.cornerRadius = 14.0f;
    _loginBtn.layer.masksToBounds = YES;
    [_loginBtn addTarget:self action:@selector(ClickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _WXLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _WXLoginBtn.frame = CGRectMake(kAutoWEX(100), kAutoHEX(410), kAutoWEX(42), kAutoHEX(40));
    [_WXLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_4"] forState:UIControlStateNormal];
    [_WXLoginBtn addTarget:self action:@selector(ClickWXBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_WXLoginBtn];
    _QQLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _QQLoginBtn.frame = CGRectMake(kAutoWEX(180), kAutoHEX(410), kAutoWEX(42), kAutoHEX(40));
    [_QQLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_5"] forState:UIControlStateNormal];
    [_QQLoginBtn addTarget:self action:@selector(ClickQQBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_QQLoginBtn];

}

-(void)ClickRegist:(UIButton*)sender{
    RegisterViewController *registVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}

-(void)ClickLoginBtn:(UIButton*)sender{
    
}

-(void)ClickWXBtn:(UIButton*)sender{
    
}

-(void)ClickQQBtn:(UIButton*)sender{
    
    
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
