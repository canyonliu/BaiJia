//
//  NewsDetailToolBar.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/28.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "NewsDetailToolBar.h"

@implementation NewsDetailToolBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self addButtonWithIcon:@"1" highlightedIcon:@"2" tag:
         NewsDetailToolBarButtonTagBack];
        
        [self addButtonWithIcon:@"1" highlightedIcon:@"2" tag:NewsDetailToolBarButtonTagPraise];
        
        [self addButtonWithIcon:@"1" highlightedIcon:@"2" tag:NewsDetailToolBarButtonTagShare];
        
        [self addButtonWithIcon:@"1" highlightedIcon:@"2" tag:NewsDetailToolBarButtonTagStore];
        
        
        
    }
    return  self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat ButtonW = self.frame.size.width / self.subviews.count;
    //设置按钮位置
    for(int i = 0 ; i < self.subviews.count; i++)
    {
        UIButton *button = self.subviews[i];
        CGFloat buttonH = ButtonW;
        CGFloat buttonX = i * ButtonW;
        CGFloat buttonY = (self.frame.size.height - buttonH)/2;
        button.frame = CGRectMake(buttonX, buttonY, ButtonW, buttonH);
    }
}

//给按钮设置各个状态下的图片
-(void)addButtonWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon tag:(NewsDetailToolBarButtonTag)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedIcon] forState:UIControlStateHighlighted];
    button.tag = tag;
    
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

//那个被点击按钮的响应事件
-(void)buttonClicked:(UIButton *)button
{
    if([self.delegate respondsToSelector:@selector(detailToolBar:didButtonClick:)])
    {
        [self.delegate detailToolBar:self didButtonClick:button.tag];
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
