//
//  QRScannerViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/2/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        qrView.setupCaptureSession()
        qrView.captureSession?.startRunning()
        let captureMetadataOutput = AVCaptureMetadataOutput()
        qrView.captureSession?.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var centerView: UIView! {
        didSet {
            centerView.layer.borderColor = UIColor.white.cgColor
            centerView.layer.borderWidth = 5.0
            centerView.layer.cornerRadius = 5.0
        }
    }
    @IBOutlet weak var qrView: QRView!
    
    // MARK: - Properties
    private var player: AVAudioPlayer?


}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        if metadataObjects.count == 0 {
            return
        }
    
        guard let metadataObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {return}
        
        if metadataObject.type == AVMetadataObject.ObjectType.qr {
            if let qrCodeString = metadataObject.stringValue {
                print(qrCodeString)
                qrView.captureSession?.stopRunning()
                playSound()
            }
        }
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "scannedSound", withExtension: "mp3") else {
            print("url not found")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
}
