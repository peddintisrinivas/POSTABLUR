//
//  PBAccountTypeVC.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/19/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit

class PBAccountTypeVC: UIViewController {

    @IBOutlet weak var accountTypeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let headerNib = UINib(nibName: NibNamed.PBHeaderCell.rawValue, bundle: nil)
        self.accountTypeTableView.register(headerNib, forCellReuseIdentifier: CellIdentifiers.PBHeaderCellIdentifier.rawValue)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
// MARK: Tableview Datasource and Delegate
extension PBAccountTypeVC : UITableViewDataSource, UITableViewDelegate
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
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
}
extension PBAccountTypeVC : RegistrationCellDelegate
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

// MARK: --  HEADER DELEGATES
extension PBAccountTypeVC : PBHeaderCellDelegate
{
    func pbBackBtnDidTap()
    {
        _ = self.navigationController?.popViewController(animated: true)
        
    }
}

