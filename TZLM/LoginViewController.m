//
//  LoginViewController.m
//  TZLM
//
//  Created by  sun on 2017/2/27.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "LoginViewController.h"
#import "SMGlobalMethod.h"
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
    _passwordTF.secureTextEntry = YES;
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
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


-(void)ClickLoginBtn:(UIButton*)sender{
    
    if (![SMGlobalMethod validateMobile:_phoneTF.text]) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];
    }else if (![SMGlobalMethod validatePassword:_passwordTF.text]){
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请输入6-30个字符" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    else{
        [CFProgressHUD hideHUD];
        [self keyboardHide];
        [CFProgressHUD showLoading];
        NSDictionary *dict=@{@"username":_phoneTF.text,@"password":_passwordTF.text};
        NSMutableDictionary *paramDict=[NSMutableDictionary dictionaryWithDictionary:dict];
        [WMHttpTool noCachePost:kUser_Login params:paramDict success:^(id responseObj) {
            [CFProgressHUD hideHUD];
            NSString *string = [NSString stringWithFormat:@"%@",[responseObj objectForKey:@"state"]];
            NSString *message = [NSString stringWithFormat:@"%@",[responseObj objectForKey:@"msg"]];
            if ([string isEqualToString:@"1"]) {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
                [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //点击按钮的响应事件；
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }]];
                [self presentViewController:alertC animated:YES completion:nil];
            }else{
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
                [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertC animated:YES completion:nil];
            }

        } failure:^(NSError *error) {
            [CFProgressHUD hideHUD];
        }];
        
    }

}


-(void)keyboardHide{
    if ([_phoneTF isFirstResponder]) {
        //取消第一响应者。收回键盘
        [_phoneTF resignFirstResponder];
    }
    else if ([_passwordTF isFirstResponder]) {
        //取消第一响应者。收回键盘
        [_passwordTF resignFirstResponder];
    }
}

-(void)ClickRegist:(UIButton*)sender{
    RegisterViewController *registVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}



-(void)ClickWXBtn:(UIButton*)sender{
    
}

-(void)ClickQQBtn:(UIButton*)sender{
    
    
}

- (void)keyboardWillShow:(NSNotification *)info
{
    CGRect keyboardBounds = [[[info userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float f =  keyboardBounds.size.height;
    self.view.frame = CGRectMake(0, -f+kAutoHEX(170),self.view.frame.size.width, self.view.frame.size.height);
    
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
