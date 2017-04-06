//
//  FinancialFirmsViewController.m
//  TZLM
//
//  Created by  sun on 2017/3/31.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "FinancialFirmsViewController.h"
#import "TZBondTransferCell.h"
#import "TZFinancialAdvisorCell.h"

@interface FinancialFirmsViewController ()<UITableViewDelegate,UITableViewDataSource>{
        UITableView *_tableView;//金融公司 tableView
        UITableView *_tableView2;  //金融顾问 tableView
        UIScrollView *_scrollView; //金融公司 金融顾问 scrollView
        UILabel *jrgsLabel;
        UILabel *jrgwLabel;
}

@end

@implementation FinancialFirmsViewController
static NSString *const JRGSCell = @"TZBondTransferCell";
static NSString *const JRGWCell = @"TZFinancialAdvisorCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(206, 206, 206);
    //上部白色背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kAutoHEX(55))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    //金融公司button label
    UIButton *jrgsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jrgsBtn.frame = CGRectMake(kAutoWEX(16), kAutoHEX(7), kAutoWEX(42), kAutoHEX(42));
    [jrgsBtn setBackgroundImage:[UIImage imageNamed:@"jrgs_01"] forState:UIControlStateNormal];
    [jrgsBtn addTarget:self action:@selector(ClickJRGSBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:jrgsBtn];
    jrgsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW/2, kAutoHEX(55))];
    jrgsLabel.text = @"         金融公司";
    jrgsLabel.textAlignment = NSTextAlignmentCenter;
    [jrgsLabel setFont:[UIFont systemFontOfSize_5:16]];
    jrgsLabel.textColor  = [UIColor redColor];
    [bgView addSubview:jrgsLabel];
    //中间线
    UIView *LineV =[[UIView alloc]initWithFrame:CGRectMake(kScreenW/2, kAutoHEX(5), 1, kAutoHEX(45))];
    LineV.backgroundColor = RGBColor(202, 202, 202);
    [bgView addSubview:LineV];
    //金融顾问button label
    UIButton *jrgwBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jrgwBtn.frame = CGRectMake(kAutoWEX(194), kAutoHEX(7), kAutoWEX(42), kAutoHEX(42));
    [jrgwBtn setBackgroundImage:[UIImage imageNamed:@"jrgs_02"] forState:UIControlStateNormal];
    [jrgwBtn addTarget:self action:@selector(ClickJRGWBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:jrgwBtn];
    jrgwLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2, 0, kScreenW/2, kAutoHEX(55))];
    jrgwLabel.text = @"                   金融顾问";
    jrgwLabel.textAlignment = NSTextAlignmentCenter;
    [jrgwLabel setFont:[UIFont systemFontOfSize_5:16]];
    jrgwLabel.textColor  = [UIColor blackColor];
    [bgView addSubview:jrgwLabel];
    
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

-(void)ClickJRGSBtn:(UIButton*)sender{
    _scrollView.contentOffset = CGPointMake(0, 0);
    jrgsLabel.textColor  = [UIColor redColor];
    jrgwLabel.textColor  = [UIColor blackColor];
    [self addTableRefresh];
}


-(void)ClickJRGWBtn:(UIButton*)sender{
    
    _scrollView.contentOffset = CGPointMake(kScreenW, 0);
    jrgsLabel.textColor  = [UIColor blackColor];
    jrgwLabel.textColor  = [UIColor redColor];
    [self addTableRefresh2];
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

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     TZBondTransferCell *cell=[tableView dequeueReusableCellWithIdentifier:JRGSCell];
     TZFinancialAdvisorCell *Advisorcell=[tableView dequeueReusableCellWithIdentifier:JRGWCell];
    if ([tableView isEqual:_tableView]) {
        if (cell == nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:JRGSCell owner:self options:nil]lastObject];
            
        }
        return cell;
    }if ([tableView isEqual:_tableView2]) {
        if (Advisorcell == nil) {
            Advisorcell=[[[NSBundle mainBundle]loadNibNamed:JRGWCell owner:self options:nil]lastObject];
        }
        return Advisorcell;
    }

    
    return cell;
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
    return kAutoHEX(100);
    
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
