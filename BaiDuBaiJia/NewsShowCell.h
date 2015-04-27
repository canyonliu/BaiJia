//
//  NewsShowCell.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsShowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *NewsInfo;
@property (weak, nonatomic) IBOutlet UILabel *Source;
@property (weak, nonatomic) IBOutlet UIImageView *NewsPic;

@end
