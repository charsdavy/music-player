//
//  Common.h
//  Music
//
//  Created by dengwei on 16/1/2.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#ifndef Music_Common_h
#define Music_Common_h

#define kHeight 44
#define kMainWidth ([[UIScreen mainScreen] bounds].size.width)
#define kMainHeight ([[UIScreen mainScreen] bounds].size.height)
#define kViewWidth ([[UIScreen mainScreen] bounds].size.width * 0.5)
#define kViewHeight ([[UIScreen mainScreen] bounds].size.height - kHeight)

#define kDocumentPath ([NSHomeDirectory() stringByAppendingPathComponent:@"Documents"])
#define kRadioViewStatusNotification @"RadioViewStatusNotification"
#define kRadioViewSetSongInfoNotification @"RadioViewSetSongInfoNotification"

#endif
