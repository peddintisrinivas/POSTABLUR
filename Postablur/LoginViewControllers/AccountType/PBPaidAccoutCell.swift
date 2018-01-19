//
//  PBPaidAccoutCell.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/19/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit

protocol PBPaidAccoutCellDelegate {
    
    func pbnextBtnDidTap()
    
}

class PBPaidAccoutCell: UITableViewCell {

    var paidDelegate : PBPaidAccoutCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func nextBtnAction(_ sender: UIButton)
    {
        if let paidDelegate = self.paidDelegate
        {
            paidDelegate.pbnextBtnDidTap()
            
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
