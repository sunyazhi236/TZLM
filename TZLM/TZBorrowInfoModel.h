//
//  TZBorrowInfoModel.h
//  TZLM
//
//  Created by  sun on 2017/3/1.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZBorrowInfoModel : NSObject

@property(nonatomic,strong) NSString *id;//文档id
@property(nonatomic,strong) NSString *uid;// 发布该文档的用户id(0为游客)
@property(nonatomic,strong) NSString *title;// 文档标题
@property(nonatomic,strong) NSString *category_id;// 栏目id
@property(nonatomic,strong) NSString *description;//文档描述
@property(nonatomic,strong) NSString *model_id;//模型id
@property(nonatomic,strong) NSString *type;//内容类型
@property(nonatomic,strong) NSString *cover_id;// 图片路径数组，例:[{'path':'大图路径','path_small':'小图路径'},{...}]
@property(nonatomic,assign) BOOL display;// 是否显示(0或1)
@property(nonatomic,strong) NSString *view;//浏览次数
@property(nonatomic,strong) NSString *comment;//评论数
@property(nonatomic,strong) NSString *create_time;//创建时间(时间截)
@property(nonatomic,strong) NSString *update_time;//更新时间（时间截）
@property(nonatomic,strong) NSString *cc_area;//所属地区
@property(nonatomic,assign) BOOL cc_top;// 是否置顶（0或1）
@property(nonatomic,assign) BOOL vip;//vip级别（0或1）

@property(nonatomic,strong) NSString *lend_content; //内容
@property(nonatomic,strong) NSString *yw_uid; //客服（如果为‘0’就是暂无反馈，否则就是昵称）
@property(nonatomic,assign) NSInteger cc_class; //1是借款信息，2是放款信息

@end
