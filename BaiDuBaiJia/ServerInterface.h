//
//  ServerInterface.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/26.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkBL.h"
#import "NewsParserBL.h"

@interface ServerInterface : NSObject




/**
 *  @author LQC
 *
 *  获得各频道的信息
 *
 *  @param typeID      频道ID
 *  @param refreshType 刷新类型
 */
-(void)getNewsByType:(NSString *)typeID andRefreshType:(NSString *)refreshType;


/**
 *  @author LQC
 *
 *  获得全部信息
 *
 *  @param refreshType 刷新类型
 */
-(void)getAllNews_WithRefreshType:(NSString *)refreshType andNewsID:(NSString *)newsID;


-(void)deleteNewslistInMianView;

-(void)deleteNewslistInTypeDetailView:(NSString *)channelID;

@end
