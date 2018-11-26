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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.masksToBounds = true
    }

    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    // convenience wrapper to get layer as its statically known type
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }

}
