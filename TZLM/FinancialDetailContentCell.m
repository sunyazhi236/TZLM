//
//  FinancialDetailContentCell.m
//  TZLM
//
//  Created by  sun on 2017/4/12.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "FinancialDetailContentCell.h"

@implementation FinancialDetailContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _content.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
