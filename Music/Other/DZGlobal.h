//
//  DZGlobal.h
//  Music
//
//  Created by dengwei on 16/1/3.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZGlobal : NSObject

@property (nonatomic, assign) BOOL isApplicationEnterBackground;
@property (nonatomic, assign) BOOL isPlaying;

+(DZGlobal *)sharedGlobal;
-(void)copySqlitePath;

@end
