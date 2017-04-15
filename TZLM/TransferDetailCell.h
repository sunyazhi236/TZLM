//
//  TransferDetailCell.h
//  TZLM
//
//  Created by  sun on 2017/4/13.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *brand;//品牌
@property (weak, nonatomic) IBOutlet UILabel *series;//车系
@property (weak, nonatomic) IBOutlet UILabel *price;//价格
@property (weak, nonatomic) IBOutlet UILabel *years;//年款
@property (weak, nonatomic) IBOutlet UILabel *gearbox;//变速箱
@property (weak, nonatomic) IBOutlet UILabel *style;//款型
@property (weak, nonatomic) IBOutlet UILabel *time;//上牌时间

@property (weak, nonatomic) IBOutlet UILabel *site;//上牌地
@property (weak, nonatomic) IBOutlet UILabel *mileage;//里程
@property (weak, nonatomic) IBOutlet UILabel *displacement;//排量
@property (weak, nonatomic) IBOutlet UILabel *state;//车辆状态
@property (weak, nonatomic) IBOutlet UILabel *tradingPlace;//交易地点
@property (weak, nonatomic) IBOutlet UILabel *contacts;//联系人
@property (weak, nonatomic) IBOutlet UILabel *contactInformation;//联系方式

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end
