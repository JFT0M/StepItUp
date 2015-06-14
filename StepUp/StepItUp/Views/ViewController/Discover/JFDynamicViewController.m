//
//  JFDynamicViewController.m
//  StepUp
//
//  Created by syfll on 15/6/14.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "JFDynamicViewController.h"
#import "UIViewController+ScrollingNavbar.h"

@interface JFDynamicViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSArray* data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JFDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc",@"aaaa",@"bbbb",@"cccc"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self followScrollView:self.tableView withDelay:60];
    [self setUseSuperview:YES];
    //这句代码可以使上方tabbar也隐藏
    //[self setScrollableViewConstraint:self.topConstraint withOffset:49];
    [self setShouldScrollWhenContentFits:NO];
    
    [self setScrollingNavbarDelegate:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
    }
    
    cell.textLabel.text = self.data[indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)navigationBarDidChangeToExpanded:(BOOL)expanded {
    if (expanded) {
        NSLog(@"Nav changed to expanded");
    }
}

- (void)navigationBarDidChangeToCollapsed:(BOOL)collapsed {
    if (collapsed) {
        NSLog(@"Nav changed to collapsed");
    }
}

- (void)stopScroll {
    [self setScrollingEnabled:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:animated];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    // This enables the user to scroll down the navbar by tapping the status bar.
    [self showNavbar];
    
    return YES;
}

- (void)dealloc {
    [self stopFollowingScrollView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
