//
//  MyCell.m
//  Page4
//
//  Created by chenLong on 15/4/5.
//  Copyright (c) 2015年 chenLong. All rights reserved.
//
#import "MeSelectCell.h"

@implementation MeSelectCell

@synthesize label1,imageView1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
