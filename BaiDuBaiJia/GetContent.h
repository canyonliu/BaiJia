//
//  GetContent.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/28.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetContent : NSObject


+(NSMutableArray *)getTypeNewsFromDatabase:(NSString *)channelID;

+(NSMutableArray *)getAllNewsFromDatabase;

@end
