//
//  TransferDetailCell.m
//  TZLM
//
//  Created by  sun on 2017/4/13.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "TransferDetailCell.h"

@implementation TransferDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _brand.layer.borderColor = [[UIColor grayColor]CGColor];
    _brand.layer.borderWidth = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
