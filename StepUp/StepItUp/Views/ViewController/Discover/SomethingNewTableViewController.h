//
//  SomethingNewTableViewController.h
//  Step it up
//
//  Created by syfll on 15/4/6.
//  Copyright (c) 2015年 syfll. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHAlbumTableViewCell.h"
#import "XHPhotographyHelper.h"
#import "XHAlbumOperationView.h"
#import "XHSendMessageView.h"

#import "XHAlbum.h"

@interface SomethingNewTableViewController : UITableViewController <XHAlbumTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

//数据源
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) XHPhotographyHelper *photographyHelper;
@property (nonatomic, strong) XHAlbumOperationView *operationView;
@property (nonatomic, strong) XHSendMessageView *sendMessageView;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong) UIRefreshControl* refreshControl;
@end
