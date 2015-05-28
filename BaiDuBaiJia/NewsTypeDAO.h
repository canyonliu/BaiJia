//
//  NewsTypeDAO.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/26.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsInfo.h"

@interface NewsTypeDAO : NSObject
+(NewsTypeDAO *)shareManager;

-(NSString *)applicationDocumentsDirectoryFile;

-(void)createEditableCopyOfDatabaseIfNeeded;

//-(void)insertAllNews:(NewsInfo *)model;
//-(NSMutableArray *) findNewsInfo;
//-(void)removeAllNews;

//后续
-(void)insertNews:(NSArray *)model andChannel:(NSString *)channel;
- (NSMutableArray *) findNewsInfo:(NSString *)channelID;
//- (void)removeNewsWithChannelID:(NSString *)channelID;



@end
