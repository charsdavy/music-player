//
//  DZDataEngine.h
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZNetworkEngine.h"

@class DZSong, DZMySongList;
@interface DZDataEngine : DZNetworkEngine

typedef void (^SalesResponseBlock) (NSArray *array);
typedef void (^DZSongListModelResponseBlock) (DZMySongList *songList);
typedef void (^DZSongModelResponseBlock) (DZSong *songModel);
typedef void (^DZSongLrcResponseBlock)(BOOL sucess,NSString * path);
typedef void (^DZSongLinkDownLoadResponseBlock)(BOOL sucess,NSString * path);

-(MKNetworkOperation *)getSingerInformationWith:(long long)tinguid
                          WithCompletionHandler:(SalesResponseBlock)completion
                                   errorHandler:(MKNKErrorBlock)errorHandler;

-(MKNetworkOperation *)getSingerSongListWith:(long long)tinguid :(int) number
                       WithCompletionHandler:(DZSongListModelResponseBlock)completion
                                errorHandler:(MKNKErrorBlock)errorHandler;

-(MKNetworkOperation *)getSongInformationWith:(long long)songID
                        WithCompletionHandler:(DZSongModelResponseBlock)completion
                                 errorHandler:(MKNKErrorBlock)errorHandler;

-(MKNetworkOperation *)getSongLrcWith:(long long)tingUid :(long long)songID :(NSString *)lrclink
                WithCompletionHandler:(DZSongLrcResponseBlock)completion
                         errorHandler:(MKNKErrorBlock)errorHandler;

-(MKNetworkOperation *)downLoadSongWith:(long long)tingUid :(long long)songID :(NSString *)songLink
                  WithCompletionHandler:(DZSongLinkDownLoadResponseBlock)completion
                           errorHandler:(MKNKErrorBlock)errorHandler;

@end
