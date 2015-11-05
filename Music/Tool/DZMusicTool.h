//
//  DZMusicTool.h
//  Music
//
//  Created by dengwei on 15/9/27.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Singleton.h"

@class DZMusic;
@interface DZMusicTool : NSObject

singleton_interface(DZMusicTool)

/**
 *  播放器
 */
@property (nonatomic, strong) AVAudioPlayer *player;

/**
 *  音乐播放前的准备工作
 *
 */
-(void)prepareToPlayWithMusic:(DZMusic *)music;

/**
 *  播放音乐
 *
 */
-(void)play;

/**
 *  暂停音乐
 *
 */
-(void)pause;

@end
