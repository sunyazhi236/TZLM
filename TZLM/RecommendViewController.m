//
//  RecommendViewController.m
//  TZLM
//
//  Created by  sun on 2017/3/6.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "RecommendViewController.h"
#import "TZBorrowInfoCell.h"
#import "TZBorrowInfoModel.h"
#import "TZBondTransferCell.h"
#import "TZBondTransferModel.h"
#import "RapidRegistrationViewController.h"

#define Start_X          0.0f      // 第一个按钮的X坐标
#define Start_Y          0.0f     // 第一个按钮的Y坐标
#define Width_Space      0.0f      // 2个按钮之间的横间距
#define Height_Space     0.0f     // 竖间距
#define Button_Height   28.0f    // 高
#define Button_Width    106.0f    // 宽

@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;//全部信息 tableView
    UITableView *_FKtableView;//放款信息 tableView
    UITableView *_JKtableView;//借款信息 tableView
}
@property(nonatomic,strong)UIButton *fBtn;
@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation RecommendViewController
static NSString *const JDXXCell = @"TZBorrowInfoCell";


-(void)ClickJSDK:(UIButton*)sender{
    RapidRegistrationViewController *rapidVC=[[RapidRegistrationViewController alloc]init];
    AppDelegate *app =(AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.viewController.navigationController pushViewController:rapidVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(235, 230, 229);
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kAutoHEX(60))];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIButton *jisuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jisuBtn.frame = CGRectMake(kAutoWEX(116), kAutoHEX(20), kAutoWEX(91), kAutoHEX(23));
    [jisuBtn setBackgroundImage:[UIImage imageNamed:@"jisujiedai"] forState:UIControlStateNormal];
    [jisuBtn addTarget:self action:@selector(ClickJSDK:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:jisuBtn];
    //button的背景
    UIView *BtnBgView=[[UIView alloc]initWithFrame:CGRectMake(0, kAutoHEX(61), kScreenW, kAutoHEX(28))];
    BtnBgView.backgroundColor= [UIColor whiteColor];
    NSArray *array = @[@"全部信息",@"放款信息",@"借款信息"];
    for (int i = 0 ; i < 3; i++) {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        // 圆角按钮
       UIButton *Btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [Btn setTitle:array[i] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Btn.titleLabel setFont:[UIFont systemFontOfSize_5:16]];
        Btn.tag = i;//这句话不写等于废了
        Btn.frame = CGRectMake(kAutoWEX(index * (Button_Width + Width_Space) + Start_X), kAutoHEX (page  * (Button_Height + Height_Space)+Start_Y),kAutoWEX(Button_Width), kAutoWEX(Button_Height));
        
        [BtnBgView addSubview:Btn];
        [self.view addSubview:BtnBgView];
        
        if (Btn.tag == 0) {
            [Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            //定义第一个按钮sender是已经被选中
            _fBtn = Btn;
        }
        else{
            [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        //按钮点击方法
        [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kAutoHEX(90), kScreenW, kScreenH-20-44-kAutoHEX(30)-kAutoHEX(80))];
    self.scrollView.contentSize = CGSizeMake(kScreenW*3, 0);
    _scrollView.scrollEnabled = NO;
    [self.view addSubview:_scrollView];
    //全部信息
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, _scrollView.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_scrollView addSubview:_tableView];
    //放款信息
    _FKtableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenW, 0, kScreenW, _scrollView.frame.size.height)];
    _FKtableView.delegate = self;
    _FKtableView.dataSource = self;
    [_scrollView addSubview:_FKtableView];
    //借款信息
    _JKtableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenW*2, 0, kScreenW, _scrollView.frame.size.height)];
    _JKtableView.delegate = self;
    _JKtableView.dataSource = self;
    [_scrollView addSubview:_JKtableView];
    
    [CFProgressHUD showLoadingWithView:self.view];
    [self requestBorrow];
    [self addTableRefresh];
}

-(void)addTableRefresh{
    // 添加头部刷新
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
//        _page = 0;
        
        self.JDXXArray =[NSMutableArray arrayWithArray:_JDXXArray];
        [self.JDXXArray removeAllObjects];
        // 请求数据
        [CFProgressHUD showLoadingWithView:self.view];
        [self requestBorrow];
    }];
    _tableView.mj_header = header;
    
    // 添加尾部刷新
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
                                           
//         _page++;
        // 请求数据
         [CFProgressHUD showLoadingWithView:self.view];
         [self requestBorrow];
    }];
    _tableView.mj_footer = footer;

}

-(void)addFKTableRefresh{
    // 添加头部刷新
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //        _page = 0;
        
        // 请求数据
        [CFProgressHUD showLoadingWithView:self.view];
        [self requestBorrow];
    }];
    _FKtableView.mj_header = header;
    
    // 添加尾部刷新
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        //         _page++;
        // 请求数据
        [CFProgressHUD showLoadingWithView:self.view];
        [self requestBorrow];
    }];
    _FKtableView.mj_footer = footer;
}

-(void)addJKTableRefresh{
    // 添加头部刷新
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //        _page = 0;

        //        [self.JDXXArray removeAllObjects];
        // 请求数据
        [CFProgressHUD showLoadingWithView:self.view];
        [self requestBorrow];
    }];
    _JKtableView.mj_header = header;
    
    // 添加尾部刷新
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        //         _page++;
        // 请求数据
        [CFProgressHUD showLoadingWithView:self.view];
        [self requestBorrow];
    }];
    _JKtableView.mj_footer = footer;
    
}

-(void)requestBorrow{
    [CFProgressHUD showLoadingWithView:self.view];
    NSDictionary *dic=@{@"cc_area":@"邢台"};
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:dic];
    [WMHttpTool get:kCity_Index params:dict success:^(id responseObj) {
        [CFProgressHUD hideHUDForView:self.view];
        self.InfoListArray = responseObj;
        self.JDXXDict = [self.InfoListArray objectAtIndex:0];//借贷信息
        self.JDXXArray = [self.JDXXDict objectForKey:@"jdxx"];
        
        self.ZQZRDict = [self.InfoListArray objectAtIndex:1];//债券转让
        self.ZQZRArray = [self.ZQZRDict objectForKey:@"zqzr"];
        
        self.JRGSDict = [self.InfoListArray objectAtIndex:2];//金融公司
        self.JRGSArray = [self.JRGSDict objectForKey:@"jrgs"];
        
        self.VIPDict = [self.InfoListArray objectAtIndex:4];//VIP专区
        self.VIPArray = [self.VIPDict objectForKey:@"vip"];
        
        [_tableView reloadData];
        [_FKtableView reloadData];
        [_JKtableView reloadData];
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [_FKtableView.mj_header endRefreshing];
        [_FKtableView.mj_footer endRefreshing];
        [_JKtableView.mj_header endRefreshing];
        [_JKtableView.mj_footer endRefreshing];
        

    } failure:^(NSError *error) {
        [CFProgressHUD hideHUDForView:self.view];
    }];
}

//点击按钮方法,这里容易犯错
-(void)BtnClick:(UIButton *)sender{
    //记住,这里不能写成"mapBtn.tag",这样你点击任何一个button,都只能获取到最后一个button的值,因为前边的按钮都被最后一个button给覆盖了
    NSLog(@"%ld",sender.tag);

    if (sender.tag == 0) {
    self.scrollView.contentOffset = CGPointMake(0, 0);
        [self addTableRefresh];
    }
    if (sender.tag == 1) {
    self.scrollView.contentOffset = CGPointMake(kScreenW, 0);
        [self addFKTableRefresh];
    }
    if (sender.tag == 2) {
    self.scrollView.contentOffset = CGPointMake(kScreenW*2, 0);
        [self addJKTableRefresh];
    }
    if(_fBtn == sender) {
            //不做处理

    }else{
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_fBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _fBtn = sender;
    }
}


#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return _JDXXArray.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return 1;
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kAutoHEX(8);
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 8)];
    view.backgroundColor = RGBColor(235, 230, 229);
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZBorrowInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:JDXXCell];
    
    UIView *view = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenW, 10)];
    view.backgroundColor = [UIColor colorWithRed:74.0/255 green:56.0/255 blue:58.0/255 alpha:1.0];
    [cell.contentView addSubview:view];
    
    if ([tableView isEqual:_tableView]) {
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:JDXXCell owner:self options:nil]lastObject];
  
        }
        self.singleJDXXDict=[NSMutableDictionary dictionaryWithDictionary:[_JDXXArray objectAtIndex:indexPath.section]];
        TZBorrowInfoModel *model=[TZBorrowInfoModel objectWithKeyValues:_singleJDXXDict];
        cell.borrowModel=model;
        [CFProgressHUD hideHUDForView:self.view];
        return cell;
    }if ([tableView isEqual:_FKtableView]) {
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:JDXXCell owner:self options:nil]lastObject];
            
        }
        self.singleJDXXDict=[NSMutableDictionary dictionaryWithDictionary:[_JDXXArray objectAtIndex:indexPath.section]];
        TZBorrowInfoModel *model=[TZBorrowInfoModel objectWithKeyValues:_singleJDXXDict];
        cell.borrowModel=model;
        [CFProgressHUD hideHUDForView:self.view];
        return cell;
    }if ([tableView isEqual:_JKtableView]) {
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:JDXXCell owner:self options:nil]lastObject];
            
        }
        self.singleJDXXDict=[NSMutableDictionary dictionaryWithDictionary:[_JDXXArray objectAtIndex:indexPath.section]];
        TZBorrowInfoModel *model=[TZBorrowInfoModel objectWithKeyValues:_singleJDXXDict];
        cell.borrowModel=model;
        [CFProgressHUD hideHUDForView:self.view];
        return cell;
    }
    
    return cell;
}


#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kAutoHEX(80);

}




-(NSMutableArray *)InfoListArray{
    
    if (_InfoListArray == nil) {
        _InfoListArray = [NSMutableArray array];
    }
    return _InfoListArray;
}
-(NSMutableDictionary *)JDXXDict{
    if (_JDXXDict == nil) {
        _JDXXDict = [NSMutableDictionary dictionary];
    }
    return _JDXXDict;
}
-(NSMutableArray *)JDXXArray{
    if (_JDXXArray == nil) {
        _JDXXArray = [NSMutableArray array];
    }
    return _JDXXArray;
}

-(NSMutableDictionary*)singleJDXXDict{
    if (_singleJDXXDict == nil) {
        _singleJDXXDict = [NSMutableDictionary dictionary];
    }
    return _singleJDXXDict;
}

-(NSMutableDictionary *)ZQZRDict{
    if (_ZQZRDict == nil) {
        _ZQZRDict = [NSMutableDictionary dictionary];
    }
    return _ZQZRDict;
}

-(NSMutableArray *)ZQZRArray{
    if (_ZQZRArray == nil) {
        _ZQZRArray = [NSMutableArray array];
    }
    return _ZQZRArray;
}

-(NSMutableDictionary *)singleZQZRDict{
    if (_singleZQZRDict == nil) {
        _singleZQZRDict = [NSMutableDictionary dictionary];
    }
    return _singleZQZRDict;
}

-(NSMutableDictionary *)JRGSDict{
    if (_JRGSDict == nil) {
        _JRGSDict = [NSMutableDictionary dictionary];
    }
    return _JRGSDict;
}

-(NSMutableArray *)JRGSArray{
    if (_JRGSArray == nil) {
        _JRGSArray = [NSMutableArray array];
    }
    return _JRGSArray;
}

-(NSMutableDictionary *)singleJRGSDict{
    if (_singleJRGSDict == nil) {
        _singleJRGSDict = [NSMutableDictionary dictionary];
    }
    return _singleJRGSDict;
}

-(NSMutableDictionary *)VIPDict{
    if (_VIPDict == nil) {
        _VIPDict = [NSMutableDictionary dictionary];
    }
    return _VIPDict;
}

-(NSMutableArray *)VIPArray{
    if (_VIPArray == nil) {
        _VIPArray = [NSMutableArray array];
    }
    return _VIPArray;
}

-(NSMutableDictionary *)singleVIPDict{
    if (_singleVIPDict == nil) {
        _singleVIPDict = [NSMutableDictionary dictionary];
    }
    return _singleVIPDict;
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
