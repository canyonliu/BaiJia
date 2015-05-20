//
//  NewsParserBL.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/7.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "NewsParserBL.h"
#import "NewsInfo.h"

@implementation NewsParserBL


-(instancetype)init
{
    self = [super init];
    if(self)
    {
        _network = [NetworkBL new];
    }
    return  self;
}




-(void)saveCyclePicture
{
    
}


//1是向上获取最新,0是向下获取更多
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


-(void)saveRefreshLatestNewsByUp
{
    [_network getLatestRefreshNewsWithPage:@"" andNewsCount:@"10" andRefreshTypy:@"1"andLastID:@"" andLastTime:@"" andTypeid:@"" andAuthorid:@""];
    //直接往plist里面添加新的数据
}

-(void)saveRefreshLatestNewsByDown
{
     [_network getLatestRefreshNewsWithPage:@"" andNewsCount:@"10" andRefreshTypy:@"0"andLastID:@"" andLastTime:@"" andTypeid:@"" andAuthorid:@""];
    //更新操作   先删除plist里的数据
    //添加等待视图
}

@end
