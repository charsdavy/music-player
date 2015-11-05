//
//  DZPlayerToolBar.m
//  Music
//
//  Created by dengwei on 15/9/27.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DZPlayerToolBar.h"
#import "UIButton+CZ.h"
#import "DZMusic.h"
#import "UIImage+CZ.h"
#import "DZMusicTool.h"
#import "NSString+CZ.h"

@interface DZPlayerToolBar ()

/**
 *  歌手头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *singerImageView;
/**
 *  歌曲的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
/**
 *  歌手的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;

@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
/**
 *  歌曲总时间
 */
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
/**
 *  歌曲当前播放的时间
 */
@property (weak, nonatomic) IBOutlet UILabel *curentTimeLabel;

/**
 *  定时器
 */
@property (nonatomic, strong) CADisplayLink *link;

/**
 *  是否正在拖拽(默认不拖拽)
 */
@property (nonatomic, assign, getter=isDragging) BOOL dragging;

@end

@implementation DZPlayerToolBar

-(CADisplayLink *)link
{
    if (_link == nil) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(upadte)];
    }
    return _link;
}

#pragma mark 定时器操作方法
-(void)upadte
{
    //正在播放音乐才需要做之后的操作
    if (self.isPlaying && self.isDragging == NO) {
        //1.更新进度条
        double currentTime = [DZMusicTool sharedDZMusicTool].player.currentTime;
        self.timeSlider.value = currentTime;
        //2.更新时间
        self.curentTimeLabel.text = [NSString getMinuteSecondWithSecond:currentTime];
        //3.头像转动
        CGFloat angle = M_PI_4 / 60;
        self.singerImageView.transform = CGAffineTransformRotate(self.singerImageView.transform, angle);
    }
    
}

+(instancetype)playerToolBar
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DZPlayerToolBar" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    //设置slider按钮图片
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"playbar_slider_thumb"] forState:UIControlStateNormal];
    
    //开启定时器
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)dealloc
{
    //移除定时器
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark 设置当前播放的音乐,并显示数据
-(void)setPlayingMusic:(DZMusic *)playingMusic{
    _playingMusic = playingMusic;
    
    //歌手头像(圆形有边框)
    UIImage *circleImage = [UIImage circleImageWithName:playingMusic.singerIcon borderWidth:1.0 borderColor:[UIColor yellowColor]];
    self.singerImageView.image = circleImage;
    //歌曲名
    self.musicNameLabel.text = playingMusic.name;
    //歌手名
    self.singerNameLabel.text = playingMusic.singer;
    //歌曲总时间
    double duration = [DZMusicTool sharedDZMusicTool].player.duration;
    self.totalTimeLabel.text = [NSString getMinuteSecondWithSecond:duration];
    //设置slider的最大值
    self.timeSlider.maximumValue = duration;
    //重置slider的播放时间
    self.timeSlider.value = 0;
    //头像复位
    self.singerImageView.transform = CGAffineTransformIdentity;
    
}

#pragma mark 播放
- (IBAction)playBtnClick:(UIButton *)btn {
    //更改播放状态
    self.playing = !self.playing;
    //判断按钮的播放状态,更改图片
    if (self.playing) {//播放音乐
        //1.如果当前为播放状态,按钮的图片更改为暂停的状态
        [btn setNBg:@"playbar_pausebtn_nomal" hBg:@"playbar_pausebtn_click"];
        
        [self notifyDelegateWithBtnType:BtnTypePlay];
    }else{//暂停音乐
        //2.如果当前为暂停状态,按钮的图片更改为播放的状态
        [btn setNBg:@"playbar_playbtn_nomal" hBg:@"playbar_playbtn_click"];
        
        [self notifyDelegateWithBtnType:BtnTypePause];
    }
    
}

#pragma mark 上一首
- (IBAction)previousBtnClick:(id)sender {
    [self notifyDelegateWithBtnType:BtnTypePrevious];
    //复原歌手头像位置
    self.singerImageView.transform = CGAffineTransformIdentity;
}

#pragma mark 下一首
- (IBAction)nextBtnClick:(id)sender {
    [self notifyDelegateWithBtnType:BtnTypeNext];
    //复原歌手头像位置
    self.singerImageView.transform = CGAffineTransformIdentity;
}

#pragma mark slider拖动
- (IBAction)sliderChange:(UISlider *)sender {
    //1.播放器的进度
    [DZMusicTool sharedDZMusicTool].player.currentTime = sender.value;
    //2.工具条的时间
    self.curentTimeLabel.text = [NSString getMinuteSecondWithSecond:sender.value];
}

#pragma mark 点击slider的时候暂停播放
- (IBAction)stopPlay:(UISlider *)sender {
    //更改拖拽状态
    self.dragging = YES;
    
    [[DZMusicTool sharedDZMusicTool] pause];
}

#pragma mark slider松开手指继续播放
- (IBAction)replay:(UISlider *)sender {
    //更改拖拽状态
    self.dragging = NO;
    
    if (self.isPlaying) {
        [[DZMusicTool sharedDZMusicTool] play];
    }
}

#pragma mark 通知代理
-(void)notifyDelegateWithBtnType:(BtnType)btnType
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(playerToolBar:btnClickWithType:)]) {
        [self.delegate playerToolBar:self btnClickWithType:btnType];
    }
}

@end
