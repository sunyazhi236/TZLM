//
//  DeadbeatViewController.m
//  TZLM
//
//  Created by  sun on 2017/4/10.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "DeadbeatViewController.h"
#import "QueryNoCell.h"
#import "QueryOneCell.h"
#import "QueryThreeCell.h"
#import "FinancialListHeaderView.h"

@interface DeadbeatViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITextField *_textName;
    UITextField *_textNumber;
    UIButton *_provinceBtn;
    UIButton *_queryBtn;
    UITableView *_tableView;// tableView
    FinancialListHeaderView * _FinancialView;
    UIView * _maskView;//筛选背景色
    UITapGestureRecognizer * _tap; //点击选中背景后
    UITableView * _provinceView; //筛选贷款类型View
     NSMutableArray * _provinceArray; //贷款类型数组
}

@end

@implementation DeadbeatViewController
static NSString *const ThreeCell = @"QueryThreeCell";
static NSString *const OneCell = @"QueryOneCell";
static NSString *const NoCell = @"QueryNoCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self headerView];
     _provinceArray = [NSMutableArray arrayWithObjects:@"全国",@"北京",@"天津",@"河北",@"山西",@"内蒙古",@"吉林",@"黑龙江",@"上海",@"江苏",@"浙江",@"安徽",@"福建",@"江西",@"山东",@"河南",@"湖北",@"湖南",@"广东",@"广西",@"海南",@"重庆",@"四川",@"贵州",@"云南",@"陕西",@"甘肃",@"青海",@"宁夏",@"新疆",@"香港",@"澳门",@"台湾", nil];
}



//头部位置
-(void)headerView{
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(28), kAutoHEX(7), kAutoWEX(150), kAutoHEX(20))];
    label1.text = @"被执行人姓名/名称:";
    label1.font  = [UIFont systemFontOfSize_5:15];
    [self.view addSubview:label1];
    _textName = [[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(28), kAutoHEX(27), kAutoWEX(253), kAutoHEX(25))];
    _textName.backgroundColor = RGBColor(215, 215, 215);
    [self.view addSubview:_textName];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(28), kAutoHEX(55), kAutoWEX(200), kAutoHEX(20))];
    label2.text = @"身份证号码/组织机构代码:";
    label2.font  = [UIFont systemFontOfSize_5:15];
    [self.view addSubview:label2];
    _textNumber = [[UITextField alloc]initWithFrame:CGRectMake(kAutoWEX(28), kAutoHEX(78), kAutoWEX(253), kAutoHEX(25))];
    _textNumber.backgroundColor = RGBColor(215, 215, 215);
    [self.view addSubview:_textNumber];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(kAutoWEX(28), kAutoHEX(105), kAutoWEX(200), kAutoHEX(20))];
    label3.text = @"被执行人省份:";
    label3.font  = [UIFont systemFontOfSize_5:15];
    [self.view addSubview:label3];
//    _provinceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _provinceBtn.frame = CGRectMake(kAutoWEX(28), kAutoHEX(128), kAutoWEX(253), kAutoHEX(25));
//    _provinceBtn.backgroundColor = RGBColor(215, 215, 215);
//    [_provinceBtn setTitle:@"    全国" forState:UIControlStateNormal];
//    [_provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_provinceBtn.titleLabel setFont:[UIFont systemFontOfSize_5:14]];
//     _provinceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [self.view addSubview:_provinceBtn];
//    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(kAutoWEX(225), kAutoHEX(3), kAutoWEX(18), kAutoHEX(18))];
//    imgV.image = [UIImage imageNamed:@"查询老赖2"];
//    [_provinceBtn addSubview:imgV];
    
    _queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _queryBtn.frame = CGRectMake(kAutoWEX(103), kAutoHEX(163), kAutoWEX(104), kAutoHEX(22));
    [_queryBtn setBackgroundImage:[UIImage imageNamed:@"查询老赖"] forState:UIControlStateNormal];
    [_queryBtn addTarget:self action:@selector(ClickQuertBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_queryBtn];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kAutoHEX(190), kScreenW, kAutoHEX(280))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self addTableRefresh];
    [self addHeader];
}

-(void)addHeader{
    
    _FinancialView = [[FinancialListHeaderView alloc]initWithFrame:CGRectMake(kAutoWEX(28), kAutoHEX(128), kAutoWEX(253), kAutoHEX(25))];
    
    __block DeadbeatViewController * financial =  self;
    [_FinancialView setProvinceView];
    _FinancialView.provinceBlock = ^(){
        
        [financial addMaskView];
        [financial addTypeListView];
    };

    [self.view addSubview:_FinancialView];
}
//贷款类型
-(void)addTypeListView{
    _provinceView = [[UITableView alloc]initWithFrame:CGRectMake(0, -200, kScreenW, kScreenH-64-kAutoHEX(30))style:UITableViewStylePlain];
    _provinceView.backgroundColor = [UIColor whiteColor];
    _provinceView.delegate = self;
    _provinceView.dataSource = self;
    _provinceView.tableFooterView = [[UIView alloc]init];
    _provinceView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = _provinceView.frame;
        frame.origin.y = 0;
        _provinceView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    [self.view insertSubview:_provinceView aboveSubview:_maskView];
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
    }];if (_provinceView) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect rect = _provinceView.frame;
            rect.origin.y = 0;
            _provinceView.frame = rect;
        } completion:^(BOOL finished) {
            
            [_provinceView removeFromSuperview];
            _provinceView = nil;
        }];
    }
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

-(void)ClickQuertBtn:(UIButton*)sender{

    
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QueryThreeCell *threeCell=[tableView dequeueReusableCellWithIdentifier:ThreeCell];
    QueryOneCell *oneCell=[tableView dequeueReusableCellWithIdentifier:OneCell];
    QueryNoCell *noCell = [tableView dequeueReusableCellWithIdentifier:NoCell];
    if (tableView == _provinceView) {
//        PersonalAreaListModel * model = _areaListArray[indexPath.row];
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"areaCell"];
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"areaCell"];
        }
        cell.textLabel.text = [_provinceArray objectAtIndex:indexPath.section];
        
        return cell;
    }
        if (tableView == _tableView) {
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
        }

    return threeCell;
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    if ([tableView isEqual:_provinceView]) {
        return _provinceArray.count;
    }else{
    return 3;
    }
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
    if ([tableView isEqual:_provinceView]) {
        return kAutoHEX(40);
    }else{
    return kAutoHEX(150);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       [self maskTap];
    
}



-(void)keyboardHide{
    if ([_textName isFirstResponder]) {
        //取消第一响应者。收回键盘
        [_textName resignFirstResponder];
    }
    else  {
        //取消第一响应者。收回键盘
        [_textNumber resignFirstResponder];
    }
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
