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
#import "XRCollectionViewCell.h"
#import "XRWaterfallLayout.h"
#import "XRImage.h"

@interface RecommendViewController ()<UICollectionViewDataSource, XRWaterfallLayoutDelegate,UITableViewDelegate,UITableViewDataSource>{
        UITableView *_tableView;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<XRImage *> *images;

@end

@implementation RecommendViewController
static NSString *const JDXXCell = @"TZBorrowInfoCell";
static NSString *const ZQZRCell = @"TZBondTransferCell";
static NSString *const JRGSCell = @"XRCollectionViewCell";
static NSString *const VIPCell = @"VIPCell";
- (NSMutableArray *)images {
    //从plist文件中取出字典数组，并封装成对象模型，存入模型数组中
    if (!_images) {
        _images = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
        NSArray *imageDics = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *imageDic in imageDics) {
            XRImage *image = [XRImage imageWithImageDic:imageDic];
            [_images addObject:image];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-20-44-49-40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [CFProgressHUD showLoadingWithView:self.view];
    [self requestBorrow];
    
   self.title = @"借贷信息";
}

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
//    XRImage *image = self.images[indexPath.item];
    return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.JRGSArray .count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    XRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    self.singleJRGSDict=[NSMutableDictionary dictionaryWithDictionary:[_JRGSArray objectAtIndex:indexPath.item]];
    NSArray *arr=[NSArray arrayWithArray:[self.singleJRGSDict objectForKey:@"cover_id"]];
    NSDictionary *dict=[NSDictionary  dictionaryWithDictionary:[arr objectAtIndex:0]];
    NSString *str=[NSString stringWithFormat:@"%@%@",TZ_MAIN,[dict objectForKey:@"path_small"]];
    NSURL *url = [NSURL URLWithString:str];
    cell.imageURL = url;

    return cell;
}


#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return self.InfoListArray.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return _JDXXArray.count;
    }else if (section==1){
        return _ZQZRArray.count;
    }else if (section==2){
        return 1;
    }else if (section==4){
        return _VIPArray.count;
    }
    return 0;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZBorrowInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:JDXXCell];
    TZBondTransferCell *cell2 =[tableView dequeueReusableCellWithIdentifier:ZQZRCell];
    UITableViewCell *cell3=[tableView dequeueReusableCellWithIdentifier:JRGSCell];
    UITableViewCell *cell5=[tableView dequeueReusableCellWithIdentifier:VIPCell];
    if (indexPath.section==0) {
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:JDXXCell owner:self options:nil]lastObject];
  
        }
        self.singleJDXXDict=[NSMutableDictionary dictionaryWithDictionary:[_JDXXArray objectAtIndex:indexPath.row]];
        TZBorrowInfoModel *model=[TZBorrowInfoModel objectWithKeyValues:_singleJDXXDict];
        cell.borrowModel=model;
        [CFProgressHUD hideHUDForView:self.view];
        return cell;
    }if (indexPath.section==1) {
        if (cell2==nil) {
            cell2=[[[NSBundle mainBundle]loadNibNamed:ZQZRCell owner:self options:nil]lastObject];

        }
        self.singleZQZRDict=[NSMutableDictionary dictionaryWithDictionary:[_ZQZRArray objectAtIndex:indexPath.row]];
        TZBondTransferModel *model=[TZBondTransferModel objectWithKeyValues:_singleZQZRDict];
        cell2.bondTransModel=model;
        [CFProgressHUD hideHUDForView:self.view];
        return cell2;
    }if (indexPath.section==2) {
        if (cell3==nil) {
        cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JRGSCell];
        }

        [cell3.contentView addSubview:self.collectionView];
        return cell3;
    }if (indexPath.section==4) {
        if (cell5 == nil) {
            cell5 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VIPCell];
        }
        self.singleVIPDict = [NSMutableDictionary dictionaryWithDictionary:[_VIPArray objectAtIndex:indexPath.row]];
        NSString *string=[NSString stringWithFormat:@"%@",[self.singleVIPDict objectForKey:@"title"]];
        cell5.textLabel.text = string;
        return cell5;
        }

    
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"借贷信息";
    }else if (section==1){
        return @"债券转让";
    }else if (section==2){
        return @"金融公司";
    }else if (section==3){
        return @"悬赏启示";
    }else if (section==4){
        return @"vip专区";
    }else if(section==5){
        return @"失信曝光";
    }else{
        return @"未知";
    }
}

#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;
    }else if (indexPath.section==1){
        return 100;
    }else if (indexPath.section==2){
        return _collectionView.frame.size.height;
    }else if (indexPath.section==4){
        return 40;
    }
    return 0;
}



-(void)requestBorrow{
    
    [CFProgressHUD showLoadingWithView:self.view];
    NSDictionary *dic=@{@"cc_area":@"邢台"};
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:dic];
    [WMHttpTool get:kCity_Index params:dict success:^(id responseObj) {
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
        
        //创建瀑布流布局
        XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
        //或者一次性设置
        [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        //设置代理，实现代理方法
        waterfall.delegate = self;
        //创建collectionView
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, (self.JRGSArray.count/2*100)+((self.JRGSArray.count/2)+2)*10) collectionViewLayout:waterfall];
        self.collectionView.backgroundColor = [UIColor redColor];
        [self.collectionView registerNib:[UINib nibWithNibName:@"XRCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        self.collectionView.dataSource = self;
        
        [CFProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        [CFProgressHUD hideHUDForView:self.view];
    }];
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
