//
//  DZNetworkEngine.m
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZNetworkEngine.h"
#import "DZNetworkOperation.h"

@implementation KHError
-(NSString *)localizedFailureReason{
    if (_reason) {
        return _reason;
    }
    if ([self.domain isEqualToString:NSURLErrorDomain]) {
        return @"网络错误";
    }
    return [self localizedDescription];
}
-(id)initWithMKNetworkOperation:(MKNetworkOperation *)op error:(NSError *)error{
    NSInteger statusCode = op.HTTPStatusCode;
    id respJson = op.responseJSON;
    if ([respJson isKindOfClass:[NSDictionary class]] || [respJson isKindOfClass:[NSArray class]]) {
        self = [self initWithDomain:kHAppErrorDomain code:statusCode userInfo:nil];
        if ([respJson isKindOfClass:[NSArray class]]) {
            NSMutableString *string = [NSMutableString string];
            NSInteger idx = 0;
            for (NSDictionary *dict in respJson) {
                if (idx == 0) {
                    [string appendString:[dict objectForKey:@"message"]];
                }
                else{
                    [string appendFormat:@"\n%@",[dict objectForKey:@"message"]];
                }
            }
            self.reason = string;
        }
        else{
            self.reason = [respJson objectForKey:@"message"];
        }
    }
    else{
        self = [self initWithDomain:error.domain code:error.code userInfo:error.userInfo];
        self.reason = [error localizedFailureReason];
    }
    return self;
}
@end

@implementation DZNetworkEngine
-(BOOL) isCacheable{
    return NO;
}
-(id)init
{
    self = [self initWithHostName:KHServerBase];
    if (self) {
        //        self.portNumber = 8100;
    }
    return self;
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path {
    
    MKNetworkOperation *op = [super operationWithPath:path];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    op.stringEncoding = NSUTF8StringEncoding;
    
    return op;
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path
                                  params:(NSDictionary*) body {
    MKNetworkOperation *op = [super operationWithPath:path params:body];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    op.stringEncoding = NSUTF8StringEncoding;
    return op;
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path
                                  params:(NSDictionary*) body
                              httpMethod:(NSString*)method  {
    
    MKNetworkOperation *op = [super operationWithPath:path params:body httpMethod:method];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    op.stringEncoding = NSUTF8StringEncoding;
    return op;
}

-(void)showPrompt:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(BOOL)checkError:(id)resp{
    if ([resp isKindOfClass:[NSDictionary class]]) {
        NSString *msg = [resp objectForKey:@"message"];
        if (msg && [msg isKindOfClass:[NSString class]] && msg.length > 0) {
            if (_showError) {
                [self showPrompt:msg];
            }
            return YES;
        }
    }
    return NO;
}
@end