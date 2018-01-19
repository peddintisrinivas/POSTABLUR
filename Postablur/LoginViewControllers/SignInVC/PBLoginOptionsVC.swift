//
//  PBLoginOptionsVC.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/18/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit

class PBLoginOptionsVC: UIViewController {

    @IBOutlet weak var loginTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoNib = UINib(nibName: NibNamed.PBLogoCell.rawValue, bundle: nil)
        self.loginTableView.register(logoNib, forCellReuseIdentifier: CellIdentifiers.LogoHeaderReuseIdentifier.rawValue)
        
        let emailNib = UINib(nibName: NibNamed.PBEmailAndPasswrdCell.rawValue, bundle: nil)
        self.loginTableView.register(emailNib, forCellReuseIdentifier: CellIdentifiers.EmailAndPasswrdReuseIdentifier.rawValue)
        
        let socialNib = UINib(nibName: NibNamed.PBSocialLoginCell.rawValue, bundle: nil)
        self.loginTableView.register(socialNib, forCellReuseIdentifier: CellIdentifiers.SocialReuseIdentifier.rawValue)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            return Constants.calculateDynamicTableviewCellHeight(cellHeight: 249.0)

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
    func pbLoginBtnDidTap()
    {
        
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

