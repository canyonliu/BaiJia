//
//  NewsParserBL.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/7.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkBL.h"

@interface NewsParserBL : NSObject
{
    NetworkBL *_network;
}
/**
 *  @author LQC
 *
 *  保存轮播图片 plist1(每次进应用都重新请求,覆盖本地plist表)
 *  也可以不用建表,直接nsuserDefault来存应该也可以
 */
-(void)saveCyclePicture;
/**
 *  @author LQC
 *
 *  根据新闻类型保存新闻 plist2
 */
-(void)saveNewsByType:(NSString *)typeID andRefreshType:(NSString *)refreshType;
/**
 *  @author LQC
 *
 *  根据新闻作者保存新闻 plist3
 */

-(void)saveNewsByAuthor:(NSString *)authorID andRefreshType:(NSString *)refreshType;
/**
 *  @author LQC
 *
 *  根据本地plsit最后一条新闻的id保存 plist4
 */

-(void)saveRefreshNewsByLastID;
/**
 *  @author LQC
 *
 *  根据本地plsit最后一条新闻的更新时间保存 plist4
 */

-(void)saveRefreshNewsByLastTime;
/**
 *  @author LQC
 *
 *  通过向下拉请求最新的新闻 plist4
 */

-(void)saveRefreshLatestNewsByDown;
/**
 *  @author LQC
 *
 *  通过向上请求最新的新闻 plist4
 */
-(void)saveRefreshLatestNewsByUp;



-(NSMutableArray *)getCyclePicture;

-(NSMutableArray *)getNewsByType;

-(NSMutableArray *)getNewsByAuthor;

-(NSMutableArray *)getRefreshNewsByLastID;

-(NSMutableArray *)getRefreshNewsByLastTime;

-(NSMutableArray *)getRefreshLatestNewsByDown;

-(NSMutableArray *)getRefreshLatestNewsByUp;


@end
