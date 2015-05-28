//
//  ViewController.h
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "ServerInterface.h"
#import "MBProgressHUD.h"

@interface ViewController : UIViewController
{
    MBProgressHUD *hud;
    ServerInterface *_server;
}

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *TableView;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView;


@end

