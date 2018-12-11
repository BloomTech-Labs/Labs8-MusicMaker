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
    
    var assignment: Assignment?
    
    var pdfDocument: PDFDocument? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var pdfPage: PDFPage? {
        didSet {
            guard let pdfPage = pdfPage else { return }
            pdfView?.go(to: pdfPage)
        }
    }
    
    private var videoPosition: VideoPosition = .topLeft {
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
    
    private var panGesture = UIPanGestureRecognizer()
    private var pinchGesture = UIPinchGestureRecognizer()
    
    var shouldShowCamera = false

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
    @IBOutlet weak var closeButton: UIButton!
    
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
            
            // method returns optional url
            guard let localRecordingURL = assignment?.createLocalRecordingURL() else {
                // let user know that we can't record right now because core data is very confused
                return
            }
            
            recordOutput.startRecording(to: localRecordingURL, recordingDelegate: self)
        }
    }
    
    @IBAction func previousPage(_ sender: Any) {
        pdfView.goToPreviousPage(sender)
        
        if let pdfDocument = pdfDocument, let pdfPage = pdfView.currentPage {
            // Manually select the page to highlight
            collectionView.selectItem(at: IndexPath(item: pdfDocument.index(for: pdfPage), section: 0), animated: true, scrollPosition: .top)
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        pdfView.goToNextPage(sender)
        
        if let pdfDocument = pdfDocument, let pdfPage = pdfView.currentPage {
            // Manually select the page to highlight
            collectionView.selectItem(at: IndexPath(item: pdfDocument.index(for: pdfPage), section: 0), animated: true, scrollPosition: .top)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchedView(_:)))
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        
        cameraPreviewView.isUserInteractionEnabled = true
        cameraPreviewView.addGestureRecognizer(panGesture)
//        cameraPreviewView.addGestureRecognizer(pinchGesture)
        
        collectionView.reloadData()
        
        pdfView.document = pdfDocument
        
        if let pdfPage = pdfPage, let pdfDocument = pdfDocument {
            pdfView.go(to: pdfPage)
            
            // Manually select the page to highlight
            collectionView.selectItem(at: IndexPath(item: pdfDocument.index(for: pdfPage), section: 0), animated: false, scrollPosition: .top)
        }
        
        setupCapture()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Setup
        let bounds = view.bounds
        let safeArea = view.safeAreaInsets
        
        let columnWidth: CGFloat = 160.0
        let recordButtonMargin: CGFloat = 20.0
        let recordButtonSize: CGFloat = 80.0
        let closeButtonMargin: CGFloat = 10.0
        let closeButtonSize: CGFloat = 60.0
        
        if shouldShowCamera {
            // View Positioning
            switch videoPosition {
            case .topLeft:
                pdfView.frame = CGRect(x: safeArea.left + columnWidth, y: safeArea.top, width: bounds.width - safeArea.left - safeArea.right - columnWidth, height: bounds.height - safeArea.top - safeArea.bottom)
                previousPageButton.frame = CGRect(x: safeArea.left + columnWidth, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
                nextPageButton.frame = CGRect(x: safeArea.left + columnWidth + (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
                closeButton.frame = CGRect(x: safeArea.left + columnWidth + closeButtonMargin, y: safeArea.top + closeButtonMargin, width: closeButtonSize, height: closeButtonSize)
                collectionView.frame = CGRect(x: safeArea.left, y: safeArea.top, width: columnWidth, height: bounds.height - safeArea.top)
                collectionView.contentInset = UIEdgeInsets(top: columnWidth, left: 0, bottom: 0, right: 0)
                collectionView.scrollIndicatorInsets = collectionView.contentInset
                if !isDraggingVideo {
                    cameraPreviewView.isHidden = false
                    cameraPreviewView.frame = CGRect(x: safeArea.left, y: safeArea.top, width: columnWidth, height: columnWidth)
                }
                
                recordButton.isHidden = false
                recordButton.frame = CGRect(x: bounds.width - recordButtonMargin - recordButtonSize, y: bounds.height - recordButtonMargin - recordButtonSize, width: recordButtonSize, height: recordButtonSize)
                
            case .topRight:
                pdfView.frame = CGRect(x: 0, y: safeArea.top, width: bounds.width - safeArea.left - safeArea.right - columnWidth, height: bounds.height - safeArea.top - safeArea.bottom)
                previousPageButton.frame = CGRect(x: safeArea.left, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
                nextPageButton.frame = CGRect(x: safeArea.left + (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
                closeButton.frame = CGRect(x: safeArea.left + closeButtonMargin, y: safeArea.top + closeButtonMargin, width: closeButtonSize, height: closeButtonSize)
                collectionView.frame = CGRect(x: bounds.width - safeArea.right - columnWidth, y: safeArea.top, width: columnWidth, height: bounds.height - safeArea.top)
                collectionView.contentInset = UIEdgeInsets(top: columnWidth, left: 0, bottom: 0, right: 0)
                collectionView.scrollIndicatorInsets = collectionView.contentInset
                if !isDraggingVideo {
                    cameraPreviewView.isHidden = false
                    cameraPreviewView.frame = CGRect(x: bounds.width - safeArea.right - columnWidth, y: safeArea.top, width: columnWidth, height: columnWidth)
                }
                
                recordButton.isHidden = false
                recordButton.frame = CGRect(x: recordButtonMargin, y: bounds.height - recordButtonMargin - recordButtonSize, width: recordButtonSize, height: recordButtonSize)
                
            case .bottomLeft:
                pdfView.frame = CGRect(x: safeArea.left + columnWidth, y: safeArea.top, width: bounds.width - safeArea.left - safeArea.right - columnWidth, height: bounds.height - safeArea.top - safeArea.bottom)
                previousPageButton.frame = CGRect(x: safeArea.left + columnWidth, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
                nextPageButton.frame = CGRect(x: safeArea.left + columnWidth + (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
                closeButton.frame = CGRect(x: safeArea.left + columnWidth + closeButtonMargin, y: safeArea.top + closeButtonMargin, width: closeButtonSize, height: closeButtonSize)
                collectionView.frame = CGRect(x: safeArea.left, y: safeArea.top, width: columnWidth, height: bounds.height - safeArea.top)
                collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: columnWidth, right: 0)
                collectionView.scrollIndicatorInsets = collectionView.contentInset
                if !isDraggingVideo {
                    cameraPreviewView.isHidden = false
                    cameraPreviewView.frame = CGRect(x: safeArea.left, y: bounds.height - columnWidth, width: columnWidth, height: columnWidth)
                }
                
                recordButton.isHidden = false
                recordButton.frame = CGRect(x: bounds.width - recordButtonMargin - recordButtonSize, y: bounds.height - recordButtonMargin - recordButtonSize, width: recordButtonSize, height: recordButtonSize)
                
            case .bottomRight:
                pdfView.frame = CGRect(x: 0, y: safeArea.top, width: bounds.width - safeArea.left - safeArea.right - columnWidth, height: bounds.height - safeArea.top - safeArea.bottom)
                previousPageButton.frame = CGRect(x: safeArea.left, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
                nextPageButton.frame = CGRect(x: safeArea.left + (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
                closeButton.frame = CGRect(x: safeArea.left + closeButtonMargin, y: safeArea.top + closeButtonMargin, width: closeButtonSize, height: closeButtonSize)
                collectionView.frame = CGRect(x: bounds.width - safeArea.right - columnWidth, y: safeArea.top, width: columnWidth, height: bounds.height - safeArea.top)
                collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: columnWidth, right: 0)
                collectionView.scrollIndicatorInsets = collectionView.contentInset
                if !isDraggingVideo {
                    cameraPreviewView.isHidden = false
                    cameraPreviewView.frame = CGRect(x: bounds.width - safeArea.right - columnWidth, y: bounds.height - columnWidth, width: columnWidth, height: columnWidth)
                }
                
                recordButton.isHidden = false
                recordButton.frame = CGRect(x: recordButtonMargin, y: bounds.height - recordButtonMargin - recordButtonSize, width: recordButtonSize, height: recordButtonSize)
            }
        } else {
            pdfView.frame = CGRect(x: safeArea.left + columnWidth, y: safeArea.top, width: bounds.width - safeArea.left - safeArea.right - columnWidth, height: bounds.height - safeArea.top - safeArea.bottom)
            previousPageButton.frame = CGRect(x: safeArea.left + columnWidth, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
            nextPageButton.frame = CGRect(x: safeArea.left + columnWidth + (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, y: safeArea.top, width: (bounds.width - safeArea.left - safeArea.right - columnWidth)/2.0, height: bounds.height - safeArea.top - safeArea.bottom)
            closeButton.frame = CGRect(x: safeArea.left + columnWidth + closeButtonMargin, y: safeArea.top + closeButtonMargin, width: closeButtonSize, height: closeButtonSize)
            collectionView.frame = CGRect(x: safeArea.left, y: safeArea.top, width: columnWidth, height: bounds.height - safeArea.top)
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
            cameraPreviewView.isHidden = true
            recordButton.isHidden = true
        }
        
        pdfView.minScaleFactor = 0.01
        pdfView.scaleFactor = pdfView.scaleFactorForSizeToFit
        
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
        
        // Video capture
        let videoDevice = bestCamera()
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice), captureSession.canAddInput(videoDeviceInput) else { fatalError("We probably don't have camera access") }
        captureSession.addInput(videoDeviceInput)
        
        // Audio capture
        guard let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio) else { fatalError("Missing audio device") }
        guard let audioDeviceInput = try? AVCaptureDeviceInput(device: audioDevice), captureSession.canAddInput(audioDeviceInput) else { fatalError("We probably don't have microphone access") }
        captureSession.addInput(audioDeviceInput)
        
        let fileOutput = AVCaptureMovieFileOutput() // creates a movie file
        guard captureSession.canAddOutput(fileOutput) else { fatalError() } // make sure we can add it to captureSession
        captureSession.addOutput(fileOutput)
        recordOutput = fileOutput
        
        if captureSession.canSetSessionPreset(.hd1920x1080) {
            captureSession.sessionPreset = .hd1920x1080
        } else if captureSession.canSetSessionPreset(.hd1280x720) {
            captureSession.sessionPreset = .hd1280x720
        } else {
            captureSession.sessionPreset = .high
        }
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
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        recordButton.isSelected = recordOutput.isRecording
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
        }
    }
}
