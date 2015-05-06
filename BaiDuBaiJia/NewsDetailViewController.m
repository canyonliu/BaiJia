//
//  NewsDetailViewController.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/28.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailToolBar.h"

@interface NewsDetailViewController ()<NewsDetailToolBarDelegate>

@property(nonatomic ,strong)NewsDetailToolBar *toolBar;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupToolBar];
}

-(void)setupToolBar
{
    NewsDetailToolBar *toolBar = [[NewsDetailToolBar alloc]init];
    self.toolBar = toolBar;
    CGFloat toolBarW = self.view.frame.size.width;
    CGFloat toolBarH = 44.0;
    CGFloat x = 0;
    CGFloat y = self.view.frame.size.height - toolBarH - 15;
   
    toolBar.frame = CGRectMake(x, y, toolBarW, toolBarH);
    toolBar.delegate = self;
    
    [self.view addSubview:toolBar];
}

#pragma mark - 实现toolbar的代理
-(void)detailToolBar:(NewsDetailToolBar *)detailToolBar didButtonClick:(NewsDetailToolBarButtonTag)tag
{
    switch (tag) {
        case NewsDetailToolBarButtonTagBack:
            [self dismissViewcontroller];
            NSLog(@"点击返回按钮");
            break;
            
        case NewsDetailToolBarButtonTagPraise:
            NSLog(@"点击点赞按钮");
            break;
            
        case NewsDetailToolBarButtonTagShare:
            NSLog(@"点击分享按钮");
            break;
            
        case NewsDetailToolBarButtonTagStore:
            NSLog(@"点击收藏按钮");
            break;
            
        default:
            break;
    }
}

-(void)dismissViewcontroller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
