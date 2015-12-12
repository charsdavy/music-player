//
//  DZMusicCell.m
//  Music
//
//  Created by dengwei on 15/9/27.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DZMusicCell.h"
#import "DZMusic.h"
#import "UIImage+CZ.h"

@implementation DZMusicCell

+(instancetype)musicCellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"cell";
    //forIndexPath:indexPath 跟 storyboard 配套使用
    DZMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //Configure the cell ...
    if (cell == nil) {
        cell = [[DZMusicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

//显示cell的数据
-(void)setMusic:(DZMusic *)music
{
    _music = music;
    
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
    UIImage *circleImage = [UIImage circleImageWithName:music.singerIcon borderWidth:1.0 borderColor:[UIColor whiteColor]];
    self.imageView.image = circleImage;
}

@end
