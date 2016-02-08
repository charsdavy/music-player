//
//  DZLoadMoreFooterView.m
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZLoadMoreFooterView.h"
#import "UIView+Additions.h"

@implementation DZLoadMoreFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.activeView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(frame.size.width/2-(30+100)/2, frame.size.height/2-30/2, 30, 30)];
        _activeView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        //        _activeView.backgroundColor =[UIColor redColor];
        [self addSubview:_activeView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_activeView.size.width+_activeView.origin.x, frame.size.height/2-25/2, 100, 25)];
        //        _titleLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_titleLabel];
    }
    return self;
}

@end
