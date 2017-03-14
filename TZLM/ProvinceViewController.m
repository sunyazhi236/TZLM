//
//  ProvinceViewController.m
//  TZLM
//
//  Created by  sun on 2017/3/4.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "ProvinceViewController.h"
#import "CityViewController.h"

@interface ProvinceViewController ()<UITableViewDelegate,UITableViewDataSource>{
       UITableView *_tableView;
}

@end

@implementation ProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"省份";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-20-44)style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    [CFProgressHUD showLoadingWithView:self.view];
     [self requestCitys];
}

-(void)requestCitys{
    [CFProgressHUD showLoadingWithView:self.view];

    [WMHttpTool get:kCity_List params:nil success:^(id responseObj) {
       self.provinceArr = responseObj;

        [_tableView reloadData];
        [CFProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        [CFProgressHUD hideHUDForView:self.view];
    }];
}


#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.provinceArr.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const cityIdent= @"ProvinceViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityIdent];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cityIdent];
    }
    self.provinceDict = [self.provinceArr objectAtIndex:indexPath.row];
   NSString *string=[self.provinceDict objectForKey:@"province"];
    cell.textLabel.text = string;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    [CFProgressHUD hideHUDForView:self.view];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CityViewController *cityVC=[[CityViewController alloc]init];
    
      self.provinceDict = [self.provinceArr objectAtIndex:indexPath.row];
    self.cityArr = [self.provinceDict objectForKey:@"citys"];

    cityVC.cityArray=self.cityArr;
    [self.navigationController pushViewController:cityVC animated:YES];
}
    
#pragma mark - 代理方法
#pragma mark 设置每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSArray *)provinceArr{
    if (_provinceArr == nil) {
        _provinceArr = [NSArray array];
    }
    return _provinceArr;
}

-(NSDictionary*)provinceDict{
    if (_provinceDict == nil) {
        _provinceDict = [NSDictionary dictionary];
    }
    return _provinceDict;
}


-(NSArray *)cityArr{
    if (_cityArr == nil) {
        _cityArr = [NSArray array];
    }
    return _cityArr;
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
