//
//  GuanZhuViewController.m
//  StepUp
//
//  Created by chenLong on 15/4/25.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

#import "GuanZhuViewController.h"
#import "MeFensiCell.h"
#import "IMChat.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface GuanZhuViewController ()

@end

@implementation GuanZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *MyCellIdentifier = @"MeFensiCell";
//    
//    MeFensiCell *cell = (MeFensiCell*) [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
//    
//    if(cell == nil){
//        NSLog(@"New Cell Made");
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MeFensiCell" owner:nil options:nil];
//        for(id currentObject in topLevelObjects)
//        {
//            if([currentObject isKindOfClass:[MeFensiCell class]])
//            {
//                cell = (MeFensiCell *)currentObject;
//                break;
//            }
//        }
//        
//    }
    MeFensiCell *cell = [MeFensiCell cellWithTableView:tableView];
    NSString * name = [NSString stringWithFormat:@"我的好友%d号", indexPath.row];
    
    [cell setData:nil name:name sex:1 shoushou:nil];
    
    cell.sixin.frame = CGRectMake(SCREEN_WIDTH-cell.sixin.frame.size.width-15, (cell.frame.size.height-cell.sixin.frame.size.height)/2, cell.sixin.frame.size.width, cell.sixin.frame.size.height);
    
//    
//    NSLog(@"@@@@@@@@@name.x: %f, name.y: %f, name.width: %f, name.heignt: %f",cell.sex.frame.origin.x,cell.sex.frame.origin.y,cell.sex.frame.size.width,cell.sex.frame.size.height);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了%d", indexPath.row);
//    IMChat *liaoTian = [[IMChat alloc] init];
//    [self.navigationController pushViewController:liaoTian
//                                         fanimated:true];
    IMChat *ickImageViewController = [[IMChat alloc] init];
    [self presentModalViewController:ickImageViewController animated:YES];
    //返回
//    [self dismissModalViewControllerAnimated:YES];
}


//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    //    if([indexPath section] == 0)
    //        return cell.frame.size.height - 30;
    return cell.frame.size.height;
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
