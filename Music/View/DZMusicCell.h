//
//  DZMusicCell.h
//  Music
//
//  Created by dengwei on 15/9/27.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZMusic;
@interface DZMusicCell : UITableViewCell

+(instancetype)musicCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DZMusic *music;
@end
