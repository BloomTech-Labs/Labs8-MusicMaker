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

    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    // convenience wrapper to get layer as its statically known type
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }

}
