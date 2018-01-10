//
//  AppDelegate.m
//  Doksugongbang
//
//  Created by USER on 2017. 12. 28..
//  Copyright © 2017년 USER. All rights reserved.
//

#import "AppDelegate.h"

#import "DGBBookCoverCollectionViewController.h"
#import "DGBSearchViewController.h"
#import "DGBFeedViewController.h"
#import "DGBBookLogListViewController.h"
#import "DGBUserInfoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    DGBBookCoverCollectionViewController *bookCoverCollectionViewController = [[DGBBookCoverCollectionViewController alloc] init];
    DGBSearchViewController *searchViewController = [[DGBSearchViewController alloc] init];
    DGBFeedViewController *feedViewController = [[DGBFeedViewController alloc] init];
    DGBBookLogListViewController *bookLogListViewController = [[DGBBookLogListViewController alloc] init];
    DGBUserInfoViewController *userInfoViewController = [[DGBUserInfoViewController alloc] init];
    
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:bookCoverCollectionViewController];
    UINavigationController *searchNavigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    UINavigationController *feedNavigationController = [[UINavigationController alloc] initWithRootViewController:feedViewController];
    UINavigationController *bookLogNavigationController = [[UINavigationController alloc] initWithRootViewController:bookLogListViewController];
    UINavigationController *userInfoNavigationController = [[UINavigationController alloc] initWithRootViewController:userInfoViewController];
    
    [homeNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"홈 화면"
                                                                          image:[UIImage imageNamed:@"HomeIcon"]
                                                                            tag:0]];
    [searchNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"검색"
                                                                            image:[UIImage imageNamed:@"SearchIcon"]
                                                                              tag:1]];
    [feedNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"피드"
                                                                          image:[UIImage imageNamed:@"FeedIcon"]
                                                                            tag:2]];
    [bookLogNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"북 로그"
                                                                             image:[UIImage imageNamed:@"LogIcon"]
                                                                               tag:3]];
    [userInfoNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"내 정보"
                                                                              image:[UIImage imageNamed:@"UserIcon"]
                                                                                tag:4]];
    
    [tabBarController setViewControllers:@[homeNavigationController,
                                           searchNavigationController,
                                           feedNavigationController,
                                           bookLogNavigationController,
                                           userInfoNavigationController]];
    
    [self.window setRootViewController:tabBarController];
    
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
