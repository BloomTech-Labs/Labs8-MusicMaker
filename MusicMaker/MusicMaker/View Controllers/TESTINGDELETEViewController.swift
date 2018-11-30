//
//  TESTINGDELETEViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/30/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class TESTINGDELETEViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        qrView.setupCaptureSession()
        qrView.captureSession?.startRunning()
    }
    
    @IBOutlet weak var qrView: QRView!
    
    @IBOutlet weak var centerQR: UIView! {
        didSet {
            centerQR.layer.cornerRadius = 10
            centerQR.layer.borderWidth = 5.0
            centerQR.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }


}
