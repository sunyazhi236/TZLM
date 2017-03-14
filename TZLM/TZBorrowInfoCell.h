//
//  TZBorrowInfoCell.h
//  TZLM
//
//  Created by  sun on 2017/3/1.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZBorrowInfoModel.h"

@interface TZBorrowInfoCell : UITableViewCell
@property(nonatomic,strong) TZBorrowInfoModel *borrowModel;

@property (weak, nonatomic) IBOutlet UILabel *borrowText;
@property (weak, nonatomic) IBOutlet UILabel *borrowState;
@property (weak, nonatomic) IBOutlet UILabel *feedbackText;
@property (weak, nonatomic) IBOutlet UILabel *theTimeText;

@end
