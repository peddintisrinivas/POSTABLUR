//
//  PBSignUPVC.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/18/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit

class PBSignUPVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{

    @IBOutlet weak var signUpTableView: UITableView!
    var imageWidth : CGFloat!
    var imageHeight : CGFloat!
    
    var appdelegate : AppDelegate!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        let headerNib = UINib(nibName: NibNamed.PBHeaderCell.rawValue, bundle: nil)
        self.signUpTableView.register(headerNib, forCellReuseIdentifier: CellIdentifiers.PBHeaderCellIdentifier.rawValue)
        
        let addProfileNib = UINib(nibName: NibNamed.AddProfilePhotoCell.rawValue, bundle: nil)
        self.signUpTableView.register(addProfileNib, forCellReuseIdentifier: CellIdentifiers.AddProfilePhotoCellIdentifier.rawValue)
        
        let registrationNib = UINib(nibName: NibNamed.RegistrationCell.rawValue, bundle: nil)
        self.signUpTableView.register(registrationNib, forCellReuseIdentifier: CellIdentifiers.RegistrationCellIdentifier.rawValue)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PBSignUPVC.keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PBSignUPVC.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tapRecogniser: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PBSignUPVC.tapGestureRecognized))
        self.signUpTableView.addGestureRecognizer(tapRecogniser)

    }
    @objc internal func tapGestureRecognized()
    {
        UIView.animate(withDuration: 0.2, animations: {
           
            self.signUpTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        })
    }
    
    
    @objc internal func keyboardWasShown(aNotification: NSNotification)
    {
        UIView.animate(withDuration: 0.2, animations: {

        if let keyboardHeight = (aNotification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            self.signUpTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
            }
        })

    }
    @objc internal func keyboardWillBeHidden(aNotification: NSNotification)
    {
        UIView.animate(withDuration: 0.2, animations: {
            
            self.signUpTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        })
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

 
}

extension PBSignUPVC : UITextFieldDelegate{
    
    // MARK: Textfield Delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: Tableview Datasource and Delegate
extension PBSignUPVC : UITableViewDataSource, UITableViewDelegate
{
    // MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return  Constants.calculateDynamicTableviewCellHeight(cellHeight: 113.0)
        }
        else if indexPath.section == 1
        {
            return  Constants.calculateDynamicTableviewCellHeight(cellHeight: 178.0)
        }
        else{
            return  Constants.calculateDynamicTableviewCellHeight(cellHeight: 350.0)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
    {
        switch indexPath.section
        {
            
        case 0:
            let cell : PBHeaderCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.PBHeaderCellIdentifier.rawValue, for: indexPath) as! PBHeaderCell
            cell.delegate = self
            return cell
            
        case 1:
            let cell : AddProfilePhotoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.AddProfilePhotoCellIdentifier.rawValue, for: indexPath) as! AddProfilePhotoCell
            cell.delegate = self
            return cell
            
        case 2:
            let cell : RegistrationCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.RegistrationCellIdentifier.rawValue, for: indexPath) as! RegistrationCell
            cell.registerDelegate = self
            cell.userNameTF.delegate = self
            cell.emailTF.delegate = self
            cell.passwordTF.delegate = self
            cell.reTypePasswordTF.delegate = self
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    // MARK: Image picker delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any])
    {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            let resizedImage = chosenImage.resizeImage(image: chosenImage, newWidth: self.imageWidth)!
            self.uploadprofileImageToServer(selectedImage: resizedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadprofileImageToServer(selectedImage : UIImage)
    {
         let urlString = Urls.uploadImageUrl
         let requestDict = ["UploadContent":"","Mediatype":"1"]
        
        
    }
}

// MARK: --  HEADER DELEGATES
extension PBSignUPVC : PBHeaderCellDelegate
{
    func pbBackBtnDidTap()
    {
        _ = self.navigationController?.popViewController(animated: true)
        
    }
}

// MARK: --  ADDPROFILE DELEGATES
extension PBSignUPVC : AddProfilePhotoCellDelegate
{
    func pbCaptureAPhotoBtnDidTap(capturedPhotoWidth: CGFloat,capturedPhotoHeight: CGFloat)
    {
        self.imageWidth = capturedPhotoWidth
        self.imageHeight = capturedPhotoHeight
        let pbImagePickerController = UIImagePickerController()
        pbImagePickerController.delegate = self
        pbImagePickerController.allowsEditing = true
        pbImagePickerController.sourceType = UIImagePickerControllerSourceType.camera
        present(pbImagePickerController, animated: true, completion: nil)
    }
    
    func pbUploadAPhotoBtnDidTap(uploadPhotoWidth: CGFloat, uploadPhotoHeight: CGFloat)
    {
        self.imageWidth = uploadPhotoWidth
        self.imageHeight = uploadPhotoHeight
        let pbImagePickerController = UIImagePickerController()
        pbImagePickerController.delegate = self
        pbImagePickerController.allowsEditing = true
        pbImagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(pbImagePickerController, animated: true, completion: nil)
        
    }
}


// MARK: -- REGISTRATION DELEGATES
extension PBSignUPVC : RegistrationCellDelegate
{
    func pbnextBtnDidTap(userNameTF: UITextField, emailTF: UITextField, passwordTF: UITextField, reTypePasswordTF: UITextField)
    {
        if (userNameTF.text?.isEmpty)! && (emailTF.text?.isEmpty)! && (passwordTF.text?.isEmpty)! && (reTypePasswordTF.text?.isEmpty)!
        {
             self.appdelegate.alert(vc: self, message: "Enter all fields", title: "SignUp")
             return
        }
        
        if (userNameTF.text?.isEmpty)!
        {
            self.appdelegate.alert(vc: self, message: "Enter username", title: "SignUp")
            return
        }
        
        if (emailTF.text?.isEmpty)!
        {
            self.appdelegate.alert(vc: self, message: "Enter email", title: "SignUp")
            return
        }
        
        if !ValidationHelper.isValidEmail(emailStr: (emailTF.text)!)
        {
            self.appdelegate.alert(vc: self, message: "Enter valid email", title: "SignUp")
            return
        }
        
        if (passwordTF.text?.isEmpty)!
        {
            self.appdelegate.alert(vc: self, message: "Enter password", title: "SignUp")
            return
        }
            
        if (reTypePasswordTF.text?.isEmpty)!
        {
            self.appdelegate.alert(vc: self, message: "Enter retype password", title: "SignUp")
            return
        }
            
        if (passwordTF.text?.count)! < 6
        {
            self.appdelegate.alert(vc: self, message: "Password minimum 6 digits", title: "SignUp")
            return
        }
        
        if (passwordTF.text) != (reTypePasswordTF.text)
        {
            self.appdelegate.alert(vc: self, message: "Both passwords must same", title: "SignUp")
            return
        }
            
        let urlString = String(format: "%@/UserRegistration", arguments: [Urls.mainUrl]);
        let requestDict = ["UserName":userNameTF.text!,"Email":emailTF.text!,"Password":passwordTF.text!,"DOB":"","DBAPin":"","Profileurl":"need to send",
            "ProfileAd":"","Accounttype":"1","PhoneNumber":"","CountryCode":"+91","Registrationtype":"1",
            "DeviceId":"123456","DeviceType":"1"] as [String : Any]
        
        self.appdelegate.showActivityIndictor(titleString: "SignIn", subTitleString: "")
        
        PBServiceHelper().post(url: urlString, parameters: requestDict as NSDictionary) { (responseObject : AnyObject?, error : Error?) in
            
            self.appdelegate.hideActivityIndicator()
            if error == nil
            {
                if responseObject != nil
                {
                    if let responseDict = responseObject as? [String : AnyObject]
                    {
                        if let resultArray = responseDict["Results"] as! [NSDictionary]!
                        {
                            let result = resultArray.first!
                            
                            let statusCode = result["StatusCode"] as! String
                            let statusMessage = result["StatusMsg"] as! String
                            
                            if statusCode == "0"
                            {
                                self.appdelegate.alert(vc: self, message: statusMessage, title: "SignIn")
                                return
                            }
                            else
                            {
                                self.appdelegate.alert(vc: self, message: statusMessage, title: "SignIn")
                                return
                            }
                            
                        }
                    }
                    if let responseStr = responseObject as? String
                    {
                        self.appdelegate.alert(vc: self, message: responseStr, title: "SignIn")
                        return
                    }
                    
                }
                else
                {
                    self.appdelegate.alert(vc: self, message: "Something went wrong", title: "SignIn")
                    return
                }
            }
            else
            {
                self.appdelegate.alert(vc: self, message: (error?.localizedDescription)!, title: "SignIn")
                return
            }
           
        }
    }
        

    func pbloginBtnDidTap()
    {
        
    }
}


