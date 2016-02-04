//
//  DZImageView.h
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZImageView : UIImageView

@property (nonatomic, assign, getter = isCacheEnabled) BOOL cacheEnabled;
@property (nonatomic, strong) UIImageView *containerImageView;

- (instancetype)initWithFrame:(CGRect)frame backgroundProgressColor:(UIColor *)backgroundProgresscolor;

@end
