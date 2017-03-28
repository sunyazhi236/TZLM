//
//  TZBorrowInfoCell.m
//  TZLM
//
//  Created by  sun on 2017/3/1.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "TZBorrowInfoCell.h"
#import "SMGlobalMethod.h"
@implementation TZBorrowInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setBorrowModel:(TZBorrowInfoModel *)borrowModel{
    _borrowModel=borrowModel;
    [self setUI];
}


-(void)setUI{
    if (_borrowModel==nil) {
        self.borrowText.text=@"";
        [self.borrowState setTitle:@"" forState:UIControlStateNormal];
        self.feedbackText.text=@"";
        self.theTimeText.text=@"";
    }
    else{
    self.borrowText.numberOfLines = 0;
    self.borrowText.lineBreakMode = NSLineBreakByTruncatingTail;
    self.borrowText.text = _borrowModel.lend_content;
 
        if (_borrowModel.cc_class == 1 ) {
//            self.borrowState.text = @"借款信息";
//            [self.borrowState setTextColor:[UIColor colorWithDisplayP3Red:80/255.0 green:152/255.0 blue:4/255.0 alpha:1.0]];
            [self.borrowState setBackgroundImage:[UIImage imageNamed:@"jiekuan"] forState:UIControlStateNormal];
        }else{
//            self.borrowState.text = @"放款信息";
//            [self.borrowState setTextColor:[UIColor colorWithDisplayP3Red:252/255.0 green:40/255.0 blue:104/255.0 alpha:1.0]];
            [self.borrowState setBackgroundImage:[UIImage imageNamed:@"fangkuan"] forState:UIControlStateNormal];
        }
    }
    if ([_borrowModel.yw_uid integerValue]==0) {
            self.feedbackText.text=@"暂无反馈";
    }else{
        self.feedbackText.text= @"用户昵称";
    }
   [self.feedbackText setTextColor:[UIColor grayColor]];
    self.theTimeText.text=[SMGlobalMethod getTimeFromShortTimeSp:_borrowModel.update_time];
    [self.theTimeText setTextColor:[UIColor grayColor]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
