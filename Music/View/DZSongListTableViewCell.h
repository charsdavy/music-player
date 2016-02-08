//
//  DZSongListTableViewCell.h
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "StyledTableViewCell.h"

@class DZSongList;
@interface DZSongListTableViewCell : StyledTableViewCell
{
    UILabel * nameLabel;
    UILabel * titleLabel;
    UILabel * timeLabel;
}

@property (nonatomic,strong) DZSongList *songListModel;

@end
