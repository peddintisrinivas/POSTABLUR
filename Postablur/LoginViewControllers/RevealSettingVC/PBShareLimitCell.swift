//
//  PBShareLimitCell.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/20/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit
protocol PBShareLimitCellDelegate
{
    func oneShareDidTap()
    func fiveShareDidTap()
    func tenShareDidTap()
    
}
class PBShareLimitCell: UITableViewCell {

    @IBOutlet weak var oneShareButton : UIButton!
    @IBOutlet weak var fiveShareButton : UIButton!
    @IBOutlet weak var tenShareButton : UIButton!
    var shareLimitDelegate : PBShareLimitCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func oneShareBtnAction(_ sender: UIButton)
    {
        if let shareLimitDelegate = self.shareLimitDelegate
        {
            shareLimitDelegate.oneShareDidTap()
        }
        
    }
    @IBAction func fiveLikeBtnAction(_ sender: UIButton)
    {
        if let shareLimitDelegate = self.shareLimitDelegate
        {
            shareLimitDelegate.fiveShareDidTap()
        }
    }
    @IBAction func tenLikeBtnAction(_ sender: UIButton)
    {
        if let shareLimitDelegate = self.shareLimitDelegate
        {
            shareLimitDelegate.tenShareDidTap()
        }
    }
    
}
