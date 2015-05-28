//
//  NewsParserBL.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/7.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "NewsParserBL.h"
#import "NewsInfo.h"

#import "NewsTypeDAO.h"
#import "AllNewsDAO.h"
#import "NewsInfo.h"

@implementation NewsParserBL
{
    NewsTypeDAO *typeDao;
    AllNewsDAO *allNewsDao;
    NewsInfo *newsinfoItem;
}


-(instancetype)init
{
    self = [super init];
    if(self)
    {
        
        newsinfoItem = [NewsInfo new];
        typeDao = [NewsTypeDAO shareManager];
        allNewsDao = [AllNewsDAO shareManager];
    }
    return  self;
}




-(void)saveCyclePicture
{
    
}


//1是向xia获取最新,0是向shang获取更多
//应该让他进来的时候默认为0;
-(void)saveNewsByType:(NSString *)typeID andRefreshType:(NSString *)refreshType
{
    //测试接口
    [_network getLatestRefreshNewsWithPage:@"" andNewsCount:@"10" andRefreshTypy:refreshType andLastID:@"" andLastTime:@"" andTypeid:typeID andAuthorid:@""];
    if([refreshType isEqualToString:@"0"])
    {
         //更新操作   先删除plist里的数据
    }
    else
    {
         //直接往plist里面添加新的数据
    }
    
    
}


-(void)saveNewsByAuthor:(NSString *)authorID andRefreshType:(NSString *)refreshType
{
    [_network getLatestRefreshNewsWithPage:@"" andNewsCount:@"10" andRefreshTypy:refreshType andLastID:@"" andLastTime:@"" andTypeid:@"" andAuthorid:authorID];
    if([refreshType isEqualToString:@"0"])
    {
        //更新操作   先删除plist里的数据
        //添加等待视图
    }
    else
    {
        //直接往plist里面添加新的数据
    }

}


//ID从本地表中直接获取
-(void)saveRefreshNewsByLastID
{
    
}

//lastTime也是从表中直接获取
-(void)saveRefreshNewsByLastTime
{
    
}





//只做数据存储,把解析传来的data存进去
-(void)saveAllNewsByType:(NSData *)jsonData andChannel:(NSString *)channel
{
 
        NSError *error;
        NSDictionary *idJson = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
     //NSLog(@"nsdicdsf======%@",idJson);
    if (idJson == nil) {
            NSLog(@"idJson parse failed \r\n");
    }
     else
     {
         //成功收到消息 ,则发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Data_Update" object:nil];
    //[typeDao removeNewsWithChannelID:channel];
    NSArray *dataArray = [NSArray array];
    dataArray = [idJson objectForKey:@"list"];
    [typeDao insertNews:dataArray andChannel:channel];
         
         
     }
    
//    for(NSDictionary *dict in dataArray)
//    {
//    
//    newsinfoItem.newsContent  = [dict objectForKey:@"ncontent"];
//    newsinfoItem.newsTypeID = [dict objectForKey:@"tid"];
//    newsinfoItem.newsTitle = [dict objectForKey:@"ntitle"];
//    NSLog(@"nsdic======%@",newsinfoItem.newsTitle);
//    
//    newsinfoItem.NewsTime = [dict objectForKey:@"ntime"];
//    newsinfoItem.newsSummary = [dict objectForKey:@"nsummary"];
//        if (newsinfoItem.newsSummary == nil) {
//            newsinfoItem.newsSummary = @" ";
//        }
//    newsinfoItem.newsPicture = [dict objectForKey:@"purl"];
//    newsinfoItem.newsUlr = [dict objectForKey:@"nurl"];
//        newsinfoItem.newsAuthor =@" ";
    
    //[typeDao insertAllNews:newsinfoItem];
    //}

    //}
}

-(void)saveAllNews:(NSData *)jsonData
{
    //NSData *newsTypeData = [self getAllNews];
    NSError *error;
    NSDictionary *idJson = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSLog(@"nsdicdsf======%@",idJson);
    if (idJson == nil) {
        NSLog(@"idJson parse failed \r\n");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"All_Data_Update_failed" object:nil];

        
    }
    //[allNewsDao removeAllNews];
    else{
        
        //成功收到消息 ,则发送通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"All_Data_Update" object:nil];

        
        
    NSMutableArray *dataArray = [NSMutableArray array];
    dataArray = [idJson objectForKey:@"list"];
    for(NSDictionary *dict in dataArray)
    {
        
        newsinfoItem.newsContent  = [dict objectForKey:@"ncontent"];
        newsinfoItem.newsID = [dict objectForKey:@"nid"];
        newsinfoItem.newsTypeID = [dict objectForKey:@"tid"];
        newsinfoItem.newsTitle = [dict objectForKey:@"ntitle"];
        NSLog(@"nsdic======%@",newsinfoItem.newsTitle);
        
        newsinfoItem.NewsTime = [dict objectForKey:@"ntime"];
        newsinfoItem.newsSummary = [dict objectForKey:@"nsummary"];
        if (newsinfoItem.newsSummary == nil) {
            newsinfoItem.newsSummary = @" ";
        }
        newsinfoItem.newsPicture = [dict objectForKey:@"purl"];
        newsinfoItem.newsUlr = [dict objectForKey:@"nurl"];
        newsinfoItem.newsAuthor =@" ";
        
        [allNewsDao insertAllNews:newsinfoItem];
    }
    }

}



/*********************************************************************
 *  @author LQC
 *
 *  get消息操作
 **********************************************************************/

//-(NSMutableArray *)getCyclePicture
//{
//    
//}


//-(NSMutableArray *)getNewsByAuthor
//{
//    
//}
//
//-(NSMutableArray *)getRefreshNewsByLastID
//{
//    
//}
//
//-(NSMutableArray *)getRefreshNewsByLastTime
//{
//    
//}
//
//-(NSMutableArray *)getRefreshLatestNewsByDown
//{
//    
//}
//
//-(NSMutableArray *)getRefreshLatestNewsByUp
//{
//    
//}
//




@end
