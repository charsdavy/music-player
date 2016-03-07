//
//  AppDelegate.m
//  Music
//
//  Created by dengwei on 15/9/27.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "DZGlobal.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    DZGlobal *global = [DZGlobal sharedGlobal];
    [global copySqlitePath];
    global.isPlaying = YES;
    
    //设置音乐后台播放的会话类型
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error) {
        NSLog(@"%s %@", __func__, error);
    }
    [session setActive:YES error:nil];
    
    //开启远程事件(锁屏时使用)
    [application beginReceivingRemoteControlEvents];
    
    return YES;
}

#pragma mark 接收远程事件
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    //判断是否为远程事件
    if (event.type == UIEventTypeRemoteControl) {
        NSLog(@"receive remote event");
        //调用block
        self.myRemoteEventBlock(event);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //开启后台任务
    [application beginBackgroundTaskWithExpirationHandler:nil];
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
