//
//  QRScannerViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/30/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class QRScannerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let features = detectQRCode(UIImage(named: "testQR")), !features.isEmpty{
            for case let row as CIQRCodeFeature in features{
                print(row.messageString ?? "nope")
            }
        }
        // Do any additional setup after loading the view.
    }
    

    func detectQRCode(_ image: UIImage?) -> [CIFeature]? {
        if let image = image, let ciImage = CIImage.init(image: image){
            var options: [String: Any]
            let context = CIContext()
            options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)){
                options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
            }else {
                options = [CIDetectorImageOrientation: 1]
            }
            let features = qrDetector?.features(in: ciImage, options: options)
            return features
            
        }
        return nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
