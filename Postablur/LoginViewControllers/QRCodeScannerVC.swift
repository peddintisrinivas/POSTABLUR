//
//  QRCodeScannerVC.swift
//  Postablur
//
//  Created by Srinivas Peddinti on 1/20/18.
//  Copyright © 2018 MobiwareInc. All rights reserved.
//

import UIKit

class QRCodeScannerVC: UIViewController {
    @IBOutlet weak var qrCodeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var scansCountLbl: UILabel!
    @IBOutlet weak var scannerImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let fontSmallSize = ((UIScreen.main.bounds.size.width) / CGFloat(414.0)) * 18
        let roundedSmallfontSize = floor(fontSmallSize)
        
        let fontBoldSize = ((UIScreen.main.bounds.size.width) / CGFloat(414.0)) * 48
        let roundedBoldfontSize = floor(fontBoldSize)
        
        self.qrCodeLbl.font = self.qrCodeLbl.font.withSize(roundedBoldfontSize)
        self.nameLbl.font = self.nameLbl.font.withSize(roundedSmallfontSize)
        self.scansCountLbl.font = self.scansCountLbl.font.withSize(roundedSmallfontSize)

        let tapRecogniser: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(QRCodeScannerVC.tapGestureRecognized))
        self.scannerImage.addGestureRecognizer(tapRecogniser)

    }

    @objc internal func tapGestureRecognized()
    {

        let revealSettingsVC = RevealSettingsVC()
        self.navigationController?.pushViewController(revealSettingsVC, animated: true)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

}
