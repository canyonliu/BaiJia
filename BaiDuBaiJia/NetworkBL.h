//
//  NetworkBL.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkBL : NSObject

/**
 *  @author LQC
 *
 *  获得下拉查询条数的新闻
 *
 *  @param page   当前页
 *  @param number 每页个数
 *
 *  @return json
 */
-(NSData *)getLatestRefreshNewsWithPage:(NSString *)page andNewsCount:(NSString *)number;

/**
 *  @author LQC
 *
 *  根据作者查询新闻
 *
 *  @param page     当前页
 *  @param number   每页个数
 *  @param authorID 作者ID
 *
 *  @return json
 */
-(NSData *)getNewsByAuthorWithCurrentPage:(NSString *)page andNewsCount:(NSString *)number andAuthorID:(NSString *)authorID;

/**
 *  @author LQC
 *
 *  根据新闻类型查询新闻
 *
 *  @param page     当前页
 *  @param number   每页个数
 *  @param typeID   类型ID
 *
 *  @return json
 */
-(NSData *)getNewsByTypeWithCurrentPage:(NSString *)page andNewsCount:(NSString *)number andTypeID:(NSString *)typeID;

/**
 *  @author LQC
 *
 *  查询全部的类型
 *
 *  @return json
 */
-(NSData *)getAllNewsType;

/**
 *  @author LQC
 *
 *  查询全部的作者
 *
 *  @return json
 */
-(NSData *)getAllNewsAuthor;



/**
 *  @author LQC
 *
 *  总得接口
 *
*/
-(NSData *)getLatestRefreshNewsWithPage:(NSString *)page andNewsCount:(NSString *)number andRefreshTypy:(NSString *)refreshType andLastID:(NSString *)lastID andLastTime:(NSString *)lastTime andTypeid:(NSString *)tid andAuthorid:(NSString *)aid;


@end
