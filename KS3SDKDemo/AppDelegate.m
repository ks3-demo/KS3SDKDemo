//
//  AppDelegate.m
//  KS3SDKDemo-Token
//
//  Created by JackWong on 15/4/28.
//  Copyright (c) 2015年 Jack Wong. All rights reserved.
//


#import "AppDelegate.h"
#import <KS3YunSDK.h>
#warning AK/SK Setting
// **** 设置用户的AK/SK以获取token，用于模拟从app服务器端获取token，真实使用场景为，app服务器返回token
NSString * const strAccessKey = @"";
NSString * const strSecretKey = @"";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        [[KS3Client initialize] setBucketDomainWithRegion:KS3BucketShanghai];

    //使用接口生成签名 上传文件 ObjectViewController->singleUploadByAppServer
    //使用绑定bucket的自定义域名可以通过下面这行设置endpoint
    //[[KS3Client initialize] setBucketDomain:@"www.abc.com"];
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
