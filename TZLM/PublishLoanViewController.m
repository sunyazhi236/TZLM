//
//  PublishLoanViewController.m
//  TZLM
//
//  Created by  sun on 2017/3/29.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "PublishLoanViewController.h"

@interface PublishLoanViewController ()<UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    UITextView *_textView;
    UIButton *_publishBtn;
    UILabel *textViewPlaceholderLabel;
   
    UIView *sencondBGV;
    UIButton *button0;
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    
}
@property(nonatomic,strong)UIView *backgroundV;
@property (nonatomic,strong)UIPickerView * pickerView;//选择器
@property (nonatomic,strong)UIPickerView * DKLXpickerView;//选择器
@property (nonatomic,strong)UIPickerView * DKEDpickerView;//选择器
@property (nonatomic,strong)UIPickerView * DKQXpickerView;//选择器
@property (nonatomic,strong)UIPickerView * WDZXpickerView;//选择器

@property (nonatomic,strong)NSArray * persondatas;//我的身份数组
@property (nonatomic,strong)NSArray *loanTypedatas;//贷款类型数组
@property (nonatomic,strong)NSArray *loanmoneydatas;//贷款额度数组
@property (nonatomic,strong)NSArray *loanlimitdatas;//贷款期期限数组
@property (nonatomic,strong)NSArray *creditdatas; //征信
@end

@implementation PublishLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布贷款";
    self.view.backgroundColor = RGBColor(205, 205, 205);
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kAutoHEX(50))];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    UILabel *JSZClabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW/2, kAutoHEX(50))];
    JSZClabel.text = @"急速注册";
     [JSZClabel setTextColor:RGBColor(158, 158, 158)];
    JSZClabel.textAlignment = NSTextAlignmentCenter;
    JSZClabel.font =[UIFont systemFontOfSize_5:18];
    [bgView addSubview:JSZClabel];
    UILabel *FBDKlabel =[[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2, 0, kScreenW/2, kAutoHEX(50))];
    FBDKlabel.text = @"发布贷款";
    [FBDKlabel setTextColor:RGBColor(251, 38, 50)];
    FBDKlabel.font =[UIFont systemFontOfSize_5:18];
    FBDKlabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:FBDKlabel];
    //12  16   288 205
    UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenW/2-kAutoWEX(13), 0, kAutoWEX(26), kAutoHEX(50))];
    imgV.image = [UIImage imageNamed:@"jisuzhuceBigArrow"];
    [bgView addSubview:imgV];
    
    sencondBGV = [[UIView alloc]initWithFrame:CGRectMake(kAutoWEX(13), kAutoHEX(85), kAutoWEX(292), kAutoHEX(345))];
    sencondBGV.backgroundColor = [UIColor whiteColor];
    sencondBGV.layer.cornerRadius = 14.0f;
    sencondBGV.layer.masksToBounds = YES;
    [self.view addSubview:sencondBGV];
    
    NSArray *textArray=@[@"我的身份",@"贷款类型",@"贷款额度",@"贷款期限",@"我的征信"];
    for (int i=0; i<5; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, kAutoHEX(205/5)*i, kAutoWEX(292), kAutoHEX(205/5));
        [button setTitle:[textArray objectAtIndex:i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize_5:14]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
         button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        button.tag = 1000+i;
        [button addTarget:self action:@selector(ClickPicker:) forControlEvents:UIControlEventTouchUpInside];
        [sencondBGV addSubview:button];

        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(kAutoWEX(260), kAutoHEX(i*(10+30)+15), kAutoWEX(10), kAutoHEX(15))];
        imgV.image = [UIImage imageNamed:@"rightArrow"];
        [sencondBGV addSubview:imgV];
        
    }
    for (int i=1; i<6; i++) {
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(kAutoWEX(10), kAutoHEX(205/5)*i, kAutoWEX(273), 1)];
        lineView.backgroundColor = RGBColor(233, 233, 233);
        [sencondBGV addSubview:lineView];
    }
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(kAutoWEX(13), kAutoHEX(218), kAutoWEX(265), kAutoHEX(118))];
    _textView.layer.cornerRadius = 14.0f;
    _textView.layer.borderWidth = 0.5f;
    _textView.layer.borderColor = RGBColor(233, 233, 233).CGColor;
    _textView.layer.masksToBounds = YES;
    _textView.delegate = self;
    [_textView setFont:[UIFont systemFontOfSize_5:15]];
    [sencondBGV addSubview:_textView];
    
    textViewPlaceholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAutoWEX(15), kAutoHEX(10), kAutoWEX(100), kAutoHEX(25))];
    textViewPlaceholderLabel.text = @"详细说明";
    textViewPlaceholderLabel.textColor = RGBColor(221, 221, 221);
    textViewPlaceholderLabel.font = [UIFont systemFontOfSize_5:13];
    [_textView addSubview:textViewPlaceholderLabel];
    
    _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _publishBtn.frame = CGRectMake(kAutoWEX(70), kAutoHEX(450), kAutoWEX(188), kAutoHEX(35));
    [_publishBtn setBackgroundImage:[UIImage imageNamed:@"publishBtn"] forState:UIControlStateNormal];
    [_publishBtn addTarget:self action:@selector(ClickPublic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_publishBtn];
    
  
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //获取数据
    [self loadData];
    
    [self loadSelectBGView];

}

-(void)ClickPublic:(UIButton*)sender{
    if ([button0.currentTitle isEqualToString:@"我的身份"] ||[button0.currentTitle isEqualToString:@""]||button0 == nil) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择身份" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];
        
    }else if ([button1.currentTitle isEqualToString:@"贷款类型"]||[button1.currentTitle isEqualToString:@""]||button1 == nil){
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择贷款类型" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];
    }else if ([button2.currentTitle isEqualToString:@"贷款额度"]||[button2.currentTitle isEqualToString:@""]||button2 == nil) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择贷款额度" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];
    }else if ([button3.currentTitle isEqualToString:@"贷款期限"]||[button3.currentTitle isEqualToString:@""]||button3 == nil) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择贷款期限" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];
    }else if ([button4.currentTitle isEqualToString:@"我的征信"]||[button4.currentTitle isEqualToString:@""]||button4 == nil) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择征信类型" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];
    }else{
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"发布成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertC animated:YES completion:nil];

    }
    
}


-(void)loadSelectBGView{
    self.backgroundV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.view.userInteractionEnabled=YES;
    self.backgroundV.userInteractionEnabled=YES;
    self.backgroundV.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.4];
    self.backgroundV.hidden=YES;
    [self.view addSubview:self.backgroundV];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - kAutoHEX(230), kScreenW, kAutoHEX(30))];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.backgroundV addSubview:view];
    

    UIButton *finishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame = CGRectMake(kAutoWEX(260), kAutoHEX(2), kAutoWEX(50), kAutoHEX(25));
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn.titleLabel setFont:[UIFont systemFontOfSize_5:16]];
    [finishBtn setTitleColor:RGBColor(24, 173, 229) forState:UIControlStateNormal];
    finishBtn.userInteractionEnabled = YES;
    [finishBtn addTarget:self action:@selector(ClickfinishBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:finishBtn];
    
    UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(kAutoWEX(10), kAutoHEX(2), kAutoWEX(50), kAutoHEX(25));
    [cancelBtn addTarget:self action:@selector(ClickcancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGBColor(24, 173, 229) forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize_5:16]];
    [view addSubview:cancelBtn];
}

-(void)loadData{
    self.persondatas = @[@"企业",@"个人",@"公务员",@"国企职工",@"私企职工",@"个体"];
    self.loanTypedatas = @[@"票据贴现",@"信用贷款",@"车辆贷款",@"房产贷款",@"企业贷款",@"信用卡",@"网贷"];
    self.loanmoneydatas = @[@"1000-10万",@"10-100万",@"100-1000万",@"1000万"];
    self.loanlimitdatas = @[@"1-6个月",@"6-12个月",@"1-3年",@"5-10年"];
    self.creditdatas = @[@"良好",@"有逾期",@"黑户"];
}
    //指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//指定每个表盘有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == _pickerView) {
            return self.persondatas.count;
    }if (pickerView == _DKLXpickerView) {
          return self.loanTypedatas.count;
    }if (pickerView == _DKEDpickerView) {
        return self.loanmoneydatas.count;
    }if (pickerView == _DKQXpickerView) {
        return self.loanlimitdatas.count;
    }else{
        return self.creditdatas.count;
    }

}
//指定每行要展示的数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == _pickerView) {
        return self.persondatas[row];
    }
     if (pickerView == _DKLXpickerView) {
        return self.loanTypedatas[row];
    }if (pickerView ==_DKEDpickerView) {
        return self.loanmoneydatas[row];
    }if (pickerView == _DKQXpickerView) {
        return self.loanlimitdatas[row];
    }else{
        return self.creditdatas[row];
    }

}


-(void)ClickPicker:(UIButton*)sender{
    if (sender.tag == 1000) {
        self.backgroundV.hidden=NO;
        self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenH - kAutoHEX(200), kScreenW, kAutoHEX(200))];
        self.pickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //指定数据源和委托
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        button0 = [sencondBGV viewWithTag:1000];
        [self.backgroundV addSubview:self.pickerView];
        NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
        [userdefault setObject:@"picker" forKey:@"PICKER"];
        [userdefault synchronize];
        
    }if (sender.tag == 1001) {
        self.backgroundV.hidden=NO;
        self.DKLXpickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenH - kAutoHEX(200), kScreenW, kAutoHEX(200))];
        self.DKLXpickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //指定数据源和委托
        self.DKLXpickerView.delegate = self;
        self.DKLXpickerView.dataSource = self;
         button1 = [sencondBGV viewWithTag:1001];
        [self.backgroundV addSubview:self.DKLXpickerView];
        NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
        [userdefault setObject:@"dklx" forKey:@"DKLX"];
        [userdefault synchronize];

    }if (sender.tag == 1002) {
        self.backgroundV.hidden=NO;
        self.DKEDpickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenH - kAutoHEX(200), kScreenW, kAutoHEX(200))];
        self.DKEDpickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //指定数据源和委托
        self.DKEDpickerView.delegate = self;
        self.DKEDpickerView.dataSource = self;
         button2 = [sencondBGV viewWithTag:1003];
        [self.backgroundV addSubview:self.DKEDpickerView];
        NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
        [userdefault setObject:@"dked" forKey:@"DKED"];
        [userdefault synchronize];
    }if (sender.tag == 1003) {
        self.backgroundV.hidden=NO;
        self.DKQXpickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenH - kAutoHEX(200), kScreenW, kAutoHEX(200))];
        self.DKQXpickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //指定数据源和委托
        self.DKQXpickerView.delegate = self;
        self.DKQXpickerView.dataSource = self;
         button3 = [sencondBGV viewWithTag:1003];
        [self.backgroundV addSubview:self.DKQXpickerView];
        NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
        [userdefault setObject:@"dkqx" forKey:@"DKQX"];
        [userdefault synchronize];
    }if (sender.tag == 1004){
        self.backgroundV.hidden=NO;
        self.WDZXpickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenH - kAutoHEX(200), kScreenW, kAutoHEX(200))];
        self.WDZXpickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //指定数据源和委托
        self.WDZXpickerView.delegate = self;
        self.WDZXpickerView.dataSource = self;
         button4 = [sencondBGV viewWithTag:1004];
        [self.backgroundV addSubview:self.WDZXpickerView];
        NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
        [userdefault setObject:@"wdzx" forKey:@"WDZX"];
        [userdefault synchronize];
    }
    
}


-(void)ClickfinishBtn:(UIButton *)sender{
      self.backgroundV.hidden = YES;
    NSUserDefaults *userdefault0=[NSUserDefaults standardUserDefaults];
    NSString *pick=[userdefault0 objectForKey:@"PICKER"];
    NSUserDefaults *userdefault1=[NSUserDefaults standardUserDefaults];
    NSString *dklx=[userdefault1 objectForKey:@"DKLX"];
    NSUserDefaults *userdefault2=[NSUserDefaults standardUserDefaults];
    NSString *dked=[userdefault2 objectForKey:@"DKED"];
    NSUserDefaults *userdefault3=[NSUserDefaults standardUserDefaults];
    NSString *dkqx=[userdefault3 objectForKey:@"DKQX"];
    NSUserDefaults *userdefault4=[NSUserDefaults standardUserDefaults];
    NSString *wdzx=[userdefault4 objectForKey:@"WDZX"];
    if (pick) {
        [userdefault0 removeObjectForKey:@"PICKER"];
        [userdefault0 synchronize];//不要忘了同步～～
        NSInteger row=[self.pickerView selectedRowInComponent:0];
        NSString *value=[self.persondatas objectAtIndex:row];
        NSString *string=[NSString stringWithFormat:@"我的身份             %@",value];
        [[sencondBGV viewWithTag:1000] setTitle:string forState:UIControlStateNormal];
       
    }if (dklx) {
        [userdefault0 removeObjectForKey:@"DKLX"];
        [userdefault0 synchronize];//不要忘了同步～～
        NSInteger row=[self.DKLXpickerView selectedRowInComponent:0];
        NSString *value=[self.loanTypedatas objectAtIndex:row];
        NSString *string=[NSString stringWithFormat:@"贷款类型             %@",value];
        [[sencondBGV viewWithTag:1001] setTitle:string forState:UIControlStateNormal];
        
    }if (dked) {
        [userdefault0 removeObjectForKey:@"DKED"];
        [userdefault0 synchronize];//不要忘了同步～～
        NSInteger row=[self.DKEDpickerView selectedRowInComponent:0];
        NSString *value=[self.loanmoneydatas objectAtIndex:row];
        NSString *string=[NSString stringWithFormat:@"贷款额度             %@",value];
        [[sencondBGV viewWithTag:1002] setTitle:string forState:UIControlStateNormal];
        
    }if (dkqx) {
        [userdefault0 removeObjectForKey:@"DKQX"];
        [userdefault0 synchronize];//不要忘了同步～～
        NSInteger row=[self.DKQXpickerView selectedRowInComponent:0];
        NSString *value=[self.loanlimitdatas objectAtIndex:row];
        NSString *string=[NSString stringWithFormat:@"贷款期限             %@",value];
        [[sencondBGV viewWithTag:1003] setTitle:string forState:UIControlStateNormal];
        
    }if (wdzx) {
        [userdefault0 removeObjectForKey:@"WDZX"];
        [userdefault0 synchronize];//不要忘了同步～～
        NSInteger row=[self.WDZXpickerView selectedRowInComponent:0];
        NSString *value=[self.creditdatas objectAtIndex:row];
        NSString *string=[NSString stringWithFormat:@"我的征信             %@",value];
        [[sencondBGV viewWithTag:1004] setTitle:string forState:UIControlStateNormal];
      
    }

}


//取消选择
-(void)ClickcancelBtn:(UIButton*)sender{
     self.backgroundV.hidden = YES;
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
      [userdefault removeObjectForKey:@"PICKER"];
      [userdefault removeObjectForKey:@"DKLX"];
      [userdefault removeObjectForKey:@"DKED"];
      [userdefault removeObjectForKey:@"DKQX"];
      [userdefault removeObjectForKey:@"WDZX"];
      [userdefault synchronize];//不要忘了同步～～
}


-(void)keyboardHide{
    if ([_textView isFirstResponder]) {
        [_textView resignFirstResponder];
    }
}

- (void)keyboardWillShow:(NSNotification *)info
{
    CGRect keyboardBounds = [[[info userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float f =  keyboardBounds.size.height;
    self.view.frame = CGRectMake(0, -f+kAutoHEX(140),self.view.frame.size.width, self.view.frame.size.height);
    
}
- (void)keyboardWillHide:(NSNotification *)info
{
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
}

//设置textView的placeholder
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //[text isEqualToString:@""] 表示输入的是退格键
    if (![text isEqualToString:@""])
    {
        textViewPlaceholderLabel.hidden = YES;
    }
    
    //range.location == 0 && range.length == 1 表示输入的是第一个字符
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        textViewPlaceholderLabel.hidden = NO;
    }
    return YES;
    
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
