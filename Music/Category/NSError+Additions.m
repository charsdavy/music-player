//
//  NSError+Additions.m
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "NSError+Additions.h"

@implementation NSError (Additions)

-(BOOL)isURLError{
    return [self.domain isEqualToString:NSURLErrorDomain];
}

@end
