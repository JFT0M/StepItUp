//
//  HomeViewController.m
//  changer
//
//  Created by syfll on 14-12-2.
//  Copyright (c) 2014年 syfll. All rights reserved.
//

#import "ScheduleViewController.h"
#import "SIUCreateScheduleViewController.h"
#import "SIUMacros.h"
#import "XHPopMenu.h"
#import "LKAlarmMamager.h"
#import "ReminderCell.h"
#import "DWBubbleMenuButton.h"

#define kDefaultAnimationDuration 0.25f
#define FontSize 23.0f

@interface ScheduleViewController (){
    NSMutableDictionary *eventsByDate;
    NSArray * tableViewDateSource;
}
@property (weak, nonatomic) IBOutlet UITableView *scheduleTableView;

@property (nonatomic, strong) XHPopMenu *popMenu;

@end

@implementation ScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setFontFamily:@"FagoOfficeSans-Regular" forView:self.view andSubViews:YES];
    
    //添加日历阴影
    CALayer * calendarLayer = self.calendarContentView.superview.layer;
    //layer.cornerRadius=10;
    calendarLayer.shadowColor=[UIColor blackColor].CGColor;
    //偏移量
    calendarLayer.shadowOffset=CGSizeMake(0, 2);
    calendarLayer.shadowOpacity=0.5;
    calendarLayer.shadowRadius=3;
    //calendarLayer.shadowPath
    
    //添加按钮阴影效果
    CALayer *changeDateBtnLayer = self.changeDateBtn.layer;
    changeDateBtnLayer.shadowColor=[UIColor blackColor].CGColor;
    //偏移量
    changeDateBtnLayer.shadowOffset=CGSizeMake(0, 2);
    changeDateBtnLayer.shadowOpacity=0.5;
    changeDateBtnLayer.shadowRadius=3;
    
    
    //添加 changeDateBtn 响应事件
    [self.changeDateBtn addTarget:self action:@selector(didChangeModeTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //添加分类按钮
    [self createDWBubbleMenuButton];
    
    
    
    
    //设置导航栏
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    //设置日程列表
    [self initScheduleTable];
    self.calendar = [JTCalendar new];
    //self.is_hiden = NO;
    //[self ShowView];
    
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    self.calendarMenuView.backgroundColor =[UIColor clearColor];
    self.calendarContentView.backgroundColor = [UIColor clearColor];
    
    self.backView.backgroundColor = [[UIColor alloc]initWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}
//初始化tableView
-(void)initScheduleTable{
    _scheduleTableView.backgroundColor = [UIColor clearColor];
    [_scheduleTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _scheduleTableView.backgroundView = [[UIView alloc]init];

}
//以前解决抽屉效果bug用的代码
//-(void)HidenView{
//    if (self.is_hiden == NO) {
//        self.is_hiden = YES;
//        //隐藏日历
//        NSMutableArray * views = [self.calendarMenuView getViews];
//        NSMutableArray * viewsD = [self.calendarContentView getViews];
//        for(int i = 0 ; i< views.count;i++)
//        {
//            if (i==1) {
//                UIView *view = views[i];
//                view.hidden = NO;
//            }else{
//                UIView *view = views[i];
//                view.hidden = YES;
//            }
//        }
//        for(int i = 0 ; i< viewsD.count;i++)
//        {
//            if (i==1) {
//                UIView *view = viewsD[i];
//                view.hidden = NO;
//            }else{
//                UIView *view = viewsD[i];
//                view.hidden = YES;
//            }
//        }
//
//
//    }
//    
//}
//-(void)ShowView{
//    if (self.is_hiden == YES) {
//        self.is_hiden =NO;
//        //显示日历
//        NSMutableArray * views = [self.calendarMenuView getViews];
//        NSMutableArray * viewsD = [self.calendarContentView getViews];
//        for (UIView * view in views){
//            view.hidden = NO;
//        }
//        for (UIView * view in viewsD){
//            view.hidden = NO;
//        }
//    }
//
//}

#pragma mark - Action

#pragma mark enterQRCodeController要修改
- (void)enterQRCodeController {

    printf("。。。。");
}

- (void)enterCreateScheduleController {
    [self performSegueWithIdentifier:@"createSchedule" sender:self];
    printf("我要创建日程辣 ：）\n");
}

#pragma mark - 初始化导航
-(void)initMyNaviItem{
//这是旧版本
//    //today button
//    UIButton *myTodayButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    myTodayButton.frame=CGRectMake(0, 0, 30, 30);
//    [myTodayButton setTitle:@"today" forState:UIControlStateNormal];
//    [myTodayButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [myTodayButton addTarget:self action:@selector(didGoTodayTouch:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.titleView = myTodayButton;
//    
//    //change button
//    UIBarButtonItem *changeButton = [[UIBarButtonItem alloc]initWithTitle:@"Change" style:UIBarButtonItemStyleDone target:self action:@selector(didChangeModeTouch:)];
//    NSMutableArray * leftButtons = [[NSMutableArray alloc]init];
//    [leftButtons addObject:changeButton];
//    self.navigationItem.leftBarButtonItems = leftButtons;
//    
//    
//    //add Button
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showMenuOnView:)];
    
    //这是新版本
    UIButton * title = [UIButton buttonWithType:UIButtonTypeSystem];
    title.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    [title setTitle:@"日程" forState:UIControlStateNormal];
    [title setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [title setTintColor:[UIColor whiteColor]];
    self.navigationItem.titleView = title;
    
    
}

-(void)deleteMyNaviItem{
    self.navigationItem.titleView = nil;
    
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.rightBarButtonItem = nil;
}



#pragma mark - Buttons callback
//今天按钮响应
- (void)didGoTodayTouch:(id)sender
{
    [self.calendar setCurrentDate:[NSDate date]];
}

//改变模式按钮响应
- (void)didChangeModeTouch:(id)sender
{
    //更换按钮图片
    if (self.calendar.calendarAppearance.isWeekMode == true) {
        [self.changeDateBtn setImage:[UIImage imageNamed:@"multiply_down"] forState:UIControlStateNormal];
    }else{
        [self.changeDateBtn setImage:[UIImage imageNamed:@"multiply_up"] forState:UIControlStateNormal];
    }
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    [self transitionExample];
}

- (void)showMenuOnView:(UIBarButtonItem *)buttonItem {
    [self.popMenu showMenuOnView:self.view atPoint:CGPointZero];
}


#pragma mark - Propertys
#pragma mark 添加按钮（popMenu）
- (XHPopMenu *)popMenu {
    if (!_popMenu) {
        NSMutableArray *popMenuItems = [[NSMutableArray alloc] initWithCapacity:3];
        for (int i = 0; i < 2; i ++) {
            NSString *imageName;
            NSString *title;
            switch (i) {
                case 0: {
                    imageName = @"contacts_add_newmessage";
                    title = @"添加日程";
                    break;
                }
                case 1: {
                    imageName = @"contacts_add_friend";
                    title = @"发表状态";
                    break;
                }
                default:
                    break;
            }
            XHPopMenuItem *popMenuItem = [[XHPopMenuItem alloc] initWithImage:[UIImage imageNamed:imageName] title:title];
            [popMenuItems addObject:popMenuItem];
        }
        
        WEAKSELF
        _popMenu = [[XHPopMenu alloc] initWithMenus:popMenuItems];
        _popMenu.popMenuDidSlectedCompled = ^(NSInteger index, XHPopMenuItem *popMenuItems) {
            if (index == 1) {
                printf("发表状态 index 1\n");
                //[weakSelf enterQRCodeController];
            }else if (index == 0 ) {
                printf("添加日程 index 0\n");
                [weakSelf enterCreateScheduleController];
            }
        };
    }
    return _popMenu;
}

#pragma mark 分类弹出按钮
-(void)createDWBubbleMenuButton{
    // Create up menu button
    UIImageView *homeLabel = [self createHomeButtonView];
    
    DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - homeLabel.frame.size.width - 20.f,
                                                                                          self.view.frame.size.height - homeLabel.frame.size.height - 60.f,
                                                                                          homeLabel.frame.size.width,
                                                                                          homeLabel.frame.size.height)
                                                            expansionDirection:DirectionUp];
    upMenuView.homeButtonView = homeLabel;
    
    [upMenuView addButtons:[self createDemoButtonArray]];
    
    [self.view addSubview:upMenuView];
}
- (UIImageView *)createHomeButtonView {
    UIImageView *homeView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    [homeView setImage:[UIImage imageNamed:@"multiply_float__touch"]];
    //homeView.backgroundColor = [UIColor blackColor];
    //homeView.layer.cornerRadius = homeView.frame.size.height / 2.f;
    //homeView.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    //homeView.clipsToBounds = YES;
    
    return homeView;
}
- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *imageName in @[@"multipy_float__all", @"multipy_float__calendar", @"multipy_float__sort"]) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        button.tag = i++;
        
        [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}

- (void)test:(UIButton *)sender {
    NSLog(@"Button tapped, tag: %ld", (long)sender.tag);
    switch (sender.tag) {
        case 0:
            //显示所有
            break;
        case 1:
            //显示日历模式
            break;
        case 2:
            //显示分类
            break;
        default:
            break;
    }
}

- (UIButton *)createButtonWithName:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button sizeToFit];
    
    [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}



#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
}
#pragma mark 日期点击回调
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    
    NSLog(@"Date: %@ - %ld events", date, [events count]);
    
    [self getLKAlarmEvents];
    //test
    tableViewDateSource = [self getEventsOneDay:date];
    [self.tableView reloadData];
    //点击日期后改变显示模式
    [self.calendar setCurrentDate: date];
    
    if (!self.calendar.calendarAppearance.isWeekMode) {
        self.calendar.calendarAppearance.isWeekMode = true;
        [self transitionExample];
    }
    
}
#pragma mark 获取提醒events
- (void)getLKAlarmEvents{
    if (!eventsByDate) {
        eventsByDate = [NSMutableDictionary new];
    }
    NSArray * events = [[LKAlarmMamager shareManager]allEvents];
    for (int i = 0; i< events.count; i++) {
        LKAlarmEvent * event = [events objectAtIndex:i];
        NSString *key = [[self dateFormatter] stringFromDate:event.startDate];
        if (!eventsByDate[key]) {
            eventsByDate[key] = [NSMutableDictionary new];
        }
        NSString * eventId = [NSString stringWithFormat: @"%ld", (long)event.eventId];
        eventsByDate[key][eventId] = event;
        NSLog(@"Event: %@ ,Date: %@ ",event.title, key);
        
    }
    NSLog(@"events count %lu",(unsigned long)events.count);
}
- (NSArray *)getEventsOneDay:(NSDate *)date{
    NSArray *events;
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    events = [[NSArray alloc]initWithArray:[(NSMutableDictionary*)eventsByDate[key] allValues]];
    for (LKAlarmEvent *event in events) {
        NSLog(@"Event:%@ - Date:%@",event.title ,key);
    }
    
    return events;
}

#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 180;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 60.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         self.backViewHeight.constant = newHeight + 44;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}

#pragma mark - Fake data

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ReminderCell"];
    if (cell == nil) {
        ReminderCell *reminderCell ;
        LKAlarmEvent * event;
        event = (LKAlarmEvent*)[tableViewDateSource objectAtIndex:indexPath.row];
        if (indexPath.row %2) {
            reminderCell= [ReminderCell CreateCell:LeftReminder content:event.title];
        }else{
            reminderCell= [ReminderCell CreateCell:RightReminder content:event.title];
        }
        
        [reminderCell.cellBtn addTarget:self action:@selector(reminderCellTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        cell = reminderCell;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewDateSource.count;
}
-(void)reminderCellTouchAction:(id)sender{
    NSLog(@"reminderImage Touch Action");
}
#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 65.0;
//}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark - View
-(void)viewWillAppear:(BOOL)animated{
    [self initMyNaviItem];
    [self.tableView reloadData];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [self deleteMyNaviItem];
}
#pragma mark - 页面跳转
- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
    }
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES];
        }
    }
}

@end
