//
//  SomethingNewTableViewController.m
//  Step it up
//
//  Created by syfll on 15/4/6.
//  Copyright (c) 2015年 syfll. All rights reserved.
//

#import "SomethingNewTableViewController.h"
#import "SIUMacros.h"
@interface SomethingNewTableViewController ()<XHSendMessageViewDelegate>


@end

@implementation SomethingNewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    
    [self.view addSubview:self.sendMessageView];
    
    [self loadDataSource];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Propertys
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _dataSource;
}

- (XHPhotographyHelper *)photographyHelper {
    if (!_photographyHelper) {
        _photographyHelper = [[XHPhotographyHelper alloc] init];
    }
    return _photographyHelper;
}

- (XHAlbumOperationView *)operationView {
    if (!_operationView) {
        _operationView = [XHAlbumOperationView initailzerAlbumOperationView];
        WEAKSELF
        _operationView.didSelectedOperationCompletion = ^(XHAlbumOperationType operationType) {
            STRONGSELF
            NSLog(@"operationType : %ld", operationType);
            switch (operationType) {
                case XHAlbumOperationTypeLike:
                    [self addLike];
                    break;
                case XHAlbumOperationTypeReply:
                    [strongSelf.sendMessageView becomeFirstResponderForTextField];
                    break;
                default:
                    break;
            }
        };
    }
    return _operationView;
}

- (XHSendMessageView *)sendMessageView {
    if (!_sendMessageView) {
        _sendMessageView = [[XHSendMessageView alloc] initWithFrame:CGRectZero];
        _sendMessageView.sendMessageDelegate = self;
    }
    return _sendMessageView;
}


#pragma mark - XHSendMessageView Delegate

- (void)addLike {
    if (self.selectedIndexPath && self.selectedIndexPath.row < self.dataSource.count) {
        XHAlbum *updateCurrentAlbum = self.dataSource[self.selectedIndexPath.row];
        NSMutableArray *likes = [[NSMutableArray alloc] initWithArray:updateCurrentAlbum.albumShareLikes];
        [likes insertObject:@"仔仔" atIndex:0];
        updateCurrentAlbum.albumShareLikes = likes;
        [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)didSendMessage:(NSString *)message albumInputView:(XHSendMessageView *)sendMessageView {
    if (self.selectedIndexPath && self.selectedIndexPath.row < self.dataSource.count) {
        XHAlbum *updateCurrentAlbum = self.dataSource[self.selectedIndexPath.row];
        NSMutableArray *comments = [[NSMutableArray alloc] initWithArray:updateCurrentAlbum.albumShareComments];
        [comments insertObject:message atIndex:0];
        updateCurrentAlbum.albumShareComments = comments;
        [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [sendMessageView finishSendMessage];
    }
}

#pragma mark - XHAlbumTableViewCellDelegate

- (void)didShowOperationView:(UIButton *)sender indexPath:(NSIndexPath *)indexPath {
    CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:indexPath];
    CGFloat origin_Y = rectInTableView.origin.y + sender.frame.origin.y;
    CGRect targetRect = CGRectMake(CGRectGetMinX(sender.frame), origin_Y, CGRectGetWidth(sender.bounds), CGRectGetHeight(sender.bounds));
    if (self.operationView.shouldShowed) {
        [self.operationView dismiss];
        return;
    }
    self.selectedIndexPath = indexPath;
    [self.operationView showAtView:self.tableView rect:targetRect];
}

#pragma mark - DataSource

- (void)loadDataSource {
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"请求网络开始");
        NSMutableArray *dataSource = [self getAlbumConfigureArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            
            weakSelf.dataSource = dataSource;
            [weakSelf.tableView reloadData];
            NSLog(@"请求网络结束");
        });
    });
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"albumTableViewCellIdentifier";
    
    XHAlbumTableViewCell *albumTableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!albumTableViewCell) {
        albumTableViewCell = [[XHAlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        albumTableViewCell.delegate = self;
    }
    
    if (indexPath.row < self.dataSource.count) {
        albumTableViewCell.indexPath = indexPath;
        albumTableViewCell.currentAlbum = self.dataSource[indexPath.row];
    }
    
    return albumTableViewCell;
}
#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [XHAlbumTableViewCell calculateCellHeightWithAlbum:self.dataSource[indexPath.row]];
}

#pragma mark -
#pragma mark Setup Methods

- (void)setupTableView
{
    if (!self.refreshControl)
    {
        self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -44, 320, 44)];
        //self.refreshControl.backgroundColor = [UIColor blackColor];
        [self.refreshControl addTarget:self action:@selector(loadDataSource) forControlEvents:UIControlEventValueChanged];
        [self.tableView addSubview:self.refreshControl];
    }
}

#pragma mark - 
#pragma mark Just for test,please delete it later.
- (NSMutableArray *)getAlbumConfigureArray {
    NSMutableArray *albumConfigureArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 1; i ++) {
        XHAlbum *currnetAlbum = [[XHAlbum alloc] init];
        currnetAlbum.userName = @"Jack";
        currnetAlbum.profileAvatarUrlString = @"http://www.pailixiu.com/jack/meIcon@2x.png";
        currnetAlbum.albumShareContent = @"朋友圈分享内容，😗😗😗😗😗这里做图片加载，😗😗😗😗😗还是混排好呢？😜😜😜😜😜如果不混排，感觉CoreText派不上场啊！😄😄😄你说是不是？😗😗😗😗😗如果有混排的需要就更好了！😗😗😗😗😗";
        currnetAlbum.albumSharePhotos = [NSArray arrayWithObjects:@"http://www.pailixiu.com/jack/JieIcon@2x.png", @"http://www.pailixiu.com/jack/JieIcon@2x.png", @"http://www.pailixiu.com/jack/JieIcon@2x.png", @"http://www.pailixiu.com/jack/JieIcon@2x.png", @"http://www.pailixiu.com/jack/JieIcon@2x.png", @"http://www.pailixiu.com/jack/JieIcon@2x.png", @"http://www.pailixiu.com/jack/JieIcon@2x.png", @"http://www.pailixiu.com/jack/JieIcon@2x.png", @"http://www.pailixiu.com/jack/JieIcon@2x.png", nil];
        currnetAlbum.timestamp = [NSDate date];
        currnetAlbum.albumShareLikes = @[@"Jack", @"华仔"];
        currnetAlbum.albumShareComments = @[@"评论啊！", @"再次评论啊！"];
        [albumConfigureArray addObject:currnetAlbum];
    }
    
    return albumConfigureArray;
}

@end
