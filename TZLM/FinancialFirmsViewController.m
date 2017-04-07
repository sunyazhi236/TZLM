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
#import "FinancialListHeaderView.h"


@interface FinancialFirmsViewController ()<UITableViewDelegate,UITableViewDataSource>{
        UITableView *_tableView;//金融公司 tableView
        UITableView *_tableView2;  //金融顾问 tableView
        UIScrollView *_scrollView; //金融公司 金融顾问 scrollView
        UILabel *jrgsLabel;
        UILabel *jrgwLabel;
        FinancialListHeaderView * _FinancialView;
        UIView * _maskView;//筛选背景色
        UITapGestureRecognizer * _tap; //点击选中背景后

        UIView * _typeView; //筛选贷款类型View
        UIView *_limitView;//筛选贷款额度View
        UIView *_creditView;//筛选征信要求View
        UIView *_userView;//筛选针对用户View
        NSMutableArray * _typeArray; //贷款类型数组
        NSMutableArray *_limitArray;//贷款额度数组
        NSMutableArray *_creditArray;//征信要求数组
        NSMutableArray  *_userArray;//针对用户数组
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
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, bgView.frame.size.height+kAutoHEX(40), kScreenW, kScreenH-20-44-(bgView.frame.size.height+kAutoHEX(72)))];
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
    
    [self addHeader];
    _typeArray = [NSMutableArray arrayWithObjects:@"票据贴现",@"信用贷款",@"车辆贷款",@"房产贷款",@"企业贷款",@"信用卡",@"网贷", nil];
    _limitArray = [NSMutableArray arrayWithObjects:@"1000-1万",@"1万-10万",@"10万-100万", nil];
    _creditArray = [NSMutableArray arrayWithObjects:@"严重逾期",@"少数逾期",@"征信良好", nil];
    _userArray = [NSMutableArray arrayWithObjects:@"企业",@"个人", nil];
}

-(void)addHeader{
    
    _FinancialView = [[FinancialListHeaderView alloc]initWithFrame:CGRectMake(0, kAutoHEX(57), kScreenW, kAutoHEX(40))];
    
    __block FinancialFirmsViewController * financial =  self;
    [_FinancialView setView];
    _FinancialView.typeBlock = ^(){
        
       [financial addMaskView];
       [financial addTypeListView];
    };
    _FinancialView.limitBlock = ^(){
        
       [financial addMaskView];
      [financial addLimitListView];
    };
    _FinancialView.creditBlock = ^(){
        
       [financial addMaskView];
       [financial addCreditListView];
    };
    
    _FinancialView.userBlock = ^(){
        
       [financial addMaskView];
       [financial addUserListView];
    };
    
    [self.view addSubview:_FinancialView];
}

//针对用户
-(void)addUserListView{
    
    _userView = [[UIView alloc]initWithFrame:CGRectMake(0, -200, kScreenW, _userArray.count * 40)];
    _userView.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 0; i<_userArray.count; i++) {
        
        //        nearbyHouseTypeModel * model = _houseTypeArray[i];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*40, kScreenW, 40)];
        //        NSLog(@"%@",model.typeName);
        //        [button setTitle:model.typeName forState:UIControlStateNormal];
        [button setTitle:_userArray[i] forState:UIControlStateNormal];
        button.tag = 100+i;
        [button setTitleColor:[UIColor blackColor ] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.3 alpha:0.4] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize_5:14];
        [button addTarget:self action:@selector(changeUrl:) forControlEvents:UIControlEventTouchUpInside];
        [_userView addSubview:button];
    }
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = _userView.frame;
        frame.origin.y = 0;
        _userView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    [self.view insertSubview:_userView aboveSubview:_maskView];
}

//征信要求
-(void)addCreditListView{
    _creditView = [[UIView alloc]initWithFrame:CGRectMake(0, -200, kScreenW, _creditArray.count * 40)];
    _creditView.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 0; i<_creditArray.count; i++) {
        
        //        nearbyHouseTypeModel * model = _houseTypeArray[i];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*40, kScreenW, 40)];
        //        NSLog(@"%@",model.typeName);
        //        [button setTitle:model.typeName forState:UIControlStateNormal];
        [button setTitle:_creditArray[i] forState:UIControlStateNormal];
        button.tag = 100+i;
        [button setTitleColor:[UIColor blackColor ] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.3 alpha:0.4] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize_5:14];
        [button addTarget:self action:@selector(changeUrl:) forControlEvents:UIControlEventTouchUpInside];
        [_creditView addSubview:button];
    }
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = _creditView.frame;
        frame.origin.y = 0;
        _creditView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    [self.view insertSubview:_creditView aboveSubview:_maskView];
}


//贷款额度
-(void)addLimitListView{
    _limitView = [[UIView alloc]initWithFrame:CGRectMake(0, -200, kScreenW, _limitArray.count * 40)];
    _limitView.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 0; i<_limitArray.count; i++) {
        
        //        nearbyHouseTypeModel * model = _houseTypeArray[i];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*40, kScreenW, 40)];
        //        NSLog(@"%@",model.typeName);
        //        [button setTitle:model.typeName forState:UIControlStateNormal];
        [button setTitle:_limitArray[i] forState:UIControlStateNormal];
        button.tag = 100+i;
        [button setTitleColor:[UIColor blackColor ] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.3 alpha:0.4] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize_5:14];
        [button addTarget:self action:@selector(changeUrl:) forControlEvents:UIControlEventTouchUpInside];
        [_limitView addSubview:button];
    }
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = _limitView.frame;
        frame.origin.y = 0;
        _limitView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    [self.view insertSubview:_limitView aboveSubview:_maskView];
    
}

//贷款类型
-(void)addTypeListView{
    _typeView = [[UIView alloc]initWithFrame:CGRectMake(0, -200, kScreenW, _typeArray.count * 40)];
    _typeView.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 0; i<_typeArray.count; i++) {
        
//        nearbyHouseTypeModel * model = _houseTypeArray[i];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*40, kScreenW, 40)];
//        NSLog(@"%@",model.typeName);
//        [button setTitle:model.typeName forState:UIControlStateNormal];
        [button setTitle:_typeArray[i] forState:UIControlStateNormal];
        button.tag = 100+i;
        [button setTitleColor:[UIColor blackColor ] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.3 alpha:0.4] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize_5:14];
        [button addTarget:self action:@selector(changeUrl:) forControlEvents:UIControlEventTouchUpInside];
        [_typeView addSubview:button];
    }
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = _typeView.frame;
        frame.origin.y = 0;
        _typeView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    [self.view insertSubview:_typeView aboveSubview:_maskView];
}


-(void)changeUrl:(UIButton*)sender{
     [self maskTap];
}


-(void)addMaskView{
    
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _maskView.alpha= 0.5;
    }];
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskTap)];
    [_maskView addGestureRecognizer:_tap];
    
    [self.view addSubview:_maskView];
}

//点击消除背景
-(void)maskTap{
    [UIView animateWithDuration:0.25 animations:^{

        _maskView.alpha = 0 ;
    } completion:^(BOOL finished) {
        
        [_maskView removeFromSuperview];
        _maskView = nil;
    }];if (_typeView) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect rect = _typeView.frame;
            rect.origin.y = -200;
            _typeView.frame = rect;
        } completion:^(BOOL finished) {
            
            [_typeView removeFromSuperview];
            _typeView = nil;
        }];                                                                                                                                                                                                                                                                                                      
    }if (_limitView) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect rect = _limitView.frame;
            rect.origin.y = -200;
            _limitView.frame = rect;
        } completion:^(BOOL finished) {
            
            [_limitView removeFromSuperview];
            _limitView = nil;
        }];
    }if (_creditView) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect rect = _creditView.frame;
            rect.origin.y = -200;
            _creditView.frame = rect;
        } completion:^(BOOL finished) {
            
            [_creditView removeFromSuperview];
            _creditView = nil;
        }];
    }if (_userView) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect rect = _userView.frame;
            rect.origin.y = -200;
            _userView.frame = rect;
        } completion:^(BOOL finished) {
            
            [_userView removeFromSuperview];
            _userView = nil;
        }];
    }
    
    
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
