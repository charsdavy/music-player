//
//  DZDataEngine.m
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZDataEngine.h"
#import "DZSongList.h"
#import "DZSinger.h"
#import "DZMySongList.h"
#import "DZSong.h"


#define DocumentsPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
NSString * error_code = @"error_code";

NSString * ting_uid = @"ting_uid";
NSString * name = @"name";
NSString * firstchar = @"firstchar";
NSString * gender = @"gender";
NSString * area = @"area";
NSString * country = @"country";
NSString * avatar_big = @"avatar_big";
NSString * avatar_middle = @"avatar_middle";
NSString * avatar_small = @"avatar_small";
NSString * avatar_mini = @"avatar_mini";
NSString * constellation = @"constellation";
NSString * stature = @"stature";
NSString * weight = @"weight";
NSString * bloodtype = @"bloodtype";
NSString * company = @"company";
NSString * intro = @"intro";
NSString * songs_total = @"songs_total";
NSString * albums_total = @"albums_total";
NSString * birth = @"birth";
NSString * url = @"url";
NSString * artist_id = @"artist_id";
NSString * avatar_s180 = @"avatar_s180";
NSString * avatar_s500 = @"avatar_s500";
NSString * avatar_s1000 = @"avatar_s1000";
NSString * piao_id = @"piao_id";

NSString * songlist= @"songlist";

@implementation DZDataEngine

-(MKNetworkOperation *)getSingerInformationWith:(long long)tinguid WithCompletionHandler:(SalesResponseBlock)completion errorHandler:(MKNKErrorBlock)errorHandler
{
    self.showError = YES;
    NSString *urlPath = [NSString stringWithFormat:@"/v1/restserver/ting?from=android&version=2.4.0&method=baidu.ting.artist.getinfo&format=json&tinguid=%lld",tinguid];
    
    MKNetworkOperation *op = [self operationWithPath:urlPath];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        id respJson = [completedOperation responseJSON];
        if ([self checkError:respJson]) {
            return ;
        }
        //        NSLog(@"resp:%@",respJson);
        @try{
            NSMutableArray * array = [NSMutableArray new];
            NSDictionary * dictionary = respJson;
            if ([[dictionary allKeys] count]>1) {
                DZSinger *model = [DZSinger new];
                model.ting_uid = [[dictionary objectForKey:ting_uid] longLongValue];
                model.name = [dictionary objectForKey:name];
                model.firstchar = [dictionary objectForKey:firstchar];
                model.gender = [[dictionary objectForKey:gender] intValue];
                model.area = [[dictionary objectForKey:area] intValue];
                model.country = [dictionary objectForKey:country];
                model.avatar_big = [dictionary objectForKey:avatar_big];
                model.avatar_middle =[dictionary objectForKey:avatar_middle];
                model.avatar_small = [dictionary objectForKey:avatar_small];
                model.avatar_mini =[dictionary objectForKey:avatar_mini];
                model.constellation = [dictionary objectForKey:constellation];
                if ([dictionary objectForKey:stature]!=[NSNull null]) {
                    model.stature = [[dictionary objectForKey:stature] floatValue];
                }else{
                    model.stature = 0.00f;
                }
                if ([dictionary objectForKey:weight]!=[NSNull null]) {
                    model.weight = [[dictionary objectForKey:weight] floatValue];
                }else{
                    model.weight = 0.00f;
                }
                model.bloodtype = [dictionary objectForKey:bloodtype];
                model.company =[dictionary objectForKey:company];
                model.intro =[dictionary objectForKey:intro];
                model.albums_total = [[dictionary objectForKey:albums_total] intValue];
                model.songs_total = [[dictionary objectForKey:songs_total] intValue];
                model.birth = [dictionary objectForKey:birth];
                model.url = [dictionary objectForKey:url];
                model.artist_id = [[dictionary objectForKey:artist_id] intValue];
                model.avatar_s180 = [dictionary objectForKey:avatar_s180];
                model.avatar_s500 = [dictionary objectForKey:avatar_s500];
                model.avatar_s1000 = [dictionary objectForKey:avatar_s1000];
                model.piao_id = [[dictionary objectForKey:piao_id] intValue];
                
                BOOL  sucess = [DZSinger insertToDB:model];
                if (sucess) {
                    NSLog(@"%@ sucess %lld",model.name,model.ting_uid);
                }
                
            }else{
                int errorcode = [[dictionary objectForKey:error_code] intValue];
                NSLog(@"%d",errorcode);
            }
            completion(array);
        }
        @catch (NSException *exception) {
            KHError *appError = [[KHError alloc] initWithDomain:kHAppErrorDomain code:100 userInfo:nil];
            appError.reason = kHErrorParse;
            errorHandler(appError);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"ERROR:%@",error);
        KHError *appError = [[KHError alloc] initWithMKNetworkOperation:completedOperation error:error];
        errorHandler(appError);
        
    }];
    [self enqueueOperation:op];
    return op;
}

-(MKNetworkOperation *)getSingerSongListWith:(long long)tinguid :(int)number
                       WithCompletionHandler:(DZSongListModelResponseBlock)completion
                                errorHandler:(MKNKErrorBlock)errorHandler
{
    self.showError = YES;
    NSString *urlPath = [NSString stringWithFormat:@"/v1/restserver/ting?from=android&version=2.4.0&method=baidu.ting.artist.getSongList&format=json&order=2&tinguid=%lld&offset=0&limits=%d",tinguid,number];
    MKNetworkOperation *op = [self operationWithPath:urlPath];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        id respJson = [completedOperation responseJSON];
        if ([self checkError:respJson]) {
            return ;
        }
        //        NSLog(@"resp:%@",respJson);
        DZMySongList * list = [DZMySongList new];
        @try{
            NSDictionary * dictionary = respJson;
            if ([[dictionary allKeys] count]>1) {
                list.songnums = [[dictionary objectForKey:@"songnums"] intValue];
                list.havemore = [[dictionary objectForKey:@"havemore"] boolValue];
                list.error_code =[[dictionary objectForKey:@"error_code"] intValue];
                NSArray * temp = [dictionary objectForKey:songlist];
                for (NSDictionary * dict in temp) {
                    DZSongList * model = [DZSongList new];
                    model.artist_id = [[dict objectForKey:@"artist_id"] intValue];
                    model.all_artist_ting_uid = [[dict objectForKey:@"all_artist_ting_uid"] intValue];
                    model.all_artist_id = [[dict objectForKey:@"all_artist_id"] intValue];
                    model.language = [dict objectForKey:@"language"];
                    model.publishtime = [dict objectForKey:@"publishtime"];
                    model.album_no = [[dict objectForKey:@"album_no"] intValue];
                    model.pic_big = [dict objectForKey:@"pic_big"];
                    model.pic_small = [dict objectForKey:@"pic_small"];
                    model.country = [dict objectForKey:@"country"];
                    model.area = [[dict objectForKey:@"area"] intValue];
                    model.lrclink = [dict objectForKey:@"lrclink"];
                    model.hot = [[dict objectForKey:@"hot"] intValue];
                    model.file_duration = [[dict objectForKey:@"file_duration"] intValue];
                    model.del_status = [[dict objectForKey:@"del_status"] intValue];
                    model.resource_type = [[dict objectForKey:@"resource_type"] intValue];
                    model.copy_type = [[dict objectForKey:@"copy_type"] intValue];
                    model.relate_status = [[dict objectForKey:@"relate_status"] intValue];
                    model.all_rate = [[dict objectForKey:@"all_rate"] intValue];
                    model.has_mv_mobile = [[dict objectForKey:@"has_mv_mobile"] intValue];
                    model.toneid = [[dict objectForKey:@"toneid"] longLongValue];
                    model.song_id = [[dict objectForKey:@"song_id"] longLongValue];
                    model.title = [dict objectForKey:@"title"];
                    model.ting_uid = [[dict objectForKey:@"ting_uid"] longLongValue];
                    model.author = [dict objectForKey:@"author"];
                    model.album_id = [[dict objectForKey:@"album_id"] longLongValue];
                    model.album_title = [dict objectForKey:@"album_title"];
                    model.is_first_publish = [[dict objectForKey:@"is_first_publish"] intValue];
                    model.havehigh = [[dict objectForKey:@"havehigh"] intValue];
                    model.charge = [[dict objectForKey:@"charge"] intValue];
                    model.has_mv = [[dict objectForKey:@"has_mv"] intValue];
                    model.learn = [[dict objectForKey:@"learn"] intValue];
                    model.piao_id = [[dict objectForKey:@"piao_id"] intValue];
                    model.listen_total = [[dict objectForKey:@"listen_total"] longLongValue];
                    [list.songLists addObject:model];
                }
            }else{
                int errorcode = [[dictionary objectForKey:error_code] intValue];
                NSLog(@"%d",errorcode);
            }
            completion(list);
        }
        @catch (NSException *exception) {
            KHError *appError = [[KHError alloc] initWithDomain:kHAppErrorDomain code:100 userInfo:nil];
            appError.reason = kHErrorParse;
            errorHandler(appError);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"ERROR:%@",error);
        KHError *appError = [[KHError alloc] initWithMKNetworkOperation:completedOperation error:error];
        errorHandler(appError);
        
    }];
    [self enqueueOperation:op];
    return op;
}

-(MKNetworkOperation *)getSongInformationWith:(long long)songID
                        WithCompletionHandler:(DZSongModelResponseBlock)completion
                                 errorHandler:(MKNKErrorBlock)errorHandler
{
    self.showError = YES;
    NSString *urlPath = [NSString stringWithFormat:@"/data/music/links?songIds=%lld",songID];
    DZNetworkEngine * netwrok = [self initWithHostName:@"ting.baidu.com"];
    MKNetworkOperation *op = [netwrok operationWithPath:urlPath];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        id respJson = [completedOperation responseJSON];
        if ([self checkError:respJson]) {
            return ;
        }
        //        NSLog(@"resp:%@",respJson);
        DZSong * song = [DZSong new];
        @try{
            NSDictionary * dictionary = respJson;
            if ([[dictionary allKeys] count]>1) {
                NSDictionary * data = [dictionary objectForKey:@"data"];
                NSArray * songList = [data objectForKey:@"songList"];
                for (NSDictionary * sub in songList) {
                    song.songLink = [sub objectForKey:@"songLink"];
                    NSRange range = [song.songLink rangeOfString:@"src"];
                    if (range.location != 2147483647 && range.length != 0) {
                        NSString * temp = [song.songLink substringToIndex:range.location-1];
                        song.songLink = temp;
                    }
                    song.songName = [sub objectForKey:@"songName"];
                    song.lrcLink = [sub objectForKey:@"lrcLink"];
                    song.songPicBig = [sub objectForKey:@"songPicBig"];
                    song.time = [[sub objectForKey:@"time"] intValue];
                }
            }else{
                int errorcode = [[dictionary objectForKey:error_code] intValue];
                NSLog(@"%d",errorcode);
            }
            completion(song);
        }
        @catch (NSException *exception) {
            KHError *appError = [[KHError alloc] initWithDomain:kHAppErrorDomain code:100 userInfo:nil];
            appError.reason = kHErrorParse;
            errorHandler(appError);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"ERROR:%@",error);
        KHError *appError = [[KHError alloc] initWithMKNetworkOperation:completedOperation error:error];
        errorHandler(appError);
        
    }];
    [self enqueueOperation:op];
    return op;
}

-(MKNetworkOperation *)getSongLrcWith:(long long)tingUid :(long long)songID :(NSString *)lrclink
                WithCompletionHandler:(DZSongLrcResponseBlock)completion
                         errorHandler:(MKNKErrorBlock)errorHandler
{
    self.showError = YES;
    DZNetworkEngine * netwrok = [self initWithHostName:@"ting.baidu.com"];
    MKNetworkOperation *op = [netwrok operationWithPath:lrclink];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData * respData = [completedOperation responseData];
        if ([self checkError:respData]) {
            return ;
        }
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *UIDPath = [DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld",tingUid]];
        NSString * SIDPath = [UIDPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld",songID]];
        if (![fileMgr fileExistsAtPath:UIDPath]) {
            BOOL creatUID = [fileMgr createDirectoryAtPath:UIDPath withIntermediateDirectories:YES attributes:nil error:nil];
            if (creatUID) {
                NSLog(@"建立歌手文件夹成功");
            }
        }
        if (![fileMgr fileExistsAtPath:SIDPath]) {
            BOOL creatSID = [fileMgr createDirectoryAtPath:SIDPath withIntermediateDirectories:YES attributes:nil error:nil];
            if (creatSID) {
                NSLog(@"建立歌曲文件夹成功");
            }
        }
        BOOL sucess = NO;
        NSString * filePath  = [SIDPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld.lrc",songID]];
        if (![fileMgr fileExistsAtPath:filePath]) {
            BOOL creat =  [fileMgr createFileAtPath:filePath contents:respData attributes:nil];
            if (creat) {
                NSLog(@"lrc文件保存成功");
                sucess = YES;
            }
        }else{
            sucess = YES;
        }
        //        NSLog(@"resp:%@",respData);
        @try{
            completion(sucess,filePath);
        }
        @catch (NSException *exception) {
            KHError *appError = [[KHError alloc] initWithDomain:kHAppErrorDomain code:100 userInfo:nil];
            appError.reason = kHErrorParse;
            errorHandler(appError);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"ERROR:%@",error);
        KHError *appError = [[KHError alloc] initWithMKNetworkOperation:completedOperation error:error];
        errorHandler(appError);
        
    }];
    [self enqueueOperation:op];
    return op;
    
}

-(MKNetworkOperation *)downLoadSongWith:(long long)tingUid :(long long)songID :(NSString *)songLink
                  WithCompletionHandler:(DZSongLinkDownLoadResponseBlock)completion
                           errorHandler:(MKNKErrorBlock)errorHandler
{
    self.showError = YES;
    MKNetworkOperation *op = [self operationWithURLString:songLink];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData * respData = [completedOperation responseData];
        if ([self checkError:respData]) {
            return ;
        }
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *UIDPath = [DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld",tingUid]];
        NSString * SIDPath = [UIDPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld",songID]];
        if (![fileMgr fileExistsAtPath:UIDPath]) {
            BOOL creatUID = [fileMgr createDirectoryAtPath:UIDPath withIntermediateDirectories:YES attributes:nil error:nil];
            if (creatUID) {
                NSLog(@"建立歌手文件夹成功");
            }
        }
        if (![fileMgr fileExistsAtPath:SIDPath]) {
            BOOL creatSID = [fileMgr createDirectoryAtPath:SIDPath withIntermediateDirectories:YES attributes:nil error:nil];
            if (creatSID) {
                NSLog(@"建立歌曲文件夹成功");
            }
        }
        BOOL sucess = NO;
        NSString * filePath  = [SIDPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld.mp3",songID]];
        if (![fileMgr fileExistsAtPath:filePath]) {
            BOOL creat =  [fileMgr createFileAtPath:filePath contents:respData attributes:nil];
            if (creat) {
                NSLog(@"mp3文件保存成功");
                sucess = YES;
            }
        }else{
            sucess = YES;
        }
        //        NSLog(@"resp:%@",respData);
        @try{
            completion(sucess,filePath);
        }
        @catch (NSException *exception) {
            KHError *appError = [[KHError alloc] initWithDomain:kHAppErrorDomain code:100 userInfo:nil];
            appError.reason = kHErrorParse;
            errorHandler(appError);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"ERROR:%@",error);
        KHError *appError = [[KHError alloc] initWithMKNetworkOperation:completedOperation error:error];
        errorHandler(appError);
        
    }];
    
    [op onDownloadProgressChanged:^(double progress) {
        NSLog(@"%.2f",progress*100.0);
    }];
    
    [self enqueueOperation:op];
    return op;
    
}

@end
