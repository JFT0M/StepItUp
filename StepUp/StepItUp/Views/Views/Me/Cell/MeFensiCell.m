//
//  MeFensiCell.m
//  StepUp
//
//  Created by chenLong on 15/4/25.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "MeFensiCell.h"

#define FenSiName_Font [UIFont systemFontOfSize:17]
#define FenSiShuoShuo_Font [UIFont systemFontOfSize:12]

@implementation MeFensiCell

@synthesize photo,name,sex,shuoshuo,sixin;

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // NSLog(@"cellForRowAtIndexPath");
    static NSString *identifier = @"MeFensiCell";
    // 1.缓存中取
    MeFensiCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if(cell == nil){
        NSLog(@"New Cell Made");
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MeFensiCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[MeFensiCell class]])
            {
                cell = (MeFensiCell *)currentObject;
                break;
            }
        }
                
    }
    cell.photo.layer.masksToBounds = YES;
    cell.photo.layer.cornerRadius = 25;
    return cell;
}

-(void)setData:(UIImage*)inImage name:(NSString*)inName  sex:(NSInteger*)inSex shoushou:(NSString*)inShuoShuo{
    self.name.text = inName;
    CGSize sizeOfName = [self sizeWithString:inName font:FenSiName_Font maxSize:CGSizeMake(135, 20)];
    self.name.frame = CGRectMake(65, 8, sizeOfName.width, sizeOfName.height);
    
    self.sex.frame = CGRectMake(name.frame.origin.x + name.frame.size.width + 5, 11, 13, 13);
//    [self.sex setFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 5, 11, 13, 13)];
    

}

/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        NSLog(@"******************************");
//        self.photo.layer.masksToBounds = YES;
//        self.photo.layer.cornerRadius = 25;
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
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
