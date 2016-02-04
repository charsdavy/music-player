//
//  DZGlobal.m
//  Music
//
//  Created by dengwei on 16/1/3.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZGlobal.h"

@implementation DZGlobal

+(DZGlobal *)sharedGlobal
{
    static DZGlobal *global = nil;
    if (global == nil) {
        global = [[DZGlobal alloc] init];
    }
    return global;
}

-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)copySqlitePath
{
    NSError *error = nil;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *dbPath = [kDocumentPath stringByAppendingString:@"/music.db"];
    NSLog(@"%s dbPath %@", __func__, dbPath);
    if (![fileMgr fileExistsAtPath:dbPath]) {
        NSString *srcPath = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"db"];
        [fileMgr copyItemAtPath:srcPath toPath:dbPath error:&error];
    }
    if (error) {
        NSLog(@"%s error:%@", __func__, error);
    }
}

@end
