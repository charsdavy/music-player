//
//  DZMusicPlayerViewController.m
//  Music
//
//  Created by dengwei on 15/9/27.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DZMusicPlayerViewController.h"
#import "DZPlayerToolBar.h"
#import "MJExtension.h"
#import "DZMusic.h"
#import "DZMusicCell.h"
#import "DZMusicTool.h"
#import "AppDelegate.h"

@interface DZMusicPlayerViewController ()<UITableViewDataSource, UITableViewDelegate,DZPlayerToolBarDelegate,AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  当前播放音乐的索引
 */
@property (nonatomic, assign) NSInteger musicIndex;

/**
 *  音乐数据
 */
@property (nonatomic, strong) NSArray *musics;

/**
 *  播放工具条
 */
@property (nonatomic, weak) DZPlayerToolBar *playerToolBar;

@end

@implementation DZMusicPlayerViewController

#pragma mark - 懒加载
-(NSArray *)musics
{
    if (_musics == nil) {
        _musics = [DZMusic objectArrayWithFilename:@"songs.plist"];
    }
    return _musics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加播放的工具条
    DZPlayerToolBar *toolBar = [DZPlayerToolBar playerToolBar];
    toolBar.delegate = self;
    //设置toolBar的尺寸
    toolBar.bounds = self.bottomView.bounds;
    [self.bottomView addSubview:toolBar];
    self.playerToolBar = toolBar;
    self.title = @"Music";
    
    //设置表格的透明度
    //self.tableView.alpha = 0.3;
    //设置表格的背景为透明
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    //初始化"音乐工具类"里的播放器
//    [[DZMusicTool sharedDZMusicTool] prepareToPlayWithMusic:self.musics[self.musicIndex]];
//    
//    //初始化播放的音乐(默认播放第一首)
//    toolBar.playingMusic = self.musics[self.musicIndex];
    [self playMusic];
    
    //设置appdelegate的block
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.myRemoteEventBlock = ^(UIEvent *event){
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [[DZMusicTool sharedDZMusicTool] play];
                break;
            case UIEventSubtypeRemoteControlPause:
                [[DZMusicTool sharedDZMusicTool] pause];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self previous];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                [self next];
                break;
                
            default:
                break;
        }
    };
}

#pragma mark - DZPlayerToolBarDelegate methods
-(void)playerToolBar:(DZPlayerToolBar *)toolBar btnClickWithType:(BtnType)btnType
{
    //实现播放,把播放功能操作放在一个工具类中
    switch (btnType) {
        case BtnTypePlay:
            [[DZMusicTool sharedDZMusicTool] play];
            NSLog(@"play");
            break;
        case BtnTypePause:
            [[DZMusicTool sharedDZMusicTool] pause];
            NSLog(@"pause");
            break;
        case BtnTypePrevious:
            [self previous];
            NSLog(@"pre");
            break;
        case BtnTypeNext:
            [self next];
            NSLog(@"next");
            break;
            
        default:
            break;
    }
}

//播放上一首
-(void)previous
{
    //1.更改播放音乐的索引
    if (self.musicIndex == 0) {
        self.musicIndex = self.musics.count - 1;
    }else{
        self.musicIndex--;
    }
    [self playMusic];
}

//播放下一首
-(void)next
{
    //1.更改播放音乐的索引
    if (self.musicIndex == self.musics.count - 1) {
        self.musicIndex = 0;
    }else{
        self.musicIndex++;
    }
    [self playMusic];
}

-(void)playMusic
{
    //2.重新初始化一个"播放器"
    [[DZMusicTool sharedDZMusicTool] prepareToPlayWithMusic:self.musics[self.musicIndex]];
    //设置player的代理
    [DZMusicTool sharedDZMusicTool].player.delegate = self;
    //3.更改"播放器工具条"的数据
    self.playerToolBar.playingMusic = self.musics[self.musicIndex];
    
    //4.播放
    if (self.playerToolBar.isPlaying) {
        [[DZMusicTool sharedDZMusicTool] play];
    }
}

#pragma mark - UITableViewDataSource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musics.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //自定义的cell
    DZMusicCell *cell = [DZMusicCell musicCellWithTableView:tableView];
    
    //设置数据
    DZMusic *music = self.musics[indexPath.row];
    cell.music = music;
    
    return cell;
}

#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //更改索引
    self.musicIndex = indexPath.row;
    //播放音乐
    [self playMusic];
}

#pragma mark - AVAudioPlayerDelegate methods
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //自动播放下一首
    [self next];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
