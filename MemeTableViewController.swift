//
//  MemeTableViewController.swift
//  MemeMeApp
//
//  Created by Mikaila Akeredolu on 4/1/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

 var memesObject:[MemeClass]!
    
    
    @IBOutlet weak var tableView: UITableView!
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memesObject = (UIApplication.sharedApplication().delegate as AppDelegate).appDelegateMemes

        self.tableView.reloadData()
        
    }
    
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
      /* let object = UIApplication.sharedApplication().delegate
        
        let appDelegate = object as AppDelegate */
        
//        memesObject = (UIApplication.sharedApplication().delegate as AppDelegate).appDelegateMemes
      
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableView Data Sources
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int{
        
 //return 5 - this worked
        
        return self.memesObject.count
        

        
    }
    
   
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell{
      
        //set up custom cell
        
        var cell:MemeTableViewCell = tableView.dequeueReusableCellWithIdentifier("myTableViewCell") as MemeTableViewCell
        
        var myMemes = self.memesObject[indexPath.row]
        
       // println("test") and test commit - this works
        
        // Set the name and image
        cell.Top.text = myMemes.topTextField
        cell.Bottom.text = myMemes.bottomTextField
        cell.imageForTable.image = myMemes.memedImage
        
        
        return cell
        
    }
    
    //UITableViewDelegate
    
    func tableView(tableView:UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
      //NOt yet implemented
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
