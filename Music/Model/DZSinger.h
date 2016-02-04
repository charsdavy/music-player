//
//  DZSinger.h
//  Music
//
//  Created by dengwei on 16/1/3.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZSinger : NSObject

@property (nonatomic, assign) long long  ting_uid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * firstchar;
@property (nonatomic, assign) int gender;
@property (nonatomic, assign) int area;
@property (nonatomic, copy) NSString * country;
@property (nonatomic, copy) NSString * avatar_big;
@property (nonatomic, copy) NSString * avatar_middle;
@property (nonatomic, copy) NSString * avatar_small;
@property (nonatomic, copy) NSString * avatar_mini;
@property (nonatomic, copy) NSString * constellation;
@property (nonatomic, assign) float stature;
@property (nonatomic, assign) float weight;
@property (nonatomic, copy) NSString * bloodtype;
@property (nonatomic, copy) NSString * company;
@property (nonatomic, copy) NSString * intro;
@property (nonatomic, assign) int albums_total;
@property (nonatomic, assign) int songs_total;
@property (nonatomic, assign) NSDate * birth;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, assign) int artist_id;
@property (nonatomic, copy) NSString * avatar_s180;
@property (nonatomic, copy) NSString * avatar_s500;
@property (nonatomic, copy) NSString * avatar_s1000;
@property (nonatomic, assign) int piao_id;

-(NSMutableArray *)itemWith:(NSString *)name;
-(NSMutableArray *)itemTop100;

@end
