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
    _brand.font = [UIFont systemFontOfSize_5:13];
    _series.layer.borderColor = [[UIColor grayColor]CGColor];
    _series.layer.borderWidth = 0.5f;
    _series.font = [UIFont systemFontOfSize_5:13];
    _price.layer.borderColor = [[UIColor grayColor]CGColor];
    _price.layer.borderWidth = 0.5f;
    _price.font = [UIFont systemFontOfSize_5:13];
    _years.layer.borderColor = [[UIColor grayColor]CGColor];
    _years.layer.borderWidth = 0.5f;
    _years.font = [UIFont systemFontOfSize_5:13];
    _gearbox.layer.borderColor = [[UIColor grayColor]CGColor];
    _gearbox.layer.borderWidth = 0.5f;
    _gearbox.font = [UIFont systemFontOfSize_5:13];
    _style.layer.borderColor = [[UIColor grayColor]CGColor];
    _style.layer.borderWidth = 0.5f;
    _style.font = [UIFont systemFontOfSize_5:13];
    _time.layer.borderColor = [[UIColor grayColor]CGColor];
    _time.layer.borderWidth = 0.5f;
    _time.font = [UIFont systemFontOfSize_5:13];
    _site.layer.borderColor = [[UIColor grayColor]CGColor];
    _site.layer.borderWidth = 0.5f;
    _site.font = [UIFont systemFontOfSize_5:13];
    _mileage.layer.borderColor = [[UIColor grayColor]CGColor];
    _mileage.layer.borderWidth = 0.5f;
    _mileage.font = [UIFont systemFontOfSize_5:13];
    _displacement.layer.borderColor = [[UIColor grayColor]CGColor];
    _displacement.layer.borderWidth = 0.5f;
    _displacement.font = [UIFont systemFontOfSize_5:13];
    _state.layer.borderColor = [[UIColor grayColor]CGColor];
    _state.layer.borderWidth = 0.5f;
    _state.font = [UIFont systemFontOfSize_5:13];
    _tradingPlace.layer.borderColor = [[UIColor grayColor]CGColor];
    _tradingPlace.layer.borderWidth = 0.5f;
    _tradingPlace.font = [UIFont systemFontOfSize_5:13];
    _contacts.layer.borderColor = [[UIColor grayColor]CGColor];
    _contacts.layer.borderWidth = 0.5f;
    _contacts.font = [UIFont systemFontOfSize_5:13];
    _contactInformation.layer.borderColor = [[UIColor grayColor]CGColor];
    _contactInformation.layer.borderWidth = 0.5f;
    _contactInformation.font = [UIFont systemFontOfSize_5:13];
    
    _bgView.frame=CGRectMake(0, 0, kScreenW, kAutoHEX(217));
    _content.numberOfLines = 0;
    _content.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kScreenW, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [_content sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    _content.frame = CGRectMake(0, CGRectGetMinY(_bgView.frame)+_bgView.frame.size.height+kAutoHEX(10), expectSize.width, expectSize.height);
    _imgV.frame = CGRectMake(kAutoWEX(17), CGRectGetMinY(_content.frame)+_content.frame.size.height+kAutoHEX(10), kAutoWEX(285), kAutoHEX(200));
    
    self.frame = CGRectMake(0, 0, kScreenW, kAutoHEX(_bgView.frame.size.height+_content.frame.size.height+_imgV.frame.size.height+30));

}

-(void)setFrame:(CGRect)frame{
      [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
