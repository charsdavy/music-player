//
//  DZDetailMusicViewController.m
//  Music
//
//  Created by dengwei on 16/1/3.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZDetailMusicViewController.h"
#import "DZLoadMoreFooterView.h"
#import "NSDate+Additions.h"
#import "UIView+Additions.h"
#import "DZSongListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DZDataEngine.h"
#import "DZGlobal.h"
#import "ProgressHUD.h"
#import "DZSinger.h"
#import "DZMySongList.h"

#define DEFAULT_HEIGHT_OFFSET 44.0f

@interface DZDetailMusicViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    NSMutableArray *song;
    BOOL isLoadingMore;
    BOOL isCanLoadMore;
    DZLoadMoreFooterView *footerView;
    int song_total;
}

@end

@implementation DZDetailMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTableView];
    
    if (_singerModel.songs_total < 20) {
        song_total = _singerModel.songs_total;
        isLoadingMore = NO;
    }else{
        song_total = 20;
        isLoadingMore = YES;
    }
    if (isLoadingMore) {
        footerView = [[DZLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, _tableView.size.width, 70)];
        _tableView.tableFooterView = footerView;
    }
    
    [ProgressHUD show:nil];
    [self getSongsList];
}

-(void)setupUI {
    self.title = @"Online Music";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_music"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction)];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"onlineBackground"]];
    self.title = [NSString stringWithFormat:@"%@", _singerModel.name];
}

-(void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

-(void)rightButtonAction {

}

-(void)getSongsList {
    DZDataEngine * network = [DZDataEngine new];
    [network getSingerSongListWith:_singerModel.ting_uid :song_total WithCompletionHandler:^(DZMySongList *songList) {
        song = songList.songLists;
        [_tableView reloadData];
        [ProgressHUD dismiss];
    } errorHandler:^(NSError *error) {
        if (error) {
            NSLog(@"error %@", error);
        }
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [song count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"detailCellId";
    
    DZSongListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[DZSongListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }

    DZSongList *model = [song objectAtIndex:indexPath.row];
    cell.songListModel = model;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark -
-(void)loadMore
{
    if (isLoadingMore) {
        [footerView.activeView startAnimating];
        song_total += 20;
        [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:0.1];
        isLoadingMore = NO;
        footerView.titleLabel.text = @"获取中...";
    }
}

-(void)loadMoreData {
    DZDataEngine * network = [DZDataEngine new];
    [network getSingerSongListWith:_singerModel.ting_uid :song_total WithCompletionHandler:^(DZMySongList *songList) {
        
        song = songList.songLists;
        [_tableView reloadData];
        if (song_total> _singerModel.songs_total){
            song_total = _singerModel.songs_total;
            isCanLoadMore = YES; // signal that there won't be any more items to load
        }else{
            isCanLoadMore = NO;
        }
        [self loadMoreCompleted];
    } errorHandler:^(NSError *error) {
        if (error) {
            NSLog(@"error %@", error);
        }
    }];
}

-(void)loadMoreCompleted
{
    isLoadingMore = YES;
    if (isCanLoadMore) {
        _tableView.tableFooterView = nil;
    }else{
        [footerView.activeView stopAnimating];
    }
}

#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoadingMore && !isCanLoadMore) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        if (scrollPosition < DEFAULT_HEIGHT_OFFSET) {
            [self loadMore];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
