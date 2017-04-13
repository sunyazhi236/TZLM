//
//  CounselorDetailViewController.m
//  TZLM
//
//  Created by  sun on 2017/4/12.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "CounselorDetailViewController.h"
#import "FinancialDetailHeaderCell.h"
#import "FinancialDetailContentCell.h"
#import "FinancialDetailUserCommentCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

@interface CounselorDetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIButton *_shareBtn;
    UITableView *_tableView;
}
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UITextField *commentTextField;
@property (nonatomic,strong)UIButton *commentButton;

@end

@implementation CounselorDetailViewController
static NSString *const FDHCell = @"FinancialDetailHeaderCell";
static NSString *const FDCCell = @"FinancialDetailContentCell";
static NSString *const FDUCCell = @"FinancialDetailUserCommentCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"卡圣金融";
    [self setupButtomView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:@"UIKeyboardWillHideNotification" object:nil];
    _shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.frame=CGRectMake((kScreenW-45), (20), (29), (6));
    [_shareBtn setBackgroundImage:[UIImage imageNamed:@"。。。"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(didClickShareSDK:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_shareBtn];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-kAutoHEX(35))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
-(void)didClickShareSDK:(UIButton*)sender{
    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"headerPH"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    
}

-(void)keyboardHide{
    if ([self.commentTextField isFirstResponder]) {
        [self.commentTextField resignFirstResponder];
    }
}


//键盘即将出现的时候
- (void)keyboardWillShow:(NSNotification *)sender{
    CGRect keyboardRect = [(sender.userInfo[UIKeyboardFrameBeginUserInfoKey]) CGRectValue];
    //改变bttomView的y值，防止被键盘遮住
    CGRect bottomViewRect = self.bottomView.frame;
    bottomViewRect.origin.y = self.view.frame.size.height - keyboardRect.size.height - bottomViewRect.size.height;
    self.bottomView.frame = bottomViewRect;
    [self.view bringSubviewToFront:self.bottomView];
    NSLog(@"++++%@",NSStringFromCGRect(keyboardRect));
    
}

//键盘即将消失的时候
- (void)keyboardWillHidden:(NSNotification *)sender{
    
    CGRect bottomViewRect = self.bottomView.frame;
    bottomViewRect.origin.y = kScreenH-64-kAutoHEX(35);
    self.bottomView.frame = bottomViewRect;
}

//键盘的布局
- (void)setupButtomView{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-64-kAutoHEX(35), kScreenW, kAutoHEX(35))];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bottomView];
    //添加textfield
    self.commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(kAutoWEX(30), kAutoHEX(5), kAutoWEX(230), kAutoHEX(25))];
    self.commentTextField.backgroundColor = RGBColor(215, 215, 215);
    self.commentTextField.placeholder = @"写评论...";
    self.commentTextField.layer.cornerRadius = 10;
    self.commentTextField.keyboardType = UIKeyboardTypeDefault;
    self.commentTextField.returnKeyType = UIReturnKeySend;
    [self.bottomView addSubview:self.commentTextField];
    //textField遵循协议
    self.commentTextField.delegate = self;
    //添加button
    self.commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.commentButton.frame = CGRectMake(kScreenW - kAutoWEX(45), kAutoHEX(5), kAutoWEX(25), kAutoHEX(25));
    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"chatRecord"] forState:UIControlStateNormal];
    [self.commentButton addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.commentButton];
}


#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FinancialDetailHeaderCell *fdhCell = [tableView dequeueReusableCellWithIdentifier:FDHCell];
    FinancialDetailContentCell *fdcCell=[tableView dequeueReusableCellWithIdentifier:FDCCell];
    FinancialDetailUserCommentCell *fducCell=[tableView dequeueReusableCellWithIdentifier:FDUCCell];
    if (indexPath.section == 0) {
        if (fdhCell == nil) {
            fdhCell=[[[NSBundle mainBundle]loadNibNamed:FDHCell owner:self options:nil]lastObject];
            
        }
       fdhCell.companyName.text = @"";
        fdhCell.userName.text = @"顾问名称：韩经理";
        fdhCell.phone.text = @"联系电话：13739797590";
        fdhCell.website.text = @"所在公司：天津盛海宇溢投资有限公司";
        fdhCell.intro.text = @"业务简介：2016火爆的互联网+金融营销！！！";
        return fdhCell;
    }  if (indexPath.section == 1) {
        if (fdcCell == nil) {
            fdcCell=[[[NSBundle mainBundle]loadNibNamed:FDCCell owner:self options:nil]lastObject];
            
        }
        return fdcCell;
    } else{
        if (fducCell == nil) {
            fducCell=[[[NSBundle mainBundle]loadNibNamed:FDUCCell owner:self options:nil]lastObject];
            
        }
        return fducCell;
    }
    
    return fdhCell;
}



#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return 4;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 3;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0||indexPath.section==1) {
        return kAutoHEX(190);
    }else{
        return 80;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//发送按钮的回调方法
- (void)commentButtonAction:(UIButton *)sender{
    //取消第一响应者
    [self.commentTextField resignFirstResponder];
}

//文本框内容发生变化
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //当文本框只有一个字符的时候，我们需要判定该字符是添加的还是需要删除的。如果是添加，需要打开用户交互，如果是删除，需要关闭用户交互
    if (string.length){//添加字符串，打开用户交互
        self.commentButton.userInteractionEnabled = YES;
    }
    else{
        if (textField.text.length <= 1) {
            self.commentButton.userInteractionEnabled = NO;
        }
    }
    return YES;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"点击了搜索");
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _shareBtn.hidden=YES;
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
