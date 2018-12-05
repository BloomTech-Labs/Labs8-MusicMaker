//
//  AddQRPhotoViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/2/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Lottie
import Photos
import FirebaseFirestore

class AddQRPhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationView()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Delegate
    weak var delegate: QRScanning?
    
    // MARK: - Properties
    let animationView = LOTAnimationView(name: "qr_code")
    let database = Firestore.firestore()
    let imagePicker = UIImagePickerController()

    // MARK: - IBOutlets
    @IBOutlet weak var addPhotosButton: UIButton!
    
    // MARK: - Private Methods
    private func setupAnimationView() {
        animationView.frame = self.view.frame
        animationView.center = CGPoint(x: self.view.center.x + self.view.frame.width / 5, y: self.view.center.y - self.view.frame.height / 4.5)
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        view.bringSubviewToFront(addPhotosButton)
    }
    
    private func presentImagePickerController() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            presentInformationalAlertController(title: "Error", message: "The photo library is unavailable")
            return
        }
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Detects a QRCode from a UIImage
    private func detectQRCode(_ image: UIImage?) -> [CIFeature]? {
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
    
    // MARK: - IBActions
    @IBAction func selectPhoto(_ sender: Any) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorizationStatus {
        case .authorized:
            presentImagePickerController()
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization { (status) in
                
                guard status == .authorized else {
                    NSLog("User did not authorize access to the photo library")
                    self.presentInformationalAlertController(title: "Error", message: "In order to access the photo library, you must allow this application access to it.")
                    return
                }
                
                self.presentImagePickerController()
            }
            
        case .denied:
            self.presentInformationalAlertController(title: "Error", message: "In order to access the photo library, you must allow this application access to it.")
        case .restricted:
            self.presentInformationalAlertController(title: "Error", message: "Unable to access the photo library. Your device's restrictions do not allow access.")
            
        }
    }
}

extension AddQRPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func checkImage(image: UIImage) {
        if let features = detectQRCode(image), !features.isEmpty{
            for case let row as CIQRCodeFeature in features{
                if let teacherId = row.messageString {
                    if !teacherId.contains("//") {
                        let teacherReference = database.collection("teachers").document(teacherId)
                        teacherReference.getDocument { (document, error) in
                            if let document = document, document.exists {
                                if let data = document.data(), let name = data["name"] as? [String: String], let firstName = name["firstName"], let lastName = name["lastName"] {
                                    self.animationView.play(completion: { (animationCompleted) in
                                        if animationCompleted {
                                            self.animationView.setProgressWithFrame(0)
                                            self.addPhotosButton.setTitle("\(firstName) \(lastName)", for: .normal)
                                            self.delegate?.qrCodeScanned(teacherId)
                                        }
                                    })
                                }
                            } else {
                                self.addPhotosButton.setTitle("Not a valid QR Code", for: .normal)
                            }
                        }
                    } else {
                        self.addPhotosButton.setTitle("Not a valid QR Code", for: .normal)
                    }
                }
            }
        }
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        dismiss(animated: true) {
            self.checkImage(image: image)
        }
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
}
