//
//  RegisterViewController.m
//  TZLM
//
//  Created by  sun on 2017/2/27.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "RegisterViewController.h"
#import "SMGlobalMethod.h"
@interface RegisterViewController (){
    UITextField *phonetext;
    UITextField *VeriTextV;
    UITextField *PassTextV;
    UIButton *veriBtn;
    UIButton *submitBtn;
    UIButton *btn;
    dispatch_source_t _timer;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    self.view.backgroundColor = RGBColor(235, 230, 229);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(120), kAutoHEX(20), kAutoWEX(100), kAutoHEX(35))];
    [label setTextColor:[UIColor blackColor]];
    label.text = @"投资联盟";
    label.font = [UIFont systemFontOfSize_5:20];
    [self.view addSubview:label];
    
    phonetext = [[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(33), kAutoHEX(63),kAutoWEX(257),kAutoHEX(32))];
    phonetext.layer.borderWidth = 0.1f;
    phonetext.placeholder = @"手机号";
    phonetext.backgroundColor= [UIColor whiteColor];
    phonetext.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phonetext];
    
    VeriTextV = [[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(33), kAutoHEX(66+35+15),kAutoWEX(193),kAutoHEX(32))];
    VeriTextV.layer.borderWidth = 0.1f;
    VeriTextV.placeholder = @"验证码";
    VeriTextV.backgroundColor= [UIColor whiteColor];
    VeriTextV.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:VeriTextV];
    
    veriBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    veriBtn.frame = CGRectMake(kAutoWEX(193+33), kAutoHEX(66+35+15), kAutoWEX(60), kAutoHEX(32));
    [veriBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [veriBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    veriBtn.titleLabel.font = [UIFont systemFontOfSize_5:11];
    veriBtn.backgroundColor = [UIColor whiteColor];
    veriBtn.layer.borderWidth=0.5f;
    veriBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [veriBtn addTarget:self action:@selector(veriBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:veriBtn];

    
    PassTextV = [[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(33), kAutoHEX(66+70+35),kAutoWEX(257),kAutoHEX(32))];
    PassTextV.layer.borderWidth = 0.1f;
    PassTextV.placeholder = @"密码";
    PassTextV.backgroundColor= [UIColor whiteColor];
    PassTextV.secureTextEntry = YES;
    [self.view addSubview:PassTextV];
    
    submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(kAutoWEX(70), kAutoHEX(176+65), kAutoWEX(178), kAutoHEX(35));
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize_5:18];
    submitBtn.backgroundColor = RGBColor(24, 32, 48);
    [submitBtn addTarget:self action:@selector(ClickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kAutoWEX(63), kAutoHEX(300), kAutoWEX(18), kAutoHEX(18));
    [btn setBackgroundImage:[UIImage imageNamed:@"zhuce_on"] forState:UIControlStateNormal];
     btn.selected = YES;
    [btn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *btnlabel = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(83), kAutoHEX(300), kAutoWEX(90), kAutoHEX(20))];
    btnlabel.text = @"我已阅读并同意";
    [btnlabel setTextColor:RGBColor(183, 174, 174)];
    btnlabel.font = [UIFont systemFontOfSize_5:12];
    [self.view addSubview:btnlabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kAutoWEX(165), kAutoHEX(300), kAutoWEX(125), kAutoHEX(20));
    [button setTitleColor:RGBColor(24, 32, 48) forState:UIControlStateNormal];
    [button setTitle:@"《投资联盟用户协议》" forState:UIControlStateNormal];
     button.titleLabel.font = [UIFont systemFontOfSize_5:12];
    [self.view addSubview:button];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

//发送验证码
-(void)veriBtnClick:(UIButton*)sender{
    [CFProgressHUD hideHUD];
    [self keyboardHide];
    if ([self check]) {
        [CFProgressHUD showLoading];
        NSDictionary *dict=@{@"m_code":phonetext.text};
        NSMutableDictionary *paramDict=[NSMutableDictionary dictionaryWithDictionary:dict];
     [WMHttpTool noCacheGet:kUser_Verify params:paramDict success:^(id responseObj) {
        [CFProgressHUD hideHUD];
         NSString *message = [NSString stringWithFormat:@"%@",[responseObj objectAtIndex:1][@"msg"]];
         UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
         [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 veriBtn.enabled=NO;
                 [self startTimer];
             
         }]];
         [self presentViewController:alertC animated:YES completion:nil];

     } failure:^(NSError *error) {
              [CFProgressHUD hideHUD];
     }];
    }
}

#pragma mark - Timer
- (void)startTimer {
    __block int timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //更新界面显示
                veriBtn.enabled = YES;
  
            });
        }else {
            timeout--;
            dispatch_async(dispatch_get_main_queue(), ^{
                //更新界面显示
                veriBtn.titleLabel.text = [NSString stringWithFormat:@"%d秒",timeout];
            });
        }
    });
    dispatch_resume(_timer);
}


#pragma mark - Check
/*
 校验
 */
- (BOOL)check {
    BOOL result = NO;
    NSString *message = @"";
    if (phonetext.text.length == 0) {
        message = @"手机号码不能为空";
    }else if (![SMGlobalMethod validateMobile:phonetext.text]) {
        message = @"请输入正确的手机号码";
    }else {
        result = YES;
    }
    
    if ([message length] > 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    
    return result;
}


-(void)ClickSubmit:(UIButton*)sender{
    if (![SMGlobalMethod validateMobile:phonetext.text]) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号" message:nil preferredStyle:UIAlertControllerStyleAlert];
           [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertC animated:YES completion:nil];
    }else if ([VeriTextV.text length] == 0){
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"短信密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];

    }
    else if (![SMGlobalMethod validatePassword:PassTextV.text]){
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请输入6-30个字符" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    else{
    [CFProgressHUD hideHUD];
      [self keyboardHide];
     [CFProgressHUD showLoading];
    NSDictionary *dict=@{@"m_code":phonetext.text,@"password":PassTextV.text,@"m_verify":VeriTextV.text};
    NSMutableDictionary *paramDict=[NSMutableDictionary dictionaryWithDictionary:dict];
    [WMHttpTool noCachePost:kUser_Register params:paramDict success:^(id responseObj) {
        [CFProgressHUD hideHUD];
        NSString *string = [NSString stringWithFormat:@"%@",[responseObj objectAtIndex:0][@"state"]];
        NSString *message = [NSString stringWithFormat:@"%@",[responseObj objectAtIndex:1][@"msg"]];
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

-(void)ClickBtn:(UIButton*)sender{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"zhuce_on"] forState:UIControlStateNormal];
        submitBtn.userInteractionEnabled=YES;
        submitBtn.alpha=1.0f;
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"zhuce_off"] forState:UIControlStateNormal];
        submitBtn.userInteractionEnabled=NO;
        submitBtn.alpha=0.4f;
    }
    
}

-(void)keyboardHide{
    if ([phonetext isFirstResponder]) {
        //取消第一响应者。收回键盘
        [phonetext resignFirstResponder];
    }
   else if ([VeriTextV isFirstResponder]) {
        //取消第一响应者。收回键盘
        [VeriTextV resignFirstResponder];
    }else  {
        //取消第一响应者。收回键盘
        [PassTextV resignFirstResponder];
    }
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
