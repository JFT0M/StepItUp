//
//  ViewController.m
//  Page4
//
//  Created by chenLong on 15/4/5.
//  Copyright (c) 2015年 chenLong. All rights reserved.
//

#import "MeViewController.h"
#import "MeHeadCell.h"
#import "MeSelectCell.h"
#import "GuanZhuViewController.h"
#import "FenSiTableViewController.h"

@implementation MeViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
   self.tableView.delegate = self;
    //    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
//    self.view.backgroundColor = [UIColor blackColor];
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath section] ==0){
        static NSString *MyCellIdentifier = @"MeHeadCell";
        MeHeadCell *cell = (MeHeadCell*) [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
        cell.photo.layer.masksToBounds = YES;
        cell.photo.layer.cornerRadius = 40;
        if(cell == nil){
            NSLog(@"New Cell Made");
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MeHeadCell" owner:nil options:nil];
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[MeHeadCell class]])
                {
                    cell = (MeHeadCell *)currentObject;
                    
                    cell.photo.layer.masksToBounds = YES;
                    
                    cell.photo.layer.cornerRadius = 40;
                    
                    cell.photo.userInteractionEnabled = YES;
                    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
                    [cell.photo addGestureRecognizer:singleTap];
                    
                    cell.guanZhu.userInteractionEnabled = YES;
                    UITapGestureRecognizer *singleTapOnGuanZhu = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapOnGuanZhu:)];
                    [cell.guanZhu addGestureRecognizer:singleTapOnGuanZhu];
                    
                    cell.fenSi.userInteractionEnabled = YES;
                    UITapGestureRecognizer *singleTapOnFenSi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapOnFenSi:)];
                    [cell.fenSi addGestureRecognizer:singleTapOnFenSi];

       
                    break;
                }
            }
            
        }
        
        return cell;
        
    }
    static NSString *MyCellIdentifier = @"MeSelectCell";
    
    MeSelectCell *cell = (MeSelectCell*) [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    if(cell == nil){
        NSLog(@"New Cell Made");
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MeSelectCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[MeSelectCell class]])
            {
                cell = (MeSelectCell *)currentObject;
                break;
            }
        }
        
    }
    
    //    switch ([indexPath section]) {
    //        case 1:{
    //            [[cell label1] setText:@"日程收藏"];
    //        }
    //
    //            break;
    //
    //        case 2:{
    //            //              [[cell imageView1] setImage:);
    //            [[cell label1] setText:@"消息"];
    //        }
    //
    //            break;
    //        default:
    //            //              [[cell imageView1] setImage:;
    //            [[cell label1] setText:@"设置"];
    //            break;
    //    }
    return cell;

}

-(void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"!@!@!@!@!@!@!@!@!@!@!@!@");
    
}

-(void)singleTapOnGuanZhu:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"2232323232323");
    
    GuanZhuViewController *guanzhu = [[GuanZhuViewController alloc] init];
    [self.navigationController pushViewController:guanzhu animated:true];
    
}

-(void)singleTapOnFenSi:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"777777777777");
    
    FenSiTableViewController *fensi = [[FenSiTableViewController alloc] init];
    [self.navigationController pushViewController:fensi animated:true];
    
}

//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    //    if([indexPath section] == 0)
    //        return cell.frame.size.height - 30;
    return cell.frame.size.height;
}


@end












































