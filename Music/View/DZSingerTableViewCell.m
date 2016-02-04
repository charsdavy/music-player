//
//  DZSingerTableViewCell.m
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZSingerTableViewCell.h"
#import "DZSinger.h"
#import "DZImageView.h"
#import "UIView+Additions.h"
#import "UIImageView+WebCache.h"

@implementation DZSingerTableViewCell

-(void)setModel:(DZSinger *)model
{
    _model = model;
    [headerImageView setImageWithURL:[NSURL URLWithString:_model.avatar_big] placeholderImage:[UIImage imageNamed:@"headerImage"]];
    nameLabel.text = _model.name;
    if ([_model.company length]!=0) {
        titleLabel.text = _model.company;
    }else{
        titleLabel.text = @"<无信息>";
    }
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
        headerImageView = [[DZImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
        [self.contentView addSubview:headerImageView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.size.width+headerImageView.origin.x+5, headerImageView.origin.y, self.contentView.size.width-headerImageView.size.width-headerImageView.origin.x-30, 30)];
        nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [self.contentView addSubview:nameLabel];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.origin.x, nameLabel.size.height+nameLabel.origin.y+5, nameLabel.size.width, nameLabel.size.height-10)];
        titleLabel.font = [UIFont systemFontOfSize:13.0f];
        titleLabel.textColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
