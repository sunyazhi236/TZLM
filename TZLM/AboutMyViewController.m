//
//  AboutMyViewController.m
//  TZLM
//
//  Created by  sun on 2017/2/25.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "AboutMyViewController.h"

#define Start_X          40.0f      // 第一个按钮的X坐标
#define Start_Y          62.0f     // 第一个按钮的Y坐标
#define Width_Space      30.0f      // 2个按钮之间的横间距
#define Height_Space     0.0f     // 竖间距
#define Button_Height   59.0f    // 高
#define Button_Width    63.0f    // 宽

@interface AboutMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation AboutMyViewController
static NSString *const Cell = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kAutoHEX(kScreenW * 173 / 320)) ];
       bgView.backgroundColor = RGBColor(32, 136, 107);
       [self.view addSubview:bgView];
    NSArray *images = @[@"login1",@"login2",@"login3"];
    for (int i = 0 ; i < 3; i++) {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        // 圆角按钮
        UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [mapBtn setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        mapBtn.tag = i;//这句话不写等于废了
        mapBtn.frame = CGRectMake(kAutoWEX(index * (Button_Width + Width_Space) + Start_X), kAutoHEX (page  * (Button_Height + Height_Space)+Start_Y),kAutoWEX(Button_Width), kAutoWEX(Button_Height));
        
        [bgView addSubview:mapBtn];
        //按钮点击方法
      [mapBtn addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(120), kAutoHEX(140), kAutoWEX(90), kAutoHEX(20))];
    [label setFont:[UIFont systemFontOfSize_5:12]];
    [label setTextColor:[UIColor whiteColor]];
    label.text = @"登录推荐更准确";
    [bgView addSubview:label];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, bgView.frame.size.height, kScreenW, kScreenH - bgView.frame.size.height-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil) {
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        
    }
   NSArray *arrays = @[@"消息通知",@"消息通知",@"消息通知",@"消息通知",@"消息通知"];
    cell.textLabel.text = [arrays objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}


//点击按钮方法,这里容易犯错
-(void)mapBtnClick:(UIButton *)sender{
    //记住,这里不能写成"mapBtn.tag",这样你点击任何一个button,都只能获取到最后一个button的值,因为前边的按钮都被最后一个button给覆盖了
    NSLog(@"%ld",sender.tag);
    if (sender.tag == 0) {
        LoginViewController *loginVC=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    if (sender.tag == 1) {
        
    }
     if (sender.tag == 2) {
        
    }
}


-(void)viewWillAppear:(BOOL)animated{

      [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    [AppDelegate rootNavigationController].navigationBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated{
      [super viewWillDisappear:animated];
  self.navigationController.navigationBarHidden = NO;
//     [AppDelegate rootNavigationController].navigationBar.hidden=NO;
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
