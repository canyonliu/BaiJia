//
//  NewsDetailViewController.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/28.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialScreenShoter.h"
#import "UMSocialShakeService.h"

@interface NewsDetailViewController : UIViewController




@property (weak, nonatomic)    NSString *arr_content ;
@property (weak, nonatomic)    NSString *arr_time;
@property (weak, nonatomic)    NSString *arr_picture;
@property (weak, nonatomic)    NSString *arr_title;
@property (weak, nonatomic)    NSString *arr_url;


/**
 设置响应摇一摇事件，并且弹出分享页面
 
 @param snsTypes 要分享的平台类型名，例如@[UMShareToSina,UMShareToTencent,UMShareToWechatSession]
 @param shareText 分享内嵌文字
 @param screenShoter 摇一摇分享用到的截屏对象
 @param controller  出现分享界面所在的ViewController
 @param delegate 实现摇一摇后，或者分享完成后的回调对象，如果不处理这些事件，可以设置为nil
 */
+(void)setShakeToShareWithTypes:(NSArray *)snsTypes
                      shareText:(NSString *)shareText
                   screenShoter:(UMSocialScreenShoter *)screenShoter
               inViewController:(UIViewController *)controller
                       delegate:(id<UMSocialShakeDelegate>)delegate;

@end
