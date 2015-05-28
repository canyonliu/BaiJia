//
//  BJLeftViewController.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/5/1.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "BJLeftViewController.h"
#import "LeftViewCell.h"
#import "ChannelDetailTableViewController.h"

@interface BJLeftViewController ()

@property (nonatomic ,strong)NSMutableArray *itemArray;

@end

@implementation BJLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemArray = [NSMutableArray arrayWithObjects:@"互联网",@"热点",@"文化",@"娱乐",@"体育",@"财经", nil];
    //self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeftViewCell *cell;
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LeftViewCell" owner:nil options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.itemImageView.image = [UIImage imageNamed:@"item"];
    cell.itemName.text = [_itemArray objectAtIndex:indexPath.row];
    

    return cell;
}

//跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *channelname = [_itemArray objectAtIndex:[indexPath row]];
    ChannelDetailTableViewController *channelDetailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"channelDetailVC"];
    
    channelDetailVC.channelName = channelname;
    
    [self presentViewController:channelDetailVC animated:YES completion:nil];
}

@end
