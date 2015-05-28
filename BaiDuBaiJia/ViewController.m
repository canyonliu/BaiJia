//
//  ViewController.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+XTSideMenu.h"
#import "XTSideMenu.h"
#import "Tools.h"
#import "MJRefresh.h"



#import "NewsShowCell.h"
#import "ImageCell.h"
#import "NewsDetailViewController.h"
#import "NetworkBL.h"
#import "GetContent.h"
#import "NewsInfo.h"
#import<UIImageView+WebCache.h>



//static NSString *cellID = @"collectionCell";


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property(nonatomic ,strong)NSArray *contentArray;

@property(nonatomic ,strong) NewsInfo *infoItem;

@property(nonatomic , strong)NSString *lastID;

@end

@implementation ViewController
@synthesize infoItem,lastID;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _server = [ServerInterface new];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    lastID = nil;
    
    self.headerView.backgroundColor = [Tools getMainColor];
    
    [self setRefresh];
    [self setupCycleImage];

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableSuccess) name:@"All_Data_Update" object:nil];
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableFailed) name:@"All_Data_Update_failed" object:nil];
    
    //测试接口
    
//    ServerInterface *server = [[ServerInterface alloc]init];
//    //[server getAllNews_WithRefreshType:@"1"];
//    
//    [server deleteNewslistInTypeDetailView:@"8"];
//    [server getNewsByType:@"8" andRefreshType:@"1"];
    
    
    [self updateNewsListInMainView];
    //[self loadMoreNewsListInMainView];
    
}

-(void)viewWillLayoutSubviews
{
    //[self showHomeImg];
    //[self setImageSize];
    //[self addImage];
}

-(void)setupCycleImage
{
    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
                        [UIImage imageNamed:@"h2.jpg"],
                        [UIImage imageNamed:@"h3.jpg"],
                        [UIImage imageNamed:@"h4.jpg"]
                        ];
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:self.cycleView.frame imagesGroup:images];
    
    self.cycleView.delegate = self;
    self.cycleView.autoScrollTimeInterval = 2.0;
    [self.view addSubview:self.cycleView];


}
/**
 *  @author LQC
 *
 *  集成刷新控件
 */
-(void)setRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_TableView addHeaderWithTarget:self action:@selector(updateNewsListInMainView)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    // [myTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_TableView addFooterWithTarget:self action:@selector(loadMoreNewsListInMainView)];
    
   // MJRefreshFooterStateNoMoreDataText = @"本次共加载的数据为:";

}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}





#pragma mark - tableView的datasource和delegate方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"NewsShow";
    NewsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewsShowCell" owner:nil options:nil];
    cell = [nib objectAtIndex:0];
    
    infoItem = [_contentArray objectAtIndex:indexPath.row];
    cell.NewsInfo.text = infoItem.newsTitle;
    cell.Source.text = infoItem.newsTime;
    
    NSURL *imgUrl = [NSURL URLWithString:infoItem.newsPicture];
 
    [cell.NewsPic setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed: @"default"]];
    [Tools ChoosenImageViewChangeModelToCircle:cell.NewsPic];

    
    return cell;
}

//跳转到详细新闻界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"newsDetailCell"];
    
    //传递参数
    infoItem = [_contentArray objectAtIndex:indexPath.row];
//    NSString *arr_content = [[NSString alloc]init];
//    NSString *arr_time = [[NSString alloc]init];
//    NSString *arr_summary = [[NSString alloc]init];
//    NSString *arr_pic = [[NSString alloc]init];
    
     detailVC.arr_content = infoItem.newsContent ;
    detailVC.arr_title = infoItem.newsTitle;
    detailVC.arr_picture = infoItem.newsPicture;
    detailVC.arr_time = infoItem.newsTime;
    detailVC.arr_url = infoItem.newsUlr;
    [self presentViewController:detailVC animated:YES completion:nil];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contentArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}



#pragma mark - 展示左边侧滑栏
- (IBAction)showLeftMenu:(UIButton *)sender {
    [self.sideMenuViewController presentLeftViewController];
}



#pragma mark - 上拉刷新和下拉刷新
/********************************下拉刷新,更新*************************/
-(void)updateNewsListInMainView
{
    if ([Tools checkNetWorking]) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Tools showHUD:@"施工中..." andView:self.view andHUD:hud];
        
        
        //更新操作   先删除plist里的数据
        //[_server deleteNewslistInMianView];
        
        [_server getAllNews_WithRefreshType:@"0"andNewsID:nil];
        
        
    }else{
        //调用endRefreshing可以结束刷新状态
        [_TableView headerEndRefreshing];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示!" message:@"网络好像不能连接了" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    
    }
    
    
}

-(void)reloadTableFailed
{
    if(hud)
    {
        [hud hide:YES];
    }
    [self.TableView reloadData];
    [self.TableView headerEndRefreshing];
}





/********************************上拉加载更多*************************/
-(void)loadMoreNewsListInMainView{
    
    if ([Tools checkNetWorking]) {
        //NSDictionary *lastItem = [_contentArray lastObject];

        NewsInfo *lastItem = [_contentArray lastObject];
        lastID = lastItem.newsTime;
        //NewsInfo *lastItem = [NewsInfo new];
        //NSNumber *news_id = lastItem.newsID;
        //NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        //[numberFormatter stringFromNumber:news_id
        
        [_server getAllNews_WithRefreshType:@"1" andNewsID:lastID];
        _contentArray = [GetContent getAllNewsFromDatabase];
       

        
       
        
    }else{
        //调用endRefreshing可以结束刷新状态
        [_TableView footerEndRefreshing];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误!" message:@"请检查网络是否连接" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)reloadTableSuccess
{
    
    [self.TableView reloadData];
    [_TableView footerEndRefreshing];
}




@end
