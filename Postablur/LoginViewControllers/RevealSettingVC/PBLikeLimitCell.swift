//
//  PBLikeLimitCell.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/20/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit
protocol PBLikeLimitCellDelegate
{
    func oneLikeDidTap()
    func fiveLikeDidTap()
    func tenLikeDidTap()

}

class PBLikeLimitCell: UITableViewCell {
   
    @IBOutlet weak var oneLikeButton : UIButton!
    @IBOutlet weak var fiveLikeButton : UIButton!
    @IBOutlet weak var tenLikeButton : UIButton!
    var likeLimitDelegate : PBLikeLimitCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func oneLikeBtnAction(_ sender: UIButton)
    {
        if let likeLimitDelegate = self.likeLimitDelegate
        {
            likeLimitDelegate.oneLikeDidTap()
        }
    
    }
    @IBAction func fiveLikeBtnAction(_ sender: UIButton)
    {
        if let likeLimitDelegate = self.likeLimitDelegate
        {
            likeLimitDelegate.fiveLikeDidTap()
        }
    }
    @IBAction func tenLikeBtnAction(_ sender: UIButton)
    {
        if let likeLimitDelegate = self.likeLimitDelegate
        {
            likeLimitDelegate.tenLikeDidTap()
        }
    }
    
}
