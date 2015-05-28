//
//  NewsTypeDAO.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/26.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "NewsTypeDAO.h"

@interface NewsTypeDAO()

@property(nonatomic ,strong)NSMutableDictionary *finalDict;

@end

@implementation NewsTypeDAO


static NewsTypeDAO *shareManager = nil;


+(NewsTypeDAO *)shareManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareManager = [[self alloc]init];
        [shareManager createEditableCopyOfDatabaseIfNeeded];
    });
    return  shareManager;
}

-(id)init
{
    if(self = [super init])
    {
        NSString *path = [self applicationDocumentsDirectoryFile];
        NSMutableDictionary *finalDict = [[NSMutableDictionary alloc]init];
        [finalDict writeToFile:path atomically:YES];
        _finalDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];

    }
    return self;
}


-(NSString *)applicationDocumentsDirectoryFile
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"newstypeinfo.plist"];
   // NSLog(@"path === %@",path);
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

/*
-(void)insertAllNews:(NewsInfo *)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:path];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[model.newsAuthor,model.newsTypeID,model.newsPicture,model.newsSummary,model.NewsTime,model.newsTitle,model.newsUlr,model.newsContent] forKeys:@[@"News_Author",@"News_TypeID",@"News_Pictrue",@"News_Summary",@"News_Time",@"News_Title",@"News_URL",@"News_Content"]];
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
*/


//*****************************后续**************************************//
//
//


-(void)insertNews:(NSArray *)model andChannel:(NSString *)channel
{
    
    NSString *path = [self applicationDocumentsDirectoryFile];
//    //NSMutableDictionary *finalDict = [[NSMutableDictionary alloc]init];
//    //[_finalDict writeToFile:path atomically:YES];
//    _finalDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    //不需要remove 了直接在这里把那个对应频道的数据给清空(因为这里的莫名bug实在改不出来了)
//    NSArray *blankArray = [NSArray array];
//    
//    [_finalDict setObject:blankArray forKey:channel];
//    
//    [_finalDict writeToFile:path atomically:YES];
    //*************************************************************************//
   
    
    NSMutableArray *array_Dict = [NSMutableArray array];
    [_finalDict setObject:array_Dict forKey:channel];
   array_Dict = [_finalDict objectForKey:channel];
    
    
    NewsInfo *newsItem = [NewsInfo new];
    for(NSDictionary *dict in model)
    {
            newsItem.newsContent  = [dict objectForKey:@"ncontent"];
            newsItem.newsID = [dict objectForKey:@"nid"];
            newsItem.newsTypeID = [dict objectForKey:@"tid"];
            newsItem.newsTitle = [dict objectForKey:@"ntitle"];
            NSLog(@"nsdic======%@",newsItem.newsTitle);
            
            newsItem.newsTime = [dict objectForKey:@"ntime"];
            newsItem.newsSummary = [dict objectForKey:@"nsummary"];
            if (newsItem.newsSummary == nil) {
                newsItem.newsSummary = @" ";
            }
            newsItem.newsPicture = [dict objectForKey:@"purl"];
            newsItem.newsUlr = [dict objectForKey:@"nurl"];
            newsItem.newsAuthor =@" ";

            
        NSDictionary *dict1 = [NSDictionary dictionaryWithObjects:@[newsItem.newsAuthor,newsItem.newsID,newsItem.newsTypeID,newsItem.newsPicture,newsItem.newsSummary,newsItem.newsTime,newsItem.newsTitle,newsItem.newsUlr,newsItem.newsContent] forKeys:@[@"News_Author",@"News_ID",@"News_TypeID",@"News_Pictrue",@"News_Summary",@"News_Time",@"News_Title",@"News_URL",@"News_Content"]];
        
        [array_Dict addObject:dict1];
    }
    
    [_finalDict setObject:array_Dict forKey:channel];
    
    //    NSDictionary *dict =[NSDictionary dictionaryWithObject:array_Dict forKey:[NSString stringWithFormat:@"%d",NEWS_CHANNELID]];
    //
    //    [array addObject:dict];
    
    [_finalDict writeToFile:path atomically:YES];
    NSLog(@"NEWS_CHANNELIDbooonbooom======%@",channel);
}

- (NSMutableArray *) findNewsInfo:(NSString *)channelID
{
    NSMutableArray *showArray = [NSMutableArray new];
//    NSString *path = [self applicationDocumentsDirectoryFile];
//    
//    //NSMutableDictionary *finalDict = [[NSMutableDictionary alloc]init];
//    //[_finalDict writeToFile:path atomically:YES];
//    
//    _finalDict = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    
    NSArray *curChannelArray = [_finalDict objectForKey:channelID];
    
    for (NSDictionary *dict in curChannelArray) {
        if ([dict objectForKey:@"News_URL"]) {
            
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


- (void)removeNewsWithChannelID:(NSString *)channelID{
    
    NSString *path = [self applicationDocumentsDirectoryFile];
//    NSMutableDictionary *finalDict = [[NSMutableDictionary alloc]init];
//    [_finalDict writeToFile:path atomically:YES];
//   _finalDict = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    
    
    NSArray *blankArray = [NSArray array];
    
    [_finalDict setObject:blankArray forKey:channelID];
    
    [_finalDict writeToFile:path atomically:YES];
    
}





@end
