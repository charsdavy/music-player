//
//  DZAboutViewController.m
//  Music
//
//  Created by dengwei on 16/1/2.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZAboutViewController.h"

@interface DZAboutViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation DZAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self fillContent];
}

-(void)setupUI
{
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    textView.backgroundColor = [UIColor whiteColor];
    self.title = @"About";
    textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"aboutBackground"]];
    [self.view addSubview:textView];
    self.textView = textView;
}

-(void)fillContent
{
    self.textView.text = @"\t音乐播放器\n\t实现本地音乐播放，具有后台操作功能。\n\n\n代码地址：https://github.com/charsdavy/music-player\n联系方式：chars_d@126.com\n软件作者：dengwei";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
