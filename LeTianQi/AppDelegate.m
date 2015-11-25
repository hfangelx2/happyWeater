//
//  AppDelegate.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/8.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "AppDelegate.h"
#import "AMapSearchAPI.h"
#import "RootViewController.h"
#import "FinderViewController.h"
#import "MineViewController.h"
#import "WeatherListViewController.h"
#import <MMDrawerController.h>
#import "MMNavigationController.h"
#import "UMSocial.h"

@interface AppDelegate ()<AMapSearchDelegate, UITabBarControllerDelegate>
@property (nonatomic,strong) MMDrawerController * drawerController;
@property (nonatomic, strong) UITabBarController *tabBar;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIViewController *left = [[WeatherListViewController alloc] init];
    UIViewController *center = [[RootViewController alloc] init];
    
    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:center];
    navigationController.navigationBarHidden = YES;
    [navigationController setRestorationIdentifier:@"centerer"];
    UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:left];
    [leftSideNavController setRestorationIdentifier:@"lefter"];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navigationController leftDrawerViewController:leftSideNavController];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
//    [self.drawerController setMaximumRightDrawerWidth:300];
    [self.drawerController setMaximumLeftDrawerWidth:[UIScreen mainScreen].bounds.size.width - 60];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    [self.window setTintColor:tintColor];
//    [self.window setRootViewController:self.drawerController];
    
    return YES;
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    NSString *key = [identifierComponents lastObject];
    if([key isEqualToString:@"MMDrawer"]){
        return self.window.rootViewController;
    }
    else if ([key isEqualToString:@"centerer"]) {
        return ((MMDrawerController *)self.window.rootViewController).centerViewController;
    }
    else if ([key isEqualToString:@"lefter"]) {
        return ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
    }
    else if ([key isEqualToString:@"left"]){
        UIViewController * leftVC = ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
        if([leftVC isKindOfClass:[UINavigationController class]]){
            return [(UINavigationController*)leftVC topViewController];
        }
        else {
            return leftVC;
        }
        
    }
    return nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [UMSocialData setAppKey:@"558393cf67e58e75ed001670"];
    UINavigationController *navi_1 = [[UINavigationController alloc] initWithRootViewController:self.drawerController];
    navi_1.navigationBarHidden = YES;
    UIImage *weather = [[UIImage imageNamed:@"weather"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *weather_tap = [UIImage imageNamed:@"weather_tap"];
    self.drawerController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"天气" image:weather selectedImage:weather_tap];
//    FinderViewController *Finder = [[FinderViewController alloc] init];
//    UINavigationController *navi_2 = [[UINavigationController alloc] initWithRootViewController:Finder];
//    navi_2.navigationBarHidden = YES;
//    UIImage *find = [[UIImage imageNamed:@"finder"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage *find_tap = [UIImage imageNamed:@"finder_tap"];
//    Finder.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:find selectedImage:find_tap];
    
//    MineViewController *Mine = [[MineViewController alloc] init];
//    UINavigationController *navi_3 = [[UINavigationController alloc] initWithRootViewController:Mine];
//    navi_3.navigationBarHidden = YES;
//    UIImage *me = [[UIImage imageNamed:@"mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage *me_tap = [UIImage imageNamed:@"mine_tap"];
//    Mine.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:me selectedImage:me_tap];
    
    self.tabBar = [[UITabBarController alloc] init];
    self.tabBar.viewControllers = @[navi_1];
    self.tabBar.delegate = self;
    [self.tabBar.tabBar setBarTintColor:[UIColor colorWithRed:20 / 255.0 green:20 / 255.0 blue:20 / 255.0 alpha:0.2]];
//    tabBar.tabBar.translucent = NO;
    self.window.rootViewController = self.tabBar;
    
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.LTXZ.LeTianQi" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LeTianQi" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LeTianQi.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
