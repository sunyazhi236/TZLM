//
//  RecommendViewController.h
//  TZLM
//
//  Created by  sun on 2017/3/6.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "TZRootViewController.h"

@interface RecommendViewController : TZRootViewController
@property(nonatomic,strong) NSMutableArray *InfoListArray;//（所有）最外层数组
@property(nonatomic,strong) NSMutableDictionary *JDXXDict;// 借贷信息（单项栏目）最外层字典
@property(nonatomic,strong) NSMutableArray *JDXXArray; // 借贷信息（单项栏目）外层数组
@property(nonatomic,strong) NSMutableDictionary *singleJDXXDict;//单项数据字典

@property(nonatomic,strong) NSMutableDictionary *ZQZRDict;// 证券转让（单项栏目）最外层字典
@property(nonatomic,strong) NSMutableArray *ZQZRArray; // 证券转让（单项栏目）外层数组
@property(nonatomic,strong) NSMutableDictionary *singleZQZRDict;//单项数据字典

@property(nonatomic,strong) NSMutableDictionary *JRGSDict;
@property(nonatomic,strong) NSMutableArray *JRGSArray;
@property(nonatomic,strong) NSMutableDictionary *singleJRGSDict;

@property(nonatomic,strong) NSMutableDictionary *VIPDict;
@property(nonatomic,strong) NSMutableArray *VIPArray;
@property(nonatomic,strong) NSMutableDictionary *singleVIPDict;

@end
