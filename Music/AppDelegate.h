//
//  AppDelegate.h
//  Music
//
//  Created by dengwei on 15/9/27.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  播放远程事件block
 */
typedef void (^playerRemoteEventBlock)(UIEvent *event);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) playerRemoteEventBlock myRemoteEventBlock;

@end

