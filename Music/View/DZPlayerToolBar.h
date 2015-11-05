//
//  DZPlayerToolBar.h
//  Music
//
//  Created by dengwei on 15/9/27.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    BtnTypePlay, //播放
    BtnTypePause, //暂停
    BtnTypePrevious, //上一首
    BtnTypeNext //下一首
}BtnType;

@class DZMusic,DZPlayerToolBar;

@protocol DZPlayerToolBarDelegate <NSObject>

-(void)playerToolBar:(DZPlayerToolBar *)toolBar btnClickWithType:(BtnType) btnType;

@end

@interface DZPlayerToolBar : UIView

/**
 *  播放状态,默认是暂停状态
 */
@property (nonatomic, assign,getter=isPlaying) BOOL playing;

/**
 *  当前播放的音乐
 */
@property (nonatomic, strong) DZMusic *playingMusic;

@property (nonatomic, weak) id<DZPlayerToolBarDelegate> delegate;

+(instancetype)playerToolBar;

@end
