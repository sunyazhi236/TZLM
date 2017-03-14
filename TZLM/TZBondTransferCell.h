//
//  TZBondTransferCell.h
//  TZLM
//
//  Created by  sun on 2017/3/2.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZBondTransferModel.h"

@interface TZBondTransferCell : UITableViewCell
@property(nonatomic,strong) TZBondTransferModel *bondTransModel;
@property (weak, nonatomic) IBOutlet UIImageView *bondImage;
@property (weak, nonatomic) IBOutlet UILabel *bondContent;
@property (weak, nonatomic) IBOutlet UILabel *bondContacts;
@property (weak, nonatomic) IBOutlet UILabel *bondTelphone;

@end
