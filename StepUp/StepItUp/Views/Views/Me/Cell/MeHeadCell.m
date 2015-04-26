//
//  GFCell.m
//  Page4
//
//  Created by chenLong on 15/4/5.
//  Copyright (c) 2015年 chenLong. All rights reserved.
//

#import "MeHeadCell.h"

@implementation MeHeadCell

@synthesize guanZhu, fenSi, xianXi, sex;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
     
    }
    return self;
}

//-(id)init{
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
