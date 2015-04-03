//
//  MemeTableViewController.swift
//  MemeMeApp
//
//  Created by Mikaila Akeredolu on 4/1/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
  
    var memes:[MemeClass]!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        memes = applicationDelegate.memes
        

        self.tableView.reloadData()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableView Data Sources
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int{
        
 //return 5 - this worked
        
        return self.memes.count
 
    }
    
   
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell{
      
        //set up custom cell
        
        var cell:MemeTableViewCell = tableView.dequeueReusableCellWithIdentifier("myTableViewCell") as MemeTableViewCell
        
        var myMemes = self.memes[indexPath.row]
        
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
    instntiate vc
    var controller:MemeEditorViewController
    controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
    
    
    self.presentViewController(controller, animated: true, completion: nil)
    
    */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
