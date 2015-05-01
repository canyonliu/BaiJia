//
//  AppDelegate.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "AppDelegate.h"
#import "XTSideMenu.h"
//#import "BJCenterViewController.h"
#import "ViewController.h"
#import "BJLeftViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //BJCenterViewController *centerVC = [[BJCenterViewController alloc]initWithNibName:@"BJCenterViewController" bundle:nil];
    ViewController *centerVC =  [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"centerVC"];//[[ViewController alloc]init];
    
    BJLeftViewController *leftVC =//[[BJLeftViewController alloc]init];
    [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"leftVC1"];;
    XTSideMenu *root = [[XTSideMenu alloc]initWithContentViewController:centerVC leftMenuViewController:leftVC rightMenuViewController:nil];
    
//    UINavigationController *navVC = [[UINavigationController alloc]init];
//    [navVC pushViewController:root animated:YES];
//    navVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"1233" style:UIBarButtonItemStyleDone target:self action:nil];
//    navVC.title =@"百度百家";
    
    
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
