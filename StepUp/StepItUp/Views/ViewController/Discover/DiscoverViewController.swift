//
//  DiscoverViewController.swift
//  StepUp
//
//  Created by syfll on 15/4/21.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

import UIKit


class DiscoverViewController: UITableViewController {
    
    let SomethingNewIdentifier = "showSomethingNewIdentifier"
    
    var dataArray = ["关注动态","同城活动","热门日程","发现"]
    var searchBar :UISearchBar?
    var searchDisplay :UISearchDisplayController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        searchBar = UISearchBar(frame: CGRectMake(0, 0, self.tableView.bounds.width, 20))
        searchDisplay = UISearchDisplayController(searchBar: self.searchBar, contentsController: self)
        self.tableView.tableHeaderView = searchBar
        
        var view:UIView? = UIView()
        view!.backgroundColor = UIColor.clearColor()
        self.tableView.tableFooterView = view!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        var groupHeadView = UITableViewHeaderFooterView()
        
        //groupHeadView.contentView.backgroundColor = UIColor.clearColor()
        return groupHeadView
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let MyCellIdentifier = "MeSelectCell"
        var cell:MeSelectCell? = tableView .dequeueReusableCellWithIdentifier(MyCellIdentifier) as? MeSelectCell
        if cell == nil {
            var topLevelObjects:NSArray = NSBundle.mainBundle().loadNibNamed("MeSelectCell", owner: nil, options: nil)
            for   currentObject in topLevelObjects{
                if currentObject.isKindOfClass(MeSelectCell.classForCoder()){
                    cell = currentObject as MeSelectCell;
                    break;
                }
            }
        }
        cell?.label1.text = dataArray[indexPath.section]
        return cell!;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.row == 0 && indexPath.section == 0{
            self.performSegueWithIdentifier(SomethingNewIdentifier, sender: self)
        }else {
            println("row is:%d , section is :%d",indexPath.row,indexPath.section)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
