//
//  ReminderCell.h
//  Step it up
//
//  Created by syfll on 15/4/5.
//  Copyright (c) 2015年 syfll. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    LeftReminder,
    RightReminder
}ReminderSide;
@interface ReminderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *RightReminderBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftReminderBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftReminderHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RightReminderHeight;
@property (nonatomic) ReminderSide cellSide;
+ (ReminderCell*) CreateCell:(ReminderSide)side content:(NSString*)content;
-(UIButton*)cellBtn;
@end
