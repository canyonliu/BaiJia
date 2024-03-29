//
//  NewsInfo.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/7.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsInfo : NSObject
@property(nonatomic , strong) NSString *newsTypeID;
@property(nonatomic , strong) NSString *newsTitle;
@property(nonatomic , strong) NSString *newsTime;
@property(nonatomic , strong) NSString *newsUlr;
@property(nonatomic , strong) NSString *newsAuthor;
@property(nonatomic , strong) NSString *newsPicture;
@property(nonatomic , strong) NSString *newsSummary;//简介

@property(nonatomic , strong)NSString *newsContent;

@property(nonatomic , strong)NSString *newsID;



@end
