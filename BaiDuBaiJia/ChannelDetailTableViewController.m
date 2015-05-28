//
//  ChannelDetailTableViewController.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "ChannelDetailTableViewController.h"
#import "NewsDetailViewController.h"
//#import "NewsTypeDAO.h"
#import "NewsShowCell.h"
#import "Tools.h"
#import "ServerInterface.h"
#import "GetContent.h"
#import "NewsInfo.h"
#import "GetContent.h"


#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import<UIImageView+WebCache.h>

@interface ChannelDetailTableViewController ()
{
   // NewsTypeDAO *typeDao;
    MBProgressHUD *hud;
    ServerInterface *_server;
}

@property(nonatomic ,strong)NSMutableArray *titleArray;

@property(nonatomic ,strong) NSString * channelID;

@property(nonatomic ,strong)NewsInfo *infoItem;
@end

@implementation ChannelDetailTableViewController
@synthesize channelName,channelID,infoItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    _server = [ServerInterface new];
    
    [self judgeWhichChannelByName:channelName];
    [self setRefresh];
    
   
    self.Title.text = channelName;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable) name:@"Data_Update" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  @author LQC
 *
 *  集成刷新控件
 */
-(void)setRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.myTablewView addHeaderWithTarget:self action:@selector(updateNewsListInMainView:)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    // [myTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    //[self.tableView addFooterWithTarget:self action:@selector(loadMoreNewsListInMainView:)];
}


#pragma mark - 上拉刷新和下拉刷新
/********************************下拉刷新,更新*************************/
-(void)updateNewsListInMainView:(NSString *)channel_ID
{
    channel_ID = channelID;
    if ([Tools checkNetWorking]) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Tools showHUD:@"施工中..." andView:self.view andHUD:hud];
        
        
        //更新操作   先删除plist里的数据
        //[_server deleteNewslistInTypeDetailView:channel_ID];
        //[_server getNewsByType:channel_ID andRefreshType:@"0"];
        
        [_server getNewsByType:channel_ID andRefreshType:@"1"];
        
        
    }else{
        //调用endRefreshing可以结束刷新状态
        [self.myTablewView headerEndRefreshing];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示!" message:@"网络好像不能连接了" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
}


/********************************上拉加载更多*************************/
-(void)loadMoreNewsListInMainView:(NSString *)channel_ID
{
    channel_ID = channelID;
    if ([Tools checkNetWorking]) {
        
        [_server getNewsByType:channel_ID andRefreshType:@"1"];
        
    }else{
        //调用endRefreshing可以结束刷新状态
        [self.myTablewView footerEndRefreshing];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误!" message:@"请检查网络是否连接" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//收到通知,结束等待页面
-(void)reloadTable
{
    if(hud)
    {
        [hud hide:YES];
    }
    [self.myTablewView reloadData];
    [self.myTablewView headerEndRefreshing];
}






-(void)judgeWhichChannelByName:(NSString *)channel_name
{
    self.titleArray = [[NSMutableArray alloc]init];
    //typeDao = [NewsTypeDAO shareManager];
    //[typeDao removeAllNews];
    //ServerInterface *server = [ServerInterface new];
    
    if([channel_name isEqualToString:@"互联网"])
    {
        channelID = @"8";
    }
    else if([channel_name isEqualToString:@"热点"])
    {
        channelID = @"9";
    }
    else if([channel_name isEqualToString:@"文化"])
    {
        channelID = @"10";
    }
    else if([channel_name isEqualToString:@"娱乐"])
    {
        channelID = @"11";
    }
    else if([channel_name isEqualToString:@"体育"])
    {
        channelID = @"12";
    }
    else if([channel_name isEqualToString:@"财经"])
    {
        channelID = @"13";
    }
     //[self loadMoreNewsListInMainView:channelName];
    [_server getNewsByType:channelID andRefreshType:@"1"];
    
    //查询plist 表
    //[typeDao removeNewsWithChannelID:channelID];
    self.titleArray  = [GetContent getTypeNewsFromDatabase:channelID];
    
    
    
    //self.titleArray = @[@"刘海",@"卡马乔",@"刘海",@"卡马乔",@"刘海",@"卡马乔"];


}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    static NSString *ID = @"NewsShow";
    NewsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewsShowCell" owner:nil options:nil];
    cell = [nib objectAtIndex:0];
    
    infoItem = [_titleArray objectAtIndex:indexPath.row];
    
    
    cell.NewsInfo.text = infoItem.newsTitle;
    //[[_contentArray objectAtIndex:indexPath.row]objectForKey:@"News_Title"];
    
    cell.Source.text = infoItem.newsTime;
//    if([infoItem.newsPicture isEqualToString:@"none"])
//    {
//        cell.NewsPic.image = nil;
//    }
//    else
//    {
        NSURL *imgUrl = [NSURL URLWithString:infoItem.newsPicture];
        //cell.NewsPic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        [cell.NewsPic setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed: @"default"]];
        [Tools ChoosenImageViewChangeModelToCircle:cell.NewsPic];
   // }

    
    return cell;
   
}

//跳转到详细新闻界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"newsDetailCell"];
    
    //传递参数
    infoItem = [_titleArray objectAtIndex:indexPath.row];
    
    detailVC.arr_content = infoItem.newsContent ;
    detailVC.arr_title = infoItem.newsTitle;
    detailVC.arr_picture = infoItem.newsPicture;
    detailVC.arr_time = infoItem.newsTime;
    detailVC.arr_url = infoItem.newsUlr;
    [self presentViewController:detailVC animated:YES completion:nil];
}



- (IBAction)DismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
