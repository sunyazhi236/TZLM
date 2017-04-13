//
//  FinancialDetailHeaderCell.h
//  TZLM
//
//  Created by  sun on 2017/4/12.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinancialDetailHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *website;
@property (weak, nonatomic) IBOutlet UILabel *intro;

@end
