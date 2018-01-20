//
//  AddProfilePhotoCell.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/18/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit

protocol AddProfilePhotoCellDelegate
{
    
    func pbCaptureAPhotoBtnDidTap(capturedPhotoWidth: CGFloat,capturedPhotoHeight: CGFloat)
    
    func pbUploadAPhotoBtnDidTap(uploadPhotoWidth: CGFloat,uploadPhotoHeight: CGFloat)

}
class AddProfilePhotoCell: UITableViewCell
{

    @IBOutlet var captureBtn: UIButton!
    
    
    @IBOutlet var uploadBtn: UIButton!
    var delegate : AddProfilePhotoCellDelegate? = nil

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func captureBtnAction(_ sender: UIButton)
    {
        if let delegate = self.delegate
        {
            delegate.pbCaptureAPhotoBtnDidTap(capturedPhotoWidth: captureBtn.frame.width, capturedPhotoHeight: captureBtn.frame.height)
            
        }
    }
    @IBAction func uploadBtnAction(_ sender: UIButton)
    {
        if let delegate = self.delegate
        {
            delegate.pbUploadAPhotoBtnDidTap(uploadPhotoWidth: uploadBtn.frame.width, uploadPhotoHeight: uploadBtn.frame.height)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
