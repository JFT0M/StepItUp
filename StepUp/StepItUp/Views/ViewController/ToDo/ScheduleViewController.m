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

#define kDefaultAnimationDuration 0.25f


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
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"主页_01"];
    
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
    
    self.backView.backgroundColor = [UIColor grayColor];
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
    
    //today button
    UIButton *myTodayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myTodayButton.frame=CGRectMake(0, 0, 30, 30);
    [myTodayButton setTitle:@"today" forState:UIControlStateNormal];
    [myTodayButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [myTodayButton addTarget:self action:@selector(didGoTodayTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = myTodayButton;
    
    //change button
    UIBarButtonItem *changeButton = [[UIBarButtonItem alloc]initWithTitle:@"Change" style:UIBarButtonItemStyleDone target:self action:@selector(didChangeModeTouch:)];
    NSMutableArray * leftButtons = [[NSMutableArray alloc]init];
    [leftButtons addObject:changeButton];
    self.navigationItem.leftBarButtonItems = leftButtons;
    
    
    //add Button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showMenuOnView:)];
    
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
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    [self transitionExample];
}

- (void)showMenuOnView:(UIBarButtonItem *)buttonItem {
    [self.popMenu showMenuOnView:self.view atPoint:CGPointZero];
}
#pragma mark - Propertys
#pragma mark 弹出按钮
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

- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}
@end
