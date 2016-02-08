//
//  DZMySongList.m
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZMySongList.h"

@implementation DZMySongList

-(instancetype)init {
    if (self = [super init]) {
        self.songLists = [NSMutableArray new];
    }
    return self;
}

@end
