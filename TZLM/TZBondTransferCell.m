//
//  TZBondTransferCell.m
//  TZLM
//
//  Created by  sun on 2017/3/2.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "TZBondTransferCell.h"


@implementation TZBondTransferCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setBondTransModel:(TZBondTransferModel *)bondTransModel{
    
    _bondTransModel=bondTransModel;
    [self setUI];
}

-(void)setUI{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[_bondTransModel.cover_id_more objectAtIndex:0]];//照片路径 大图 小图
    NSString *string = [NSString stringWithFormat:@"%@%@",TZ_MAIN,[dict objectForKey:@"path"]];
    [self.bondImage sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@"banner2.png"]];
    self.bondContent.text=_bondTransModel.content;
    self.bondContacts.text=_bondTransModel.contact_person;
    self.bondTelphone.text=_bondTransModel.contact_info;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
