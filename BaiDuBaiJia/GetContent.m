//
//  GetContent.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/28.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "GetContent.h"
#import "NewsTypeDAO.h"
#import "AllNewsDAO.h"
#import "NewsInfo.h"

@implementation GetContent

+(NSMutableArray *)getAllNewsFromDatabase
{
    AllNewsDAO *allDao = [AllNewsDAO shareManager];
    NSMutableArray *array = [allDao findNewsInfo];
    return array;
}


+(NSMutableArray *)getTypeNewsFromDatabase:(NSString *)channelID
{
    NewsTypeDAO *typeDao = [NewsTypeDAO shareManager];
    NSMutableArray *array = [typeDao findNewsInfo:channelID];
    return array;
}



@end
