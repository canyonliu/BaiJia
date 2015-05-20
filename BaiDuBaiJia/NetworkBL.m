//
//  NetworkBL.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "NetworkBL.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "ASIFormDataRequest.h"



#define serverHost @"http://121.41.118.163:8080/"

@implementation NetworkBL


-(NSData *)getAllNewsAuthor
{
    NSString *getAuthorURL = [[NSString alloc]init];
    NSString *str = @"/author/selectAllOfAuthor";
    //NSString *str2 = [NSString stringWithFormat:@"%@%@",serverHost,str1];
    getAuthorURL = [serverHost stringByAppendingString:str];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getAuthorURL]];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    
    [request startSynchronous];//use 同步请求
    //NSError *error = [request error];
    
    NSData *responseData = [request responseData];
    NSLog(@"请求回来的所有的作者数据===%@",responseData);
    
    return responseData;
}

-(NSData *)getAllNewsType
{
    NSString *getAuthorURL = [[NSString alloc]init];
    NSString *str = @"/type/selectAllOfType";
    //NSString *str2 = [NSString stringWithFormat:@"%@%@",serverHost,str1];
    getAuthorURL = [serverHost stringByAppendingString:str];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getAuthorURL]];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    
    [request startSynchronous];//use 同步请求
    //NSError *error = [request error];
    
    NSData *responseData = [request responseData];
    NSLog(@"请求回来的所有的类型数据===%@",responseData);
    
    return responseData;
}



-(NSData *)getNewsByTypeWithCurrentPage:(NSString *)page andNewsCount:(NSString *)number andTypeID:(NSString *)typeID
{
    NSString *getAuthorURL = [[NSString alloc]init];
    NSString *str = @"/new/selectByTypeOfNew";
    //NSString *str2 = [NSString stringWithFormat:@"%@%@",serverHost,str1];
    getAuthorURL = [serverHost stringByAppendingString:str];
    
    ASIFormDataRequest *requestForm1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getAuthorURL]];
     [requestForm1 setPostValue:page forKey:@"page"];
     [requestForm1 setPostValue:number forKey:@"num"];
     [requestForm1 setPostValue:typeID forKey:@"tid"];
    
    
    [requestForm1 setDownloadCache:[ASIDownloadCache sharedCache]];
    
    [requestForm1 startSynchronous];//use 同步请求
    //NSError *error = [request error];
    
    [requestForm1 setDelegate:self];
    [requestForm1 setAllowCompressedResponse:YES];
    [requestForm1 startSynchronous];
    
    NSData *responseData = [requestForm1 responseData];
    NSLog(@"请求回来的根据类型查询数据===%@",responseData);
    
    return responseData;

}

-(NSData *)getNewsByAuthorWithCurrentPage:(NSString *)page andNewsCount:(NSString *)number andAuthorID:(NSString *)authorID
{
    NSString *getAuthorURL = [[NSString alloc]init];
    NSString *str = @"/new/selectByAuthorOfNew";
    //NSString *str2 = [NSString stringWithFormat:@"%@%@",serverHost,str1];
    getAuthorURL = [serverHost stringByAppendingString:str];
    
    ASIFormDataRequest *requestForm1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getAuthorURL]];
    [requestForm1 setPostValue:page forKey:@"page"];
    [requestForm1 setPostValue:number forKey:@"num"];
    [requestForm1 setPostValue:authorID forKey:@"aid"];
    
    
    [requestForm1 setDownloadCache:[ASIDownloadCache sharedCache]];
    
    [requestForm1 startSynchronous];//use 同步请求
    //NSError *error = [request error];
    
    [requestForm1 setDelegate:self];
    [requestForm1 setAllowCompressedResponse:YES];
    [requestForm1 startSynchronous];
    
    NSData *responseData = [requestForm1 responseData];
    NSLog(@"请求回来的根据作者查询数据===%@",responseData);
    
    return responseData;
}




//新接口,一个接口暂时满足所有需求

-(NSData *)getLatestRefreshNewsWithPage:(NSString *)page andNewsCount:(NSString *)number andRefreshTypy:(NSString *)refreshType andLastID:(NSString *)lastID andLastTime:(NSString *)lastTime andTypeid:(NSString *)tid andAuthorid:(NSString *)aid
{
    
    //NSLog(@"什么过===");
    NSString *getAuthorURL = [[NSString alloc]init];
    NSString *str = @"newx/new/selectAllOfNew";
    //NSString *str2 = [NSString stringWithFormat:@"%@%@",serverHost,str1];
    getAuthorURL = [serverHost stringByAppendingString:str];
    
    ASIFormDataRequest *requestForm1 = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:getAuthorURL]];
    [requestForm1 setPostValue:page   forKey:@"page"];
    [requestForm1 setPostValue:number forKey:@"num"];
    [requestForm1 setPostValue:aid forKey:@"aid"];
    [requestForm1 setPostValue:tid forKey:@"tid"];
    [requestForm1 setPostValue:page forKey:@"page"];
    [requestForm1 setPostValue:refreshType forKey:@"refresh_type"];
    [requestForm1 setPostValue:lastID forKey:@"Last_id"];
    [requestForm1 setPostValue:lastTime forKey:@"Last_time"];
   
    
    
    [requestForm1 setDownloadCache:[ASIDownloadCache sharedCache]];
    
    [requestForm1 startSynchronous];//use 同步请求
    //NSError *error = [request error];
    
    [requestForm1 setDelegate:self];
    [requestForm1 setAllowCompressedResponse:YES];
    [requestForm1 startSynchronous];
    
    NSData *responseData = [requestForm1 responseData];
    NSString *aString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"请求回来的最新的下拉数据===%@",responseData);
    NSLog(@"请求回来的最新的下拉数据 的 string=====%@",aString);
    
    return responseData;
}




@end
