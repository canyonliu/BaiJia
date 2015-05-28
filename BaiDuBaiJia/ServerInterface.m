//
//  ServerInterface.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/26.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "ServerInterface.h"
#import "NewsTypeDAO.h"
#import "AllNewsDAO.h"



@implementation ServerInterface
{
    NetworkBL *_network;
    NewsParserBL *_parser;
}


-(instancetype)init
{
    self = [super init];
    if(self)
    {
        _network = [NetworkBL new];
        _parser = [NewsParserBL new];
    }
    return  self;
}




-(void)getNewsByType:(NSString *)typeID andRefreshType:(NSString *)refreshType
{
    //NSMutableArray *data = [[NSMutableArray alloc]init];
    NSData *data = [[NSData alloc]init];
    data = [_network getLatestRefreshNewsWithPage:@"1" andNewsCount:@"50" andRefreshTypy:refreshType andLastID:nil andLastTime:nil andTypeid:typeID andAuthorid:@"-1"];
    [_parser saveAllNewsByType:data andChannel:typeID];
    
    
}


-(void)getAllNews_WithRefreshType:(NSString *)refreshType andNewsID:(NSString *)newsID
{
    NSData *data = [[NSData alloc]init];
    data = [_network getLatestRefreshNewsWithPage:@"1" andNewsCount:@"10" andRefreshTypy:refreshType andLastID:nil andLastTime:newsID andTypeid:@"-1" andAuthorid:@"-1"];
    
    [_parser saveAllNews:data];
}


-(void)deleteNewslistInMianView
{
    AllNewsDAO *allnewsDao = [AllNewsDAO shareManager];
    [allnewsDao removeAllNews];
}


-(void)deleteNewslistInTypeDetailView:(NSString *)channelID
{
    NewsTypeDAO *newsTypeDao = [NewsTypeDAO shareManager];
    //[newsTypeDao removeNewsWithChannelID:channelID];
}


@end
