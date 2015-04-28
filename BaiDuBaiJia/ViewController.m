//
//  ViewController.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "ViewController.h"
#import "NewsShowCell.h"
#import "ImageCell.h"
#import "NewsDetailViewController.h"

//static NSString *cellID = @"collectionCell";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    //self.scrollView.delegate = self;
    //self.CyclicImageView.image = [UIImage imageNamed:@"3"];

}
-(void)viewWillLayoutSubviews
{
    //[self showHomeImg];
    [self setImageSize];
    
    //[self addImage];
}



#pragma mark - 设置图片和添加图片
-(void)setImageSize
{
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    CGFloat imageY = 0;
    NSInteger totalCount = 4;
    self.pageControll.numberOfPages=totalCount;
    
    for(int i = 0 ; i < totalCount;i++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        NSString *name = [NSString stringWithFormat:@"%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self.scrollView addSubview:imageView];
    }
    
    CGFloat contentW = totalCount * imageW;
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
    //设置分页
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self addTimer];
}

-(void)nextImage
{
    int page = (int)self.pageControll.currentPage;
    if(page == 3)
    {
        page = 0;
    }
    else
    {
        page++;
    }
    NSLog(@"self.page=== %d",page);
    CGFloat x = page * self.scrollView.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(x, 0);
    
}

#pragma mark - 实现定时器的操作
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2) / scrollViewW;
    self.pageControll.currentPage = page;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
-(void)removeTimer
{
    [self.timer invalidate];
}

#pragma mark - 第一种:通过uiimageview的方式来实现轮播(比较简单,但是效果不是很好)
-(void)showHomeImg
{
    //newCouseBL = [NewCourseBL new];
    NSMutableArray *homeImg = [NSMutableArray arrayWithObjects:@"2",@"3",@"4",@"5", nil];
    NSMutableArray *homeImgFinash = [NSMutableArray new];
    //homeImg = [newCouseBL getHomePicture];
    
    for (int i=0; i<[homeImg count]; i++) {
        UIImage *q = [UIImage imageNamed:[homeImg objectAtIndex:i]];
        [homeImgFinash addObject:q];
    }
    
    //imageView的动画图片是数组images
    _CyclicImageView.animationImages = homeImgFinash;
    //按照原始比例缩放图片，保持纵横比
    //_CyclicImageView.contentMode = UIViewContentModeScaleAspectFit;
    //切换动作的时间3秒，来控制图像显示的速度有多快，
    _CyclicImageView.animationDuration = 5;
    //动画的重复次数，想让它无限循环就赋成0
    _CyclicImageView.animationRepeatCount = 0;
    //开始动画
    [_CyclicImageView startAnimating];
}





#pragma mark - tableView的datasource和delegate方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"NewsShow";
    NewsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewsShowCell" owner:nil options:nil];
    cell = [nib objectAtIndex:0];
    cell.NewsInfo.text = @"百度百家";
    cell.Source.text = @"IT之家";
    cell.NewsPic.image = [UIImage imageNamed:@"2"];
    
    
    return cell;
}

//跳转到详细新闻界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"newsDetailCell"];
    //[self.navigationController pushViewController:detailVC animated:YES];
    [self presentViewController:detailVC animated:YES completion:nil];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}



@end
