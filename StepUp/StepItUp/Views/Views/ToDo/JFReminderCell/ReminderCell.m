//
//  ReminderCell.m
//  Step it up
//
//  Created by syfll on 15/4/5.
//  Copyright (c) 2015年 syfll. All rights reserved.
//

#import "ReminderCell.h"

@implementation ReminderCell

+ (ReminderCell*) CreateCell:(ReminderSide)side content:(NSString*)content
{
    ReminderCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"ReminderCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.cellSide = side;
    UIImage *reminderBackgroundImage ;
    if (cell.cellSide == RightReminder) {
        reminderBackgroundImage = [UIImage imageNamed:@"reminder_right"];
//        reminderBackgroundImage = [reminderBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22)];
        [cell.RightReminderBtn setBackgroundImage:reminderBackgroundImage forState:UIControlStateNormal];
        [cell.RightReminderBtn setBackgroundImage:reminderBackgroundImage forState:UIControlStateHighlighted];
        [cell.leftReminderBtn setHidden:YES];
    }else{
        reminderBackgroundImage = [UIImage imageNamed:@"reminder_left"];
//        reminderBackgroundImage = [reminderBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22)];
        [cell.leftReminderBtn setBackgroundImage:reminderBackgroundImage forState:UIControlStateNormal];
        [cell.leftReminderBtn setBackgroundImage:reminderBackgroundImage forState:UIControlStateHighlighted];
        [cell.RightReminderBtn setHidden:YES];
    }
    
    [cell setTitle:content];
    return cell;
}
-(void)setTitle:(NSString *)text{
    if (self.cellSide == RightReminder) {
        [self.RightReminderBtn setTitle:text forState:UIControlStateNormal];
        [self.RightReminderBtn setTitle:text forState:UIControlStateHighlighted];
        self.RightReminderHeight.constant = 46.f;
    }else{
        [self.leftReminderBtn setTitle:text forState:UIControlStateNormal];
        [self.leftReminderBtn setTitle:text forState:UIControlStateHighlighted];
        self.leftReminderHeight.constant = 80.f;
        
    }
}
-(UIButton*)cellBtn{
    if (self.cellSide == RightReminder) {
        return self.RightReminderBtn;
    }else{
        return self.leftReminderBtn;
    }
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
