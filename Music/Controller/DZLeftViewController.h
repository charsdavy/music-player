//
//  DZLeftViewController.h
//  Music
//
//  Created by dengwei on 16/1/2.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DZLeftViewDelegate <NSObject>
@required
/**
 *  选择HomeView
 */
-(void)showHomeView;

/**
 *  选择OnlineMusicView
 */
-(void)showOnlineMusicView;

/**
 *  选择AboutView
 */
-(void)showAboutView;
@end

@interface DZLeftViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign)id <DZLeftViewDelegate>   delegate;

@end
