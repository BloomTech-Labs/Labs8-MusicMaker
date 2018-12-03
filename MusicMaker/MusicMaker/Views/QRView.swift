//
//  QRView.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/20/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import AVFoundation

class QRView: UIView {

    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    // MARK: - Properties
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }

    var captureSession: AVCaptureSession?

    // MARK: - Methods
    func setupCaptureSession() {
        captureSession = AVCaptureSession()
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            //Update UI to let user know no device was found
            print("Failed getting a capture device")
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession?.addInput(input)
        } catch {
            print(error)
        }
        videoPreviewLayer.session = captureSession!
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.layer.masksToBounds = true
//        self.layer.cornerRadius = 20
    }
    
}
