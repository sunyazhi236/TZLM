//
//  AllianceViewController.m
//  TZLM
//
//  Created by  sun on 2017/4/6.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "AllianceViewController.h"
#import "AllianceThreeCell.h"
#import "AllianceOneCell.h"
#import "AllianceNOCell.h"


@interface AllianceViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UILabel *lmxcLabel;
    UILabel *zldylmLabel;
    UIScrollView *_scrollView; //抵押车转让  其他债权转让 scrollView
    UITableView *_tableView;//抵押车 tableView
    UITableView *_tableView2;  //其他债权转让 tableView
}
@end

@implementation AllianceViewController
static NSString *const ThreeCell = @"AllianceThreeCell";
static NSString *const OneCell = @"AllianceOneCell";
static NSString *const NoCell = @"AllianceNOCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(206, 206, 206);
    //上部白色背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kAutoHEX(55))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    //金融公司button label
    UIButton *lmxcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lmxcBtn.frame = CGRectMake(kAutoWEX(16), kAutoHEX(7), kAutoWEX(53), kAutoHEX(33));
    [lmxcBtn setBackgroundImage:[UIImage imageNamed:@"lmxc"] forState:UIControlStateNormal];
    [lmxcBtn addTarget:self action:@selector(ClickLMXCBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:lmxcBtn];
    lmxcLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW/2, kAutoHEX(55))];
    lmxcLabel.text = @"                   联盟寻车";
    lmxcLabel.textAlignment = NSTextAlignmentCenter;
    [lmxcLabel setFont:[UIFont systemFontOfSize_5:14]];
    lmxcLabel.textColor  = [UIColor redColor];
    [bgView addSubview:lmxcLabel];
    //中间线
    UIView *LineV =[[UIView alloc]initWithFrame:CGRectMake(kScreenW/2, kAutoHEX(5), 1, kAutoHEX(45))];
    LineV.backgroundColor = RGBColor(202, 202, 202);
    [bgView addSubview:LineV];
    //金融顾问button label
    UIButton *zldylmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zldylmBtn.frame = CGRectMake(kAutoWEX(183), kAutoHEX(7), kAutoWEX(40), kAutoHEX(26));
    [zldylmBtn setBackgroundImage:[UIImage imageNamed:@"zldylm"] forState:UIControlStateNormal];
    [zldylmBtn addTarget:self action:@selector(ClickZLDTLMBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:zldylmBtn];
    zldylmLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2, 0, kScreenW/2, kAutoHEX(55))];
    zldylmLabel.text = @"                 租赁抵押联盟";
    zldylmLabel.textAlignment = NSTextAlignmentCenter;
    [zldylmLabel setFont:[UIFont systemFontOfSize_5:14]];
    zldylmLabel.textColor  = [UIColor blackColor];
    [bgView addSubview:zldylmLabel];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, bgView.frame.size.height, kScreenW, kScreenH-20-44-(bgView.frame.size.height+kAutoHEX(30)))];
    _scrollView.contentSize = CGSizeMake(kScreenW*2, 0);
    _scrollView.scrollEnabled = NO;
    [self.view addSubview:_scrollView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, _scrollView.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_scrollView addSubview:_tableView];
    
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(kScreenW, 0, kScreenW, _scrollView.frame.size.height)];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    [_scrollView addSubview:_tableView2];

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
    [_tableView2 reloadData];
    [_tableView2.mj_header endRefreshing];
    [_tableView2.mj_footer endRefreshing];
    
}
-(void)addTableRefresh2{
    // 添加头部刷新
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //        _page = 0;
        
        //        self.JDXXArray =[NSMutableArray arrayWithArray:_JDXXArray];
        //        [self.JDXXArray removeAllObjects];
        // 请求数据
        [CFProgressHUD showLoadingWithView:self.view];
        [self requestinfo];
    }];
    _tableView2.mj_header = header;
    
    // 添加尾部刷新
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        //         _page++;
        // 请求数据
        [CFProgressHUD showLoadingWithView:self.view];
        [self requestinfo];
    }];
    _tableView2.mj_footer = footer;
    
}

-(void)ClickLMXCBtn:(UIButton*)sender{
    _scrollView.contentOffset = CGPointMake(0, 0);
    lmxcLabel.textColor  = [UIColor redColor];
    zldylmLabel.textColor  = [UIColor blackColor];
    [self addTableRefresh];
    
}

-(void)ClickZLDTLMBtn:(UIButton*)sender{
    _scrollView.contentOffset = CGPointMake(kScreenW, 0);
    lmxcLabel.textColor  = [UIColor blackColor];
    zldylmLabel.textColor  = [UIColor redColor];
    [self addTableRefresh2];
    
}


#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllianceThreeCell *threeCell=[tableView dequeueReusableCellWithIdentifier:ThreeCell];
    AllianceOneCell *oneCell=[tableView dequeueReusableCellWithIdentifier:OneCell];
    AllianceNOCell *noCell = [tableView dequeueReusableCellWithIdentifier:NoCell];
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
    return kAutoHEX(136);
    
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
