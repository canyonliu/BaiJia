//
//  ViewController.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillLayoutSubviews
{
    //self.CyclicImageView
}

//-(void)showHomeImg
//{
//    newCouseBL = [NewCourseBL new];
//    NSMutableArray *homeImg = [NSMutableArray new];
//    NSMutableArray *homeImgFinash = [NSMutableArray new];
//    homeImg = [newCouseBL getHomePicture];
//    for (int i=0; i<[homeImg count]; i++) {
//        UIImage *q = [UIImage imageWithData:[homeImg objectAtIndex:i]];
//        [homeImgFinash addObject:q];
//    }
//    
//    //imageView的动画图片是数组images
//    _homePicture.animationImages = homeImgFinash;
//    //按照原始比例缩放图片，保持纵横比
//    //_homePicture.contentMode = UIViewContentModeScaleAspectFit;
//    //切换动作的时间3秒，来控制图像显示的速度有多快，
//    _homePicture.animationDuration = 5;
//    //动画的重复次数，想让它无限循环就赋成0
//    _homePicture.animationRepeatCount = 0;
//    //开始动画
//    [_homePicture startAnimating];
//}



@end
