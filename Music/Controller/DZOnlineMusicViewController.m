//
//  DZOnlineMusicViewController.m
//  Music
//
//  Created by dengwei on 16/1/2.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZOnlineMusicViewController.h"
#import "DZSinger.h"
#import "DZSingerTableViewCell.h"
#import "DZDetailMusicViewController.h"

@interface DZOnlineMusicViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray *_singer;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation DZOnlineMusicViewController

#pragma mark 懒加载
-(NSMutableArray *)array
{
    if (_singer == nil) {
        _singer = [[NSMutableArray alloc] init];
    }
    return _singer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self loadSingerInfo];
    [self setupTableView];
}

-(void)loadSingerInfo {
    DZSinger *model = [[DZSinger alloc] init];
    _singer = [model itemTop100];
}

-(void)setupUI
{
    self.title = @"Online";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_music"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction)];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"onlineBackground"]];
}

-(void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //关闭弹簧效果
    [self.tableView setBounces:NO];
}

-(void)rightButtonAction
{
    NSLog(@"rightButtonAction");
}

#pragma mark - UISearchBarDelegate methods
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    
    if ([_singer count] != 0) {
        [_singer removeAllObjects];
    }
    [ProgressHUD show:nil];
    [self getSingerData];
}

#pragma mark - private methods
-(void)getSingerData
{
    DZSinger *model = [[DZSinger alloc] init];
    _singer = [model itemWith:_searchBar.text];
    [self.tableView reloadData];
    [ProgressHUD dismiss];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark - UITableViewDelegate methods
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return nil;
    }
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索：歌手";
    searchBar.showsCancelButton = YES;
    //设置取消按钮的文字（默认是cancel）
    for (UIView *view in [[searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.keyboardType = UIKeyboardAppearanceDefault;
    self.searchBar = searchBar;
    
    return searchBar;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_singer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idfentifier = @"onlineViewCell";
    DZSingerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfentifier];
    if (cell == nil) {
        cell = [[DZSingerTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idfentifier];
    }

    DZSinger *model = [_singer objectAtIndex:indexPath.row];
    cell.model = model;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return 0;
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DZSinger *model = [_singer objectAtIndex:indexPath.row];
    DZDetailMusicViewController * pushController = [[DZDetailMusicViewController alloc] init];
    pushController.singerModel = model;
    [self.navigationController pushViewController:pushController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
