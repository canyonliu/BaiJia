//
//  NewsDetailToolBar.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/28.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    NewsDetailToolBarButtonTagBack,//返回按钮
    NewsDetailToolBarButtonTagShare,//分享按钮
    NewsDetailToolBarButtonTagStore,//收藏按钮
    NewsDetailToolBarButtonTagPraise//点赞按钮
}NewsDetailToolBarButtonTag;


@class NewsDetailToolBar;
@protocol NewsDetailToolBarDelegate <NSObject>


@optional

/**
 *  @author LQC
 *
 *  判断是哪一个按钮被点击了
 *
 *  @param detailToolBar 当前对象
 *  @param tag           tag值
 */
-(void)detailToolBar:(NewsDetailToolBar *)detailToolBar didButtonClick:(NewsDetailToolBarButtonTag)tag;


@end


@interface NewsDetailToolBar : UIView

@property(nonatomic, weak)id <NewsDetailToolBarDelegate>delegate;

@end
