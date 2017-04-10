//
//  FinancialListHeaderView.m
//  TZLM
//
//  Created by  sun on 2017/4/6.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "FinancialListHeaderView.h"

@implementation FinancialListHeaderView


-(void)setProvinceView{
    
    self.backgroundColor = [UIColor whiteColor];
    _provinceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kAutoWEX(253), kAutoHEX(25))];
    [_provinceBtn setTitle:@"     全国" forState:UIControlStateNormal];
    [_provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_provinceBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
    [_provinceBtn addTarget:self action:@selector(provinceClick) forControlEvents:UIControlEventTouchUpInside];
    _provinceBtn.titleLabel.font = [UIFont systemFontOfSize_5:14];
    _provinceBtn.backgroundColor = RGBColor(215, 215, 215);
    _provinceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(kAutoWEX(225), kAutoHEX(3), kAutoWEX(18), kAutoHEX(18))];
    imgV.image = [UIImage imageNamed:@"查询老赖2"];
    [_provinceBtn addSubview:imgV];
    [self addSubview:_provinceBtn];
    
}

-(void)setView{
    CGFloat btnWidth = (kScreenW - 3) / 4;
    CGFloat labHeight = 30;
    CGFloat btnHeight = 40;
    self.backgroundColor = [UIColor whiteColor];
    _typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
    [_typeBtn setTitle:@"不限" forState:UIControlStateNormal];
    [_typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_typeBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
    [_typeBtn addTarget:self action:@selector(typeClick) forControlEvents:UIControlEventTouchUpInside];
    _typeBtn.titleLabel.font = [UIFont systemFontOfSize_5:14];
    [self addSubview:_typeBtn];
    
    UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(btnWidth - 18, btnHeight - 12, 6, 6)];
    image1.image = [UIImage imageNamed:@"shaixuanjian"];
    [_typeBtn addSubview:image1];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_typeBtn.frame), 5, 1, labHeight)];
    label1.backgroundColor = [UIColor whiteColor];
    [self addSubview:label1];
    
    _limitBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 0, btnWidth, btnHeight)];
    [_limitBtn setTitle:@"不限" forState:UIControlStateNormal];
    [_limitBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
    [_limitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _limitBtn.titleLabel.font = [UIFont systemFontOfSize_5:14];
    
    [_limitBtn addTarget:self action:@selector(limitClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_limitBtn];
    
    UIImageView * image2 = [[UIImageView alloc]initWithFrame:CGRectMake(btnWidth - 18, btnHeight - 12, 6, 6)];
    image2.image = [UIImage imageNamed:@"shaixuanjian"];
    [_limitBtn addSubview:image2];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_limitBtn.frame), 5, 1, labHeight)];
    label2.backgroundColor = [UIColor whiteColor];
    [self addSubview:label2];
    
    
    _creditBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), 0, btnWidth, btnHeight)];
    [_creditBtn setTitle:@"不限" forState:UIControlStateNormal];
    [_creditBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
    [_creditBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _creditBtn.titleLabel.font = [UIFont systemFontOfSize_5:14];
    
    [_creditBtn addTarget:self action:@selector(creditClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_creditBtn];
    
    UIImageView * image3 = [[UIImageView alloc]initWithFrame:CGRectMake(btnWidth - 18, btnHeight - 12, 6, 6)];
    image3.image = [UIImage imageNamed:@"shaixuanjian"];
    [_creditBtn addSubview:image3];
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_creditBtn.frame), 5, 1, labHeight)];
    label3.backgroundColor = [UIColor whiteColor];
    [self addSubview:label3];
    
    _userBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), 0, btnWidth, btnHeight)];
    [_userBtn setTitle:@"不限" forState:UIControlStateNormal];
    [_userBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
    [_userBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _userBtn.titleLabel.font = [UIFont systemFontOfSize_5:14];
    
    [_userBtn addTarget:self action:@selector(userClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_userBtn];
    
    UIImageView * image4 = [[UIImageView alloc]initWithFrame:CGRectMake(btnWidth - 18, btnHeight - 12, 6, 6)];
    image4.image = [UIImage imageNamed:@"shaixuanjian"];
    [_userBtn addSubview:image4];
    
    _botView = [[UIView alloc]initWithFrame:CGRectMake(0, btnHeight, kScreenW, 5)];
    _botView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self addSubview:_botView];
}


-(void)provinceClick{
    if (self.provinceBlock) {
        self.provinceBlock();
    }
}

-(void)userClick{
    
    if (self.userBlock) {
        
        self.userBlock();
    }
}

-(void)creditClick{
    
    if (self.creditBlock) {
        
        self.creditBlock();
    }
}

-(void)limitClick{
    
    if (self.limitBlock) {
        self.limitBlock();
    }
}

-(void)typeClick{
    
    if (self.typeBlock) {
        
        self.typeBlock();
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
