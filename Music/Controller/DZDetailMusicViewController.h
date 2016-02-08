//
//  DZDetailMusicViewController.h
//  Music
//
//  Created by dengwei on 16/1/3.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZSinger;

@interface DZDetailMusicViewController : UIViewController
{
    UITableView * _tableView;
}

@property (nonatomic,strong) DZSinger *singerModel;

@end
