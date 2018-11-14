//
//  QRScannerViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/7/18.
//  Copyright © 2018 Vuk. All rights reserved.
//
import UIKit
import AVFoundation



class QRScannerViewController: UIViewController {
    
    
    // MARK: - Properties
    
    /*
     An AVCaptureSession is an object that manages capture activity and coordinates
     the flow of data from input devices to capture outputs
     */
    var captureSession: AVCaptureSession?
    
    /*
     A subclass of CALayer that can display video as it is being captured
     */
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession = AVCaptureSession()
        /*
         An AVCaptureDevice object represents a physical capture device that provides input
         and output such as (video and audio).
         DiscoverySession is a query for finding and monitoring available capture devices
         */
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        
        
        
        //devices is an array of AVCaptureDevices that match the critera from above
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            //Update UI to let user know no device was found
            print("Failed getting a capture device")
            return
        }
        
        
        do {
            /*
             An AVCaptureDeviceInput is a capture input that provides media
             from a capture device to a capture session. Add the input to the
             capture session
             */
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession?.addInput(input)
            
            //Sets the frame for the QR scanner, its invisible since the size is set to
            // zero by default
            
            
        } catch {
            //Update UI to let user know
            print(error)
        }
        
        /*
         An AVCaptureMetadataOutput object intercepts metadata objects
         produced by its associated capture connection and forwards them
         to a delegate object for processing.
         Add this output to to the capture session
         */
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        //The queue sets the dispatch queue which to execute the delegate methods on
        // this queue must be serial to ensure that metadata objects are are delievered
        // in the order they were recieved
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        
        //Only metadata objects whose type matches one of the strings in this property are forwarded to the delegate
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()
        
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.red.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
        
    }
    
    
}


// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            print("No QR code is detected")
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        
        if metadataObject.type == AVMetadataObject.ObjectType.qr {
            let qrCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject)
            qrCodeFrameView?.frame = qrCodeObject!.bounds
            qrCodeFrameView?.flash(completion: { (true) in
                if metadataObject.stringValue != nil {
                    print(metadataObject.stringValue)
                    
                }
            })
        }
        
        
        
    }
    
    
    
    
}


extension UIView {
    
    func flash(completion: @escaping (Bool) -> ()) {
        let flashAnimation = CABasicAnimation(keyPath: "opacity")
        flashAnimation.duration = 1
        flashAnimation.fromValue = 1
        flashAnimation.toValue = 0
        flashAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        flashAnimation.autoreverses = true
        flashAnimation.repeatCount = 3
        layer.add(flashAnimation, forKey: nil)
        completion(true)
    }
}
