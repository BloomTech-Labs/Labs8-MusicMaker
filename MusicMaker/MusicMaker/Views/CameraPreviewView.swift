//
//  CameraPreviewView.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/8/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPreviewView: UIView {
    
    var imageCover: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.masksToBounds = true
        
        imageCover = UIImageView(frame: bounds)
        imageCover.backgroundColor = .darkGray
        imageCover.image = #imageLiteral(resourceName: "VideoInterruption")
        imageCover.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageCover.isHidden = true
        self.addSubview(imageCover)
    }

    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    // convenience wrapper to get layer as its statically known type
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }

}
