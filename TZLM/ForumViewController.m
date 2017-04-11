//
//  ForumViewController.m
//  TZLM
//
//  Created by  sun on 2017/4/10.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "ForumViewController.h"
#import "ForumThreeCell.h"
#import "ForumOneCell.h"
#import "ForumNoCell.h"


@interface ForumViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;//tableView
  
}

@end

@implementation ForumViewController
static NSString *const ThreeCell = @"ForumThreeCell";
static NSString *const OneCell = @"ForumOneCell";
static NSString *const NoCell = @"ForumNoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-kAutoHEX(30))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self addTableRefresh];
}


-(void)addTableRefresh{
    // 添加头部刷新
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //        _page = 0;
        
        //        self.JDXXArray =[NSMutableArray arrayWithArray:_JDXXArray];
        //        [self.JDXXArray removeAllObjects];
        // 请求数据
        [CFProgressHUD showLoadingWithView:self.view];
        [self requestinfo];
    }];
    _tableView.mj_header = header;
    
    // 添加尾部刷新
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        //         _page++;
        // 请求数据
        [CFProgressHUD showLoadingWithView:self.view];
        [self requestinfo];
    }];
    _tableView.mj_footer = footer;
    
}

-(void)requestinfo{
    //    [CFProgressHUD showLoadingWithView:self.view];
    [CFProgressHUD hideHUDForView:self.view];
    
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ForumThreeCell *threeCell=[tableView dequeueReusableCellWithIdentifier:ThreeCell];
    ForumOneCell *oneCell=[tableView dequeueReusableCellWithIdentifier:OneCell];
    ForumNoCell *noCell = [tableView dequeueReusableCellWithIdentifier:NoCell];
        if (indexPath.section == 0) {
            if (threeCell == nil) {
                threeCell=[[[NSBundle mainBundle]loadNibNamed:ThreeCell owner:self options:nil]lastObject];
                
            }
            return threeCell;
        }
        if (indexPath.section == 1) {
            if (oneCell == nil) {
                oneCell=[[[NSBundle mainBundle]loadNibNamed:OneCell owner:self options:nil]lastObject];
                
            }
            return oneCell;
        }
        if (indexPath.section == 2) {
            if (noCell == nil) {
                noCell=[[[NSBundle mainBundle]loadNibNamed:NoCell owner:self options:nil]lastObject];
                
            }
            return noCell;
        }

    return threeCell;
}



#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return 3;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return kAutoHEX(160);

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
