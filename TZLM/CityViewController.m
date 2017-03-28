//
//  CityViewController.m
//  TZLM
//
//  Created by  sun on 2017/3/4.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
}


@end

@implementation CityViewController
static CityViewController *_instance = nil;
+(CityViewController *)shareInstance{
        static dispatch_once_t onceToken ;
        dispatch_once(&onceToken, ^{
            _instance = [[super allocWithZone:NULL] init] ;
        }) ;
        return _instance ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"城市";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-20-44)style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cityArray.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const cityIdent= @"CityViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityIdent];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cityIdent];
    }
    cell.textLabel.text = [[_cityArray objectAtIndex:indexPath.row]objectForKey:@"cityname"];
    [CFProgressHUD hideHUDForView:self.view];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   [CityViewController shareInstance].cityStr = [[_cityArray objectAtIndex:indexPath.row]objectForKey:@"cityname"];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HomePageViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}


#pragma mark - 代理方法
#pragma mark 设置每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSString *)cityStr{
    if (_cityStr == nil) {
        _cityStr = [NSString string];
    }
    return _cityStr;
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
