//
//  PBSignUPVC.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/18/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit

class PBSignUPVC: UIViewController {

    @IBOutlet weak var signUpTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNib = UINib(nibName: NibNamed.PBHeaderCell.rawValue, bundle: nil)
        self.signUpTableView.register(headerNib, forCellReuseIdentifier: CellIdentifiers.PBHeaderCellIdentifier.rawValue)
        
        let addProfileNib = UINib(nibName: NibNamed.AddProfilePhotoCell.rawValue, bundle: nil)
        self.signUpTableView.register(addProfileNib, forCellReuseIdentifier: CellIdentifiers.AddProfilePhotoCellIdentifier.rawValue)
        
        let registrationNib = UINib(nibName: NibNamed.RegistrationCell.rawValue, bundle: nil)
        self.signUpTableView.register(registrationNib, forCellReuseIdentifier: CellIdentifiers.RegistrationCellIdentifier.rawValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
}
// MARK: -- REGISTRATION DELEGATES
extension PBSignUPVC : RegistrationCellDelegate
{
    func pbnextBtnDidTap()
    {
        let accountTypeVC = PBAccountTypeVC()
        self.navigationController?.pushViewController(accountTypeVC, animated: true);

    }
    func pbloginBtnDidTap()
    {
        
    }
}

// MARK: --  ADDPROFILE DELEGATES
extension PBSignUPVC : AddProfilePhotoCellDelegate
{
    func pbCaptureAPhotoBtnDidTap()
    {
        
    }
    
    func pbUploadAPhotoBtnDidTap()
    {
        
        
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

