//
//  DZMySongList.h
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZMySongList : NSObject

@property (nonatomic,assign) int songnums;
@property (nonatomic,assign) BOOL havemore;
@property (nonatomic,assign) int error_code;
@property (nonatomic,retain) NSMutableArray *songLists;

@end
