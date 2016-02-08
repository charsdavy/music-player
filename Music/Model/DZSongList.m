//
//  DZSongList.m
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZSongList.h"

@implementation DZSongList

#pragma mark 表名
+(NSString *)getTableName{
    return @"SongListTable";
}

#pragma mark 表版本
+(int)getTableVersion{
    return 1;
}

#pragma mark 主键
+(NSString *)getPrimaryKey{
    return @"song_id";
}

@end
