//
//  RecordingViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/8/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import PDFKit
import AVFoundation

class RecordingViewController: UIViewController {
    
    enum VideoPosition {
        case topLeft, topRight, bottomLeft, bottomRight
    }
    
    // MARK: - Properties
    
    var pdfDocument: PDFDocument? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var videoPosition: VideoPosition = .bottomRight {
        didSet {
            self.view.setNeedsLayout()
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private var isDraggingVideo = false
    
    private var captureSession: AVCaptureSession!
    private var recordOutput: AVCaptureMovieFileOutput!
    private var lastRecordedURL: URL?
    
    private var panGesture = UIPanGestureRecognizer()
    private var pinchGesture = UIPinchGestureRecognizer()

    // MARK: - Outlets
    
    @IBOutlet weak var pdfView: PDFView! {
        didSet {
            pdfView.displayMode = .singlePage
            pdfView.autoScales = true
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cameraPreviewView: CameraPreviewView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var previousPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func toggleRecord(_ sender: Any) {
        if recordOutput.isRecording {
            recordOutput.stopRecording()
        } else {
            switch UIApplication.shared.statusBarOrientation {
            case .portrait:
                recordOutput.connection(with: .video)?.videoOrientation = .portrait
            case .portraitUpsideDown:
                recordOutput.connection(with: .video)?.videoOrientation = .portraitUpsideDown
            case .landscapeLeft:
                recordOutput.connection(with: .video)?.videoOrientation = .landscapeLeft
            case .landscapeRight:
                recordOutput.connection(with: .video)?.videoOrientation = .landscapeRight
            default:
                //???
                break
            }
            recordOutput.startRecording(to: newRecordingURL(), recordingDelegate: self)
        }
    }
    
    @IBAction func previousPage(_ sender: Any) {
    }
    
    @IBAction func nextPage(_ sender: Any) {
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchedView(_:)))
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        
        cameraPreviewView.isUserInteractionEnabled = true
        cameraPreviewView.addGestureRecognizer(panGesture)
//        cameraPreviewView.addGestureRecognizer(pinchGesture)
        
        // Test
        pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "SamplePDF", withExtension: "pdf")!)
        
        setupCapture()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Setup
        let bounds = view.bounds
        let safeArea = view.safeAreaInsets
        
        let columnWidth: CGFloat = 160.0
        let recordButtonMargin: CGFloat = 20.0
        let recordButtonSize: CGFloat = 100.0
        
        // View Positioning
        switch videoPosition {
        case .topLeft:
            pdfView.frame = CGRect(x: safeArea.left + columnWidth, y: safeArea.top, width: bounds.width - safeArea.left - safeArea.right - columnWidth, height: bounds.height - safeArea.top - safeArea.bottom)
//            goLeftButton.frame = CGRect(x: safeArea.left + columnWidth, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
//            goRightButton.frame = CGRect(x: safeArea.left + columnWidth + (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
            collectionView.frame = CGRect(x: safeArea.left, y: safeArea.top, width: columnWidth, height: bounds.height - safeArea.top)
            collectionView.contentInset = UIEdgeInsets(top: columnWidth, left: 0, bottom: 0, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
            if !isDraggingVideo {
                cameraPreviewView.frame = CGRect(x: safeArea.left, y: safeArea.top, width: columnWidth, height: columnWidth)
            }
            recordButton.frame = CGRect(x: bounds.width - recordButtonMargin - recordButtonSize, y: bounds.height - recordButtonMargin - recordButtonSize, width: recordButtonSize, height: recordButtonSize)
            
        case .topRight:
            pdfView.frame = CGRect(x: 0, y: safeArea.top, width: bounds.width - safeArea.left - safeArea.right - columnWidth, height: bounds.height - safeArea.top - safeArea.bottom)
            collectionView.frame = CGRect(x: bounds.width - safeArea.right - columnWidth, y: safeArea.top, width: columnWidth, height: bounds.height - safeArea.top)
            collectionView.contentInset = UIEdgeInsets(top: columnWidth, left: 0, bottom: 0, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
            if !isDraggingVideo {
                cameraPreviewView.frame = CGRect(x: bounds.width - safeArea.right - columnWidth, y: safeArea.top, width: columnWidth, height: columnWidth)
            }
            recordButton.frame = CGRect(x: recordButtonMargin, y: bounds.height - recordButtonMargin - recordButtonSize, width: recordButtonSize, height: recordButtonSize)
            
        case .bottomLeft:
            pdfView.frame = CGRect(x: safeArea.left + columnWidth, y: safeArea.top, width: bounds.width - safeArea.left - safeArea.right - columnWidth, height: bounds.height - safeArea.top - safeArea.bottom)
            collectionView.frame = CGRect(x: safeArea.left, y: safeArea.top, width: columnWidth, height: bounds.height - safeArea.top)
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: columnWidth, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
            if !isDraggingVideo {
                cameraPreviewView.frame = CGRect(x: safeArea.left, y: bounds.height - columnWidth, width: columnWidth, height: columnWidth)
            }
            recordButton.frame = CGRect(x: bounds.width - recordButtonMargin - recordButtonSize, y: bounds.height - recordButtonMargin - recordButtonSize, width: recordButtonSize, height: recordButtonSize)
            
        case .bottomRight:
            pdfView.frame = CGRect(x: 0, y: safeArea.top, width: bounds.width - safeArea.left - safeArea.right - columnWidth, height: bounds.height - safeArea.top - safeArea.bottom)
            collectionView.frame = CGRect(x: bounds.width - safeArea.right - columnWidth, y: safeArea.top, width: columnWidth, height: bounds.height - safeArea.top)
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: columnWidth, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
            if !isDraggingVideo {
                cameraPreviewView.frame = CGRect(x: bounds.width - safeArea.right - columnWidth, y: bounds.height - columnWidth, width: columnWidth, height: columnWidth)
            }
            recordButton.frame = CGRect(x: recordButtonMargin, y: bounds.height - recordButtonMargin - recordButtonSize, width: recordButtonSize, height: recordButtonSize)
        }
        
        // Camera orientation
        switch UIApplication.shared.statusBarOrientation {
        case .portrait:
            cameraPreviewView.videoPreviewLayer.connection?.videoOrientation = .portrait
        case .portraitUpsideDown:
            cameraPreviewView.videoPreviewLayer.connection?.videoOrientation = .portraitUpsideDown
        case .landscapeLeft:
            cameraPreviewView.videoPreviewLayer.connection?.videoOrientation = .landscapeLeft
        case .landscapeRight:
            cameraPreviewView.videoPreviewLayer.connection?.videoOrientation = .landscapeRight
        default:
            //???
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        captureSession.stopRunning()
    }
    
    // MARK: - Methods
    
    private func setupCapture() {
        let captureSession = AVCaptureSession()
        let device = bestCamera()
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: device), captureSession.canAddInput(videoDeviceInput) else { fatalError() }
        
        captureSession.addInput(videoDeviceInput)
        
        let fileOutput = AVCaptureMovieFileOutput() // creates a movie file
        guard captureSession.canAddOutput(fileOutput) else { fatalError() } // make sure we can add it to captureSession
        captureSession.addOutput(fileOutput)
        recordOutput = fileOutput
        
        captureSession.sessionPreset = .hd1920x1080 // easier to filter with core image and process
        captureSession.commitConfiguration() // save all this stuff and actually set it up
        
        self.captureSession = captureSession    // starts off not running, so need to start it in viewWillAppear()
        cameraPreviewView.videoPreviewLayer.session = captureSession  // display the capture
    }
    
    private func bestCamera() -> AVCaptureDevice { // might need to change for ipad?
        // can allow user to choose different types of camera: dual, front, back
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            return device
        } else {
            fatalError("Missing expected front camera device")
        }
    }

    // Want to save record url directly to core data, for now this is for testing
    // save the recording as a uuid in core data, but gives back url so we can store the recording
    
    // setup the directory to return a url so we can use it to store the recording
    private func newRecordingURL() -> URL {
        let fm = FileManager.default
        let documentsDir = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        return documentsDir.appendingPathComponent(UUID().uuidString).appendingPathExtension("mov")
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        let recordingButtonImageName = recordOutput.isRecording ? "Stop" : "Record"
        recordButton.setImage(UIImage(named: recordingButtonImageName)!, for: .normal)
    }
    
    @objc private func draggedView(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view)
        cameraPreviewView.center = location
        
        if sender.state == .began {
            isDraggingVideo = true
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.cameraPreviewView.layer.cornerRadius = 10
                self.cameraPreviewView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.cameraPreviewView.alpha = 0.8
            }, completion: nil)
        } else if sender.state == .ended || sender.state == .cancelled {
            isDraggingVideo = false
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.cameraPreviewView.layer.cornerRadius = 0
                self.cameraPreviewView.transform = CGAffineTransform.identity
                self.cameraPreviewView.alpha = 1.0
            }, completion: nil)
        }
        
        // set the video position
        let bounds = self.view.bounds
        
        if location.x < bounds.width/2.0 { // left side
            if location.y < bounds.height/2.0 { // top
                videoPosition = .topLeft
            } else { // bottom
                videoPosition = .bottomLeft
            }
        } else { // right side
            if location.y < bounds.height/2.0 { // top
                videoPosition = .topRight
            } else { // bottom
                videoPosition = .bottomRight
            }
        }
    }
    
    @objc private func pinchedView(_ sender:UIPinchGestureRecognizer){
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
        }
    }
}

extension RecordingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pdfDocument?.pageCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicSheetPageCell", for: indexPath) as! MusicSheetPageCollectionViewCell
        
        cell.pdfView.document = pdfDocument!
        
        if let pdfPage = pdfDocument?.page(at: indexPath.item) {
            cell.pdfView.go(to: pdfPage)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? MusicSheetPageCollectionViewCell else { return }
        
        pdfView.document = cell.pdfView.document
        pdfView.go(to: cell.pdfView!.currentPage!)
        
    }
}

extension RecordingViewController: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        DispatchQueue.main.async {
            self.updateViews()
        }
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        DispatchQueue.main.async {
            self.updateViews()
            
            self.lastRecordedURL = outputFileURL
        }
    }
}
