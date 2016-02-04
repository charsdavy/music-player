//
//  DZSingerTableViewCell.h
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "StyledTableViewCell.h"

@class DZImageView;
@class DZSinger;

@interface DZSingerTableViewCell : StyledTableViewCell
{
    
    DZImageView * headerImageView;
    UILabel * nameLabel;
    UILabel * titleLabel;
    
}

@property (nonatomic,strong) DZSinger *model;

@end
