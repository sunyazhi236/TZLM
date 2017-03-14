//
//  CFLoadingView.m
//  CFProgressHUD
//
//  Created by 李旭日 on 15/7/27.
//  Copyright (c) 2015年 Lixuri. All rights reserved.
//

#import "CFLoadingView.h"
#import "UIView+MJExtension.h"
@interface CFLoadingView()

@property(nonatomic,weak)NSTimer *link;

@end
@implementation CFLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        NSMutableArray *imagesArr = [[NSMutableArray alloc] init];
        for (int i = 1; i < 13; i++) {
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic_loading_%d.png", i]];
            
            [imagesArr addObject:image];
        }
        
        [self setAnimationDuration:imagesArr.count * 0.125];
        
        [self setAnimationImages:imagesArr];
        
//        [self setImage:[UIImage imageNamed:@"loading_1.png"]];
//        self.contentMode = UIViewContentModeCenter;
        [self setAnimationRepeatCount:0];
        
        [self startAnimating];
    }
    return self;
}
//开始旋转
- (void)startRotating
{
    if (self.link)return;
//    NSTimer *link = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateData) userInfo:nil repeats:YES];
    NSTimer *link=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateData) userInfo:nil repeats:YES];
//    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}
//结束旋转
- (void)stopRotating
{
    [self.link invalidate];
    self.link = nil;
}
- (void)updateData
{
    self.transform = CGAffineTransformRotate(self.transform, M_PI/8);
}

- (void)dealloc
{
    [self stopAnimating];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

+ (CFLoadingView *)loadingView
{
    return [[self alloc]init];
}

@end
