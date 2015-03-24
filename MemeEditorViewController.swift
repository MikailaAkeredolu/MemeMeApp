//
//  MemeEditorViewController.swift
//  MemeMeApp
//
//  Created by Mikaila Akeredolu on 3/23/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import UIKit
import MobileCoreServices

class MemeEditorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    
    @IBOutlet weak var topTextFieldOutlet: UITextField!
    
    
    @IBOutlet weak var bottomTextFieldOutlet: UITextField!
    
    
     override func viewDidLoad() {
        super.viewDidLoad()

        // Set Text properties
        
        self.topTextFieldOutlet.text =  "TOP"
        self.topTextFieldOutlet.textAlignment = NSTextAlignment.Center
        
       //TODO: Defaultattribute Text - Impact font , Caps, color
        

        
        self.bottomTextFieldOutlet.text = "BOTTOM"
        self.bottomTextFieldOutlet.textAlignment = NSTextAlignment.Center
        
         //TODO: Defaultattribute Text - Impact font , Caps, color
        
    }

        
    @IBAction func cameraButton(sender: UIBarButtonItem) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
        
        //launch uiimagePicker Controller
        
        let camerapickerController = UIImagePickerController()
        camerapickerController.delegate = self
        
        camerapickerController.sourceType = UIImagePickerControllerSourceType.Camera
        
        //set up the media types as an array that holds [anyobject]
        let mediaTypes:[AnyObject] = [kUTTypeImage] //represents imagedata
        camerapickerController.mediaTypes = mediaTypes
        camerapickerController.allowsEditing = true
        
        self.presentViewController(camerapickerController, animated: true, completion: nil)
        
        }else{
            //alert if camera is not available
            
            var alertController = UIAlertController(title: "Alert", message: "Your device does not have a camera", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        

    }
    

    @IBAction func albumButton(sender: UIBarButtonItem) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
        
        //launch uiimagePicker Controller
        
        let albumpickerController = UIImagePickerController()
        albumpickerController.delegate = self
        
        albumpickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        //set up the media types as an array that holds [anyobject]
        let mediaTypes:[AnyObject] = [kUTTypeImage] //represents imagedata
        albumpickerController.mediaTypes = mediaTypes
        albumpickerController.allowsEditing = true
        
        self.presentViewController(albumpickerController, animated: true, completion: nil)
       
        }else{
            //alert if camera is not available
            var alertController = UIAlertController(title: "Alert", message: "Your device does not support the photo library", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
                      
        }

    }
    
        //Image Picker Controller Delegate Method
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        //when we select an image..it will be stored here in constant -- 
        
        if  let image = info[UIImagePickerControllerEditedImage] as? UIImage{ //specify as UIImage
            
            self.imageViewOutlet.image = image
            
        }else{
            
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
             self.imageViewOutlet.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
 
       
    }
    
    //Image Picker Controller Delegate Method
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
          self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func viewWillAppear(animated: Bool) {
        
        var cameraButton = UIBarButtonItem()
             cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }

    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        
      // self.navigationController?.popToRootViewControllerAnimated(true)
        

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
