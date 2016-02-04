//
//  DZImageView.m
//  Music
//
//  Created by dengwei on 16/2/4.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZImageView.h"


#pragma mark - Utils

#define rad(degrees) ((degrees) / (180.0 / M_PI))
#define kLineWidth 3.f

NSString * const spm_identifier = @"spm.imagecache.tg";

#pragma mark - SPMImageAsyncView interface

@interface DZImageView ()

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) UIView      *progressContainer;

@end

#pragma mark - SPMImageAsyncView


@implementation DZImageView

- (instancetype)initWithFrame:(CGRect)frame {
    return [[DZImageView alloc] initWithFrame:frame
                        backgroundProgressColor:[UIColor whiteColor]];
}

- (id)initWithFrame:(CGRect)frame backgroundProgressColor:(UIColor *)backgroundProgresscolor
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius     = CGRectGetWidth(self.bounds)/2.f;
        self.layer.masksToBounds    = NO;
        self.clipsToBounds          = YES;
        
        CGPoint arcCenter           = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat radius              = MIN(CGRectGetMidX(self.bounds)-1, CGRectGetMidY(self.bounds)-1);
        
        UIBezierPath *circlePath    = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                                     radius:radius
                                                                 startAngle:-rad(90)
                                                                   endAngle:rad(360-90)
                                                                  clockwise:YES];
        
        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.path           = circlePath.CGPath;
        _backgroundLayer.strokeColor    = [backgroundProgresscolor CGColor];
        _backgroundLayer.fillColor      = [[UIColor clearColor] CGColor];
        _backgroundLayer.lineWidth      = kLineWidth;
    }
    return self;
}

@end
