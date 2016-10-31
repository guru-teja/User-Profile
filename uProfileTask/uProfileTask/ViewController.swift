//
//  ViewController.swift
//  uProfileTask
//
//  Created by Ganesh on 8/28/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var btnClick: UIButton!
    @IBOutlet var img: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!

    var userdata = [[String:AnyObject]]()
    var arr: NSArray?
    var dict: NSDictionary?
    var canedit: Bool?
    let limitLength = 10
    var cval = 0
    var numberChange: String!
    var plistPathInDocument:String = String()
    var notesArray:NSMutableArray!
    var plistPath:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        imagePicker.delegate = self
        img.image = UIImage(named:"defaultimage")
        let paths1 = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentDirectory = paths1.objectAtIndex(0) as! NSString
        let path = documentDirectory.stringByAppendingPathComponent("details.plist")

        let fileManager = NSFileManager.defaultManager()
        if(!fileManager.fileExistsAtPath(path)) {
            if let bundlePath = NSBundle.mainBundle().pathForResource("details", ofType: "plist") {
                
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle GameData.plist file is --> \(resultDictionary?.description)")
                do
                    {
                        try
                fileManager.copyItemAtPath(bundlePath, toPath: path)
                }
                catch{ print("you got an error")}
                print("copy")
            } else {
                print("file not found.")
            }
        } else {
            print("file already exits")
            
        }
        
        let dict = NSDictionary(contentsOfFile: path)
        userdata = dict!.objectForKey("RowDetails") as! [[String:AnyObject]]
}

    let imagePicker = UIImagePickerController()
    
    @IBAction func btnClick(sender: UIButton) {
        
        btnClick.setTitle("CHANGE PICTURE", forState: UIControlState.Normal)
   
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
        self.view.addSubview(img)
        
        self.view.sendSubviewToBack(img)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img.contentMode = .ScaleAspectFit
            img.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userdata.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.scrollEnabled = false;
        
        let rowDict = self.userdata[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! TableViewCell
        
        cell.layer.cornerRadius=10
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.selected = false
        cell.detailType!.text = rowDict["Label"] as? String
        cell.textField!.text = rowDict["KeyName"] as? String
        cell.textField.userInteractionEnabled = false
        cell.editButton.hidden = !(rowDict["CanEdit"] as? Bool)!
 
        return cell
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("TextField should end editing method called")
        numberChange = textField.text!
         cval = numberChange.characters.count
       // print("value in number \(numberChange), \(cval)")
        return true;
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 10
        let currentString: NSString = textField.text!
        let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
 
    
    @IBAction func tick(sender: UIButton) {
        
     //   print("hello\(cval)")
        if (cval == 10)
        {
        self.view.endEditing(true)
        let paths1 = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentDirectory = paths1.objectAtIndex(0) as! NSString
        let path = documentDirectory.stringByAppendingPathComponent("details.plist")
        var phoneData = userdata[2] 
        phoneData["KeyName"] = numberChange
        userdata[2] = phoneData
        let data:NSMutableDictionary = NSMutableDictionary(dictionary:["RowDetails":userdata])
        data.writeToFile(path, atomically: true)
        let alert = UIAlertController(title: "Alert", message: "Saved successfully", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        }
        else if(cval < 10 || cval > 10)
        {
            let alert = UIAlertController(title: "Alert", message: " Contact Not Changed.\nPlease Enter 10 digits only", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        
        }
        }
    
    
    @IBAction func cross(sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Not Saved", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
}
