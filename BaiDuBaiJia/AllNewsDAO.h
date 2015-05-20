//
//  AllNewsDAO.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsInfo.h"

@interface AllNewsDAO : NSObject
+(AllNewsDAO *)shareManager;

-(NSString *)applicationDocumentsDirectoryFile;

-(void)createEditableCopyOfDatabaseIfNeeded;

-(void)insertAllNews:(NewsInfo *)model;

-(NSMutableArray *) findNewsInfo;

-(void)removeAllNews;


@end
