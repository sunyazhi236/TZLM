//
//  TZFinancialAdvisorCell.h
//  TZLM
//
//  Created by  sun on 2017/4/5.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZFinancialAdvisorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *counselorImg;
@property (weak, nonatomic) IBOutlet UILabel *counselorName;
@property (weak, nonatomic) IBOutlet UILabel *counselorType;
@property (weak, nonatomic) IBOutlet UILabel *counselorContent;
@property (weak, nonatomic) IBOutlet UILabel *pageview;
@property (weak, nonatomic) IBOutlet UILabel *theTime;

@end
