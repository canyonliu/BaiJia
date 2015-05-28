//
//  ChannelDetailTableViewController.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelDetailTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic ,strong)NSString *channelName;

@property (weak, nonatomic) IBOutlet UILabel *Title;
- (IBAction)DismissViewController;
@property (weak, nonatomic) IBOutlet UITableView *myTablewView;

@end
