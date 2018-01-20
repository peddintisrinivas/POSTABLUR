//
//  PBLoginOptionsVC.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/18/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit

class PBLoginOptionsVC: UIViewController
{

    @IBOutlet weak var loginTableView: UITableView!
    
    var appdelegate : AppDelegate!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        let logoNib = UINib(nibName: NibNamed.PBLogoCell.rawValue, bundle: nil)
        self.loginTableView.register(logoNib, forCellReuseIdentifier: CellIdentifiers.LogoHeaderReuseIdentifier.rawValue)
        
        let emailNib = UINib(nibName: NibNamed.PBEmailAndPasswrdCell.rawValue, bundle: nil)
        self.loginTableView.register(emailNib, forCellReuseIdentifier: CellIdentifiers.EmailAndPasswrdReuseIdentifier.rawValue)
        
        let socialNib = UINib(nibName: NibNamed.PBSocialLoginCell.rawValue, bundle: nil)
        self.loginTableView.register(socialNib, forCellReuseIdentifier: CellIdentifiers.SocialReuseIdentifier.rawValue)
        
    }
    
   
}
// MARK: Tableview Datasource and Delegate
extension PBLoginOptionsVC : UITableViewDataSource, UITableViewDelegate
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
            return Constants.calculateDynamicTableviewCellHeight(cellHeight: 262.0)

        }
        else if indexPath.section == 1
        {
            return  Constants.calculateDynamicTableviewCellHeight(cellHeight: 145.0)
        }
        else{
            return  Constants.calculateDynamicTableviewCellHeight(cellHeight: 150.0)
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
            let cell : PBLogoCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.LogoHeaderReuseIdentifier.rawValue, for: indexPath) as! PBLogoCell
            return cell
            
        case 1:
            let cell : PBEmailAndPasswrdCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.EmailAndPasswrdReuseIdentifier.rawValue, for: indexPath) as! PBEmailAndPasswrdCell
            cell.emailDelegate = self
            return cell
            
        case 2:
            let cell : PBSocialLoginCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.SocialReuseIdentifier.rawValue, for: indexPath) as! PBSocialLoginCell
            cell.socialLoginDelegate = self
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
   
}
// MARK: --  EMAIL AND PASSWORD DELEGATES
extension PBLoginOptionsVC : PBEmailAndPasswrdCellDelegate
{
    func pbLoginBtnDidTap(emailTextField: UITextField, passwordTextField: UITextField)
    {
        if (emailTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)!
        {
            self.appdelegate.alert(vc: self, message: "Enter email and password", title: "SignIn")
            return
        }
        if (emailTextField.text?.isEmpty)!
        {
            self.appdelegate.alert(vc: self, message: "Enter email", title: "SignIn")
            return
        }
        if !ValidationHelper.isValidEmail(emailStr: emailTextField.text!)
        {
            self.appdelegate.alert(vc: self, message: "Enter valid email", title: "SignIn")
            return
        }
        if (passwordTextField.text?.isEmpty)!
        {
            self.appdelegate.alert(vc: self, message: "Enter password", title: "SignIn")
            return
        }
        
        let urlString = String(format: "%@/LoginVerify", arguments: [Urls.mainUrl]);
        let requestDict = ["Username":emailTextField.text,"Password":passwordTextField.text]
        
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
  
    func pbForgetPasswordDidTap()
    {
        
    }
    
}

// MARK: --  SOCIAL LOGIN DELEGATES
extension PBLoginOptionsVC : PBSocialLoginCellDelegate
{
    func pbCreateBtnDidTap()
    {
        let signUpVC = PBSignUPVC()
        self.navigationController?.pushViewController(signUpVC, animated: true);
        
    }
    func pbTwitterBtnDidTap()
    {
        
    }
    func pbfaceBookBtnDidTap()
    {
        
    }
    
}

