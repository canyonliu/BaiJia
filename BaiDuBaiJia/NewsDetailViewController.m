//
//  NewsDetailViewController.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/28.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailToolBar.h"
#import "UMSocial.h"
#import "MBProgressHUD.h"
#import "Tools.h"


@interface NewsDetailViewController ()<NewsDetailToolBarDelegate>
{
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UILabel *newsDatailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *newsDetailImage;


@property (weak, nonatomic) IBOutlet UILabel *newsDetailTime;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UILabel *newsDetailContent;




@property(nonatomic ,strong)NewsDetailToolBar *toolBar;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupToolBar];
    [self registerShake];
    
    [self receiveValue];
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [UMSocialShakeService unShakeToSns];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.myScrollView.contentSize=CGSizeMake(320.0,600.0);
}


-(void)receiveValue
{
    self.newsDetailTime.text = self.arr_time;
    self.newsDetailImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.arr_picture]]];
    self.newsDetailContent.text = self.arr_content;
    self.newsDatailTitle.text = self.arr_title;
}



-(void)setupToolBar
{
    NewsDetailToolBar *toolBar = [[NewsDetailToolBar alloc]init];
    self.toolBar = toolBar;
    CGFloat toolBarW = self.view.frame.size.width;
    CGFloat toolBarH = 44.0;
    CGFloat x = 0;
    CGFloat y = self.view.frame.size.height - toolBarH;
   
    toolBar.frame = CGRectMake(x, y, toolBarW, toolBarH);
    toolBar.delegate = self;
    
    [self.view addSubview:toolBar];
}


-(void)registerShake
{
    //注册摇一摇截图分享
    [UMSocialShakeService setShakeToShareWithTypes:@[UMShareToSina,UMShareToWechatSession,UMShareToQzone,UMShareToQQ,UMShareToRenren]
                                         shareText:@"来自--奔跑的土匪--分享"
                                      screenShoter:[UMSocialScreenShoterDefault screenShoter]
                                  inViewController:self
                                          delegate:nil];
    
    //可以设置响应摇一摇阈值，数值越低越灵敏，默认是0.8
    [UMSocialShakeService setShakeThreshold:1.2];
}

#pragma mark - 实现toolbar的代理
-(void)detailToolBar:(NewsDetailToolBar *)detailToolBar didButtonClick:(NewsDetailToolBarButtonTag)tag
{
    switch (tag) {
        case NewsDetailToolBarButtonTagBack:
            [self dismissViewcontroller];
            NSLog(@"点击返回按钮");
            break;
            
        //case NewsDetailToolBarButtonTagPraise:
            
          //  NSLog(@"点击点赞按钮");
           // break;
            
        case NewsDetailToolBarButtonTagShare:
            [self shareButtonClick];
            NSLog(@"点击分享按钮");
            break;
            
        case NewsDetailToolBarButtonTagStore:
            [self StoreButtonClick];
            NSLog(@"点击收藏按钮");
            NSLog(@"点击喜欢按钮");
            break;
            
        default:
            break;
    }
}

-(void)dismissViewcontroller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 点击分享按钮后的一系列操作
-(void)shareButtonClick
{
    NSLog(@"_______%s_____",__FUNCTION__);
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"555b295867e58e3440002e5a"
                                      shareText:@"精彩你我共享"
                                     shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.arr_picture]]]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter,nil]
                                       delegate:nil];
    
    //Qzone设置title方法将平台参数名替换即可
    [UMSocialData defaultData].extConfig.qzoneData.title = @"Qzone分享title";
    //Qzone设置点击分享内容跳转链接替换平台参数名即可
    [UMSocialData defaultData].extConfig.qzoneData.url = self.arr_url;
    
    [UMSocialData defaultData].extConfig.qqData.url = self.arr_url;
}


//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        
    }
}



//在摇一摇的回调方法弹出分享面板
-(UMSocialShakeConfig)didShakeWithShakeConfig
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"555b295867e58e3440002e5a" shareText:@"你的分享文字" shareImage:[[UMSocialScreenShoterDefault screenShoter] getScreenShot] shareToSnsNames:@[UMShareToSina,UMShareToQzone,UMShareToQQ,UMShareToRenren,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline] delegate:nil];
    //下面返回值控制是否显示分享编辑页面、是否显示截图、是否有音效，UMSocialShakeConfigNone表示都不显示
    
    //Qzone设置点击分享内容跳转链接替换平台参数名即可
    [UMSocialData defaultData].extConfig.qzoneData.url = self.arr_url;
    
    [UMSocialData defaultData].extConfig.qqData.url = self.arr_url;
    
    return UMSocialShakeConfigDefault;
}


#pragma mark - 点击收藏(喜欢)按钮后的一系列操作
-(void)StoreButtonClick
{
    
    //发送一个喜欢的请求，或者如果已经喜欢过的话，发送取消喜欢的请求。
    //把你的文章或者音乐的标识，作为@"identifier"
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:@"identifier"];
    UMSocialDataService *socialDataService = [[UMSocialDataService alloc] initWithUMSocialData:socialData];
    [socialDataService postAddLikeOrCancelWithCompletion:^(UMSocialResponseEntity *response){
        //获取请求结果
        NSLog(@"resposne is %@",response);
    }];
    
    //BOOL isLike = socialData.isLike;
    //从线上获取喜欢数
    //socialDataService为设置评论内容中初始化的对象
    [socialDataService requestSocialDataWithCompletion:^(UMSocialResponseEntity *response){
        // 下面的方法可以获取保存在本地的评论数，如果app重新安装之后，数据会被清空，可能获取值为0
        int likeNumber = [socialDataService.socialData getNumber:UMSNumberLike];
        NSLog(@"likeNum is %d",likeNumber);
    }];
    
    
    
    
    /**
     *  @author LQC
     *
     *  test
     */
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Tools showHUD:@"收藏中.." andView:self.view andHUD:hud];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(3);
        
    }completionBlock:^{
        //[hud hide:YES];
        [hud removeFromSuperview];
    }];
}




@end
