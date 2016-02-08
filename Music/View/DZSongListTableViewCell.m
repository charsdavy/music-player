//
//  DZSongListTableViewCell.m
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZSongListTableViewCell.h"
#import "UIView+Additions.h"
#import "DZSongList.h"

@implementation DZSongListTableViewCell

-(NSString*)TimeformatFromSeconds:(int)seconds{
    int totalm = seconds/(60);
    int h = totalm/(60);
    int m = totalm%(60);
    int s = seconds%(60);
    if (h==0) {
        return  [[NSString stringWithFormat:@"%02d:%02d", m, s] substringToIndex:5];
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
}

-(void)setSongListModel:(DZSongList *)songListModel {
    _songListModel = songListModel;
    nameLabel.text = _songListModel.title;
    timeLabel.text =[self TimeformatFromSeconds:_songListModel.file_duration];
    titleLabel.text = [NSString stringWithFormat:@"%@•%@",_songListModel.author,_songListModel.album_title];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
        // Initialization code
        //歌名
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, self.contentView.size.width-16-60, 25)];
        nameLabel.font = [UIFont systemFontOfSize:16.0f];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:nameLabel];
        //时间
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.size.width+nameLabel.origin.x, nameLabel.size.height/2+nameLabel.origin.y, 40, 25)];
        timeLabel.font = [UIFont systemFontOfSize:14.0f];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:timeLabel];
        //专辑名
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.origin.x, nameLabel.size.height+nameLabel.origin.y, nameLabel.size.width, 25)];
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:titleLabel];
    }
    return self;
}

@end
