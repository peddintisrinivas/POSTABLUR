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

    }

    @objc internal func tapGestureRecognized()
    {

        let revealSettingsVC = RevealSettingsVC()
        self.navigationController?.pushViewController(revealSettingsVC, animated: true)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   

}
