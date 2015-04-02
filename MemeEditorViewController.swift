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
    
    
    @IBOutlet weak var cancelButtonOutlet: UIBarButtonItem!
    
    
    @IBOutlet weak var cameraButtonOutlet: UIBarButtonItem!
    
    
    @IBOutlet weak var shareButtonOutlet: UIBarButtonItem!
    
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
     override func viewDidLoad() {
        super.viewDidLoad()

        // Set Text properties
        
        self.topTextFieldOutlet.text =  "TOP"
        
        self.bottomTextFieldOutlet.text = "BOTTOM"
   
        
         //TODO: Defaultattribute Text - Impact font , Caps, color
        
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(), //TODO: Fill in appropriate UIColor,
            NSForegroundColorAttributeName : UIColor.whiteColor(), //TODO: Fill in UIColor,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0 //TODO: Fill in appropriate Float
        ]
        
        self.topTextFieldOutlet.defaultTextAttributes = memeTextAttributes
        self.topTextFieldOutlet.textAlignment = NSTextAlignment.Center
        
        self.bottomTextFieldOutlet.defaultTextAttributes = memeTextAttributes
        self.bottomTextFieldOutlet.textAlignment = NSTextAlignment.Center
        
        //disable sharing
        self.shareButtonOutlet.enabled = false
        
    }
    
    //create function that initializes a memeModel
    
    func save(){
        //create the meme
        
        var memeObject = MemeClass(textTop: self.topTextFieldOutlet!, textBottom: self.bottomTextFieldOutlet!, image: self.imageViewOutlet.image!, mImage: self.generateMemedImage())
       
    //add it to memes array on the application delegate NOT SURE WHATS GOING ON

        let object = UIApplication.sharedApplication().delegate
        
        let appDelegate = object as AppDelegate
        
        appDelegate.appDelegateMemes.append(memeObject)
        
        
    }
    
    
    func generateMemedImage()->UIImage{
        
        //hide tool and nav bar
        
        self.navigationController?.navigationBarHidden = true
        
        self.bottomToolBar.hidden = true
        
        
        //render view to an image
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        self.view.drawViewHierarchyInRect(self.view.frame,  afterScreenUpdates: true)
        
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.navigationController?.navigationBarHidden = false
        
        self.bottomToolBar.hidden = false
        
        return memedImage
        
    }

    
    
    //keyboard resign firs responder
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true;
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
            
               self.shareButtonOutlet.enabled = true
        
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
            
               self.shareButtonOutlet.enabled = true
       
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
        
       // disable camera button and share button below
        
            self.cameraButtonOutlet.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)

        
        
        //sign up to be notified when keyboard appears
        super.viewWillAppear(animated)
        
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardwilhideNotifications()
    }

    //create and subcribe to notification function to be called in viewWillAppear
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
    }
    
    
    //create and Subscribe to the keyboard notification: UIKeyboardWillHideNotification
    
    func subscribeToKeyboardwilhideNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
        
        
        
    }

    

    // call unsuscribe methods
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unsubscribeFromKeyboardNotifications()
        self.unsubscribeFromKeyboardwillhideNotifications()
    }
    
    //unsuscribe from notification function to be called in viewWillDisAppear
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
    }
    
    
    
    //unsuscribe from keyborad will hide notificaton in view will dissapear
    func unsubscribeFromKeyboardwillhideNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
   // When the keyboardWillShow notification is received, shift the view's frame up
    
    func keyboardWillShow(notification: NSNotification) {
    
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    
    
   // Write the method “keyboardWillHide” to move the view frame down a distance equal to the keyboardHeight.
    
    
    func keyboardWillHide(notification: NSNotification) {
        
         self.view.frame.origin.y += setKeyboardHeight(notification)
        
        }
  
   
    
    func setKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        
      // self.navigationController?.popToRootViewControllerAnimated(true)

    }
    
    
     @IBAction func shareButton(sender: UIBarButtonItem) {
        
        self.shareButtonOutlet.enabled = true
    
        //generate a memed image
        
        self.generateMemedImage()
        
        let memeToShare = [self.generateMemedImage()] //make this an array
        
        let activityVC = UIActivityViewController(activityItems: memeToShare, applicationActivities: nil)
        
        
        //implement completion handler
                                                            //parameters
        activityVC.completionWithItemsHandler = {activity,completed,items,error in
        
            //statements
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        
        
        
        }
        

            self.presentViewController(activityVC, animated: true, completion:nil)
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
