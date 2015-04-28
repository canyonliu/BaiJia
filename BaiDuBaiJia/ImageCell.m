//
//  ImageCell.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/28.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell()

@property(nonatomic ,strong)UIImageView *imageView;

@end

@implementation ImageCell

-(id)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return self;
}

-(void)setIcon:(NSString *)icon
{
    _icon = [icon copy];
    self.imageView.image = [UIImage imageNamed:icon];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end
