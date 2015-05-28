//
//  AllNewsDAO.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "AllNewsDAO.h"


@implementation AllNewsDAO

static AllNewsDAO *shareManager = nil;
+(AllNewsDAO *)shareManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareManager = [[self alloc]init];
        [shareManager createEditableCopyOfDatabaseIfNeeded];
    });
    return  shareManager;
}

-(NSString *)applicationDocumentsDirectoryFile
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"allnewsinfo.plist"];
    return path;
}


-(void)createEditableCopyOfDatabaseIfNeeded
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [self applicationDocumentsDirectoryFile];
    BOOL plistExist = [fileManager fileExistsAtPath:plistPath];
    
    if(!plistExist)
    {
        NSArray *array = [NSArray new];
        [array writeToFile:plistPath atomically:YES];
    }
}

-(void)insertAllNews:(NewsInfo *)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:path];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[model.newsAuthor,model.newsID,model.newsTypeID,model.newsPicture,model.newsSummary,model.newsTime,model.newsTitle,model.newsUlr,model.newsContent] forKeys:@[@"News_Author",@"News_ID",@"News_TypeID",@"News_Pictrue",@"News_Summary",@"News_Time",@"News_Title",@"News_URL",@"News_Content"]];
    [array addObject:dict];
    [array writeToFile:path atomically:YES];
                          
}

-(NSMutableArray *)findNewsInfo
{
    NSMutableArray *showArray = [NSMutableArray new];
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:[self applicationDocumentsDirectoryFile]];
    
    for(NSDictionary *dict in array)
    {
        if([dict objectForKey:@"News_Title"])
        {
            NewsInfo *newsItem = [NewsInfo new];
            newsItem.newsAuthor = [dict objectForKey:@"News_Author"];
            newsItem.newsTypeID =[dict objectForKey:@"News_TypeID"];
            newsItem.newsPicture =[dict objectForKey:@"News_Pictrue"];
            newsItem.newsSummary =[dict objectForKey:@"News_Summary"];
            newsItem.NewsTime =[dict objectForKey:@"News_Time"];
            newsItem.newsTitle =[dict objectForKey:@"News_Title"];
            newsItem.newsUlr =[dict objectForKey:@"News_URL"];
            newsItem.newsContent = [dict objectForKey:@"News_Content"];
            
            [showArray addObject:newsItem];
        }
    }
    
    return showArray;
    
    
}




-(void)removeAllNews
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    NSArray *array = [NSArray new];
    
    [array writeToFile:path atomically:YES];
}




@end
