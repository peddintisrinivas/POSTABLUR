//
//  AddProfilePhotoCell.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/18/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit

protocol AddProfilePhotoCellDelegate {
    
    func pbCaptureAPhotoBtnDidTap()
    
    func pbUploadAPhotoBtnDidTap()

}
class AddProfilePhotoCell: UITableViewCell {

    var delegate : AddProfilePhotoCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func captureBtnAction(_ sender: UIButton)
    {
        if let delegate = self.delegate
        {
            delegate.pbCaptureAPhotoBtnDidTap()
            
        }
    }
    @IBAction func uploadBtnAction(_ sender: UIButton)
    {
        if let delegate = self.delegate
        {
            delegate.pbUploadAPhotoBtnDidTap()
            
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
