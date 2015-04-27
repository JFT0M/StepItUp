//
//  MeFensiCell.h
//  StepUp
//
//  Created by chenLong on 15/4/25.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeFensiCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *sex;
@property (strong, nonatomic) IBOutlet UILabel *shuoshuo;
@property (strong, nonatomic) IBOutlet UIImageView *sixin;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

-(void)setData:(UIImage*)inImage name:(NSString*)inName  sex:(NSInteger*)inSex shoushou:(NSString*)inShuoShuo;
@end
