//
//  SignUpViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/7/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import AVFoundation
import UIKit.UIGestureRecognizerSubclass

class SignUpViewController: UIViewController {
    
    // MARK: - Animations
    @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            
            // start the animations
            animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
            
            // pause all animations, since the next event may be a pan changed
            runningAnimators.forEach { $0.pauseAnimation() }
            
            // keep track of each animator's progress
            animationProgress = runningAnimators.map { $0.fractionComplete }
            
        case .changed:
            
            // variable setup
            let translation = recognizer.translation(in: popupView)
            var fraction = translation.y / popupOffset
            
            // adjust the fraction for the current state and reversed state
            if currentState == .open { fraction *= -1 }
            if runningAnimators[0].isReversed { fraction *= -1 }
            
            // apply the new fraction
            for (index, animator) in runningAnimators.enumerated() {
                animator.fractionComplete = fraction + animationProgress[index]
            }
            
        case .ended:
            
            // variable setup
            let yVelocity = recognizer.velocity(in: popupView).y
            let shouldClose = yVelocity > 0
            
            // if there is no motion, continue all animations and exit early
            if yVelocity == 0 {
                runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
                break
            }
            
            // reverse the animations based on their current state and pan motion
            switch currentState {
            case .open:
                if !shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            case .closed:
                if shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if !shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            }
            
            // continue all animations
            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
            
        default:
            ()
        }
    }
    
    /// Animates the transition, if the animation is not already running.
    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
        
        // ensure that the animators array is empty (which implies new animations need to be created)
        guard runningAnimators.isEmpty else { return }
        
        // an animator for the transition
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.qrView.isHidden = false
                self.bottomConstraint.constant = 0
                self.popupView.layer.cornerRadius = 30
//                self.closedTitleLabel.transform = CGAffineTransform(scaleX: 1.6, y: 1.6).concatenating(CGAffineTransform(translationX: 0, y: 15))
//                self.openTitleLabel.transform = .identity
                
            case .closed:
                //                self.videoPreviewLayer?.isHidden = true
                self.qrView.isHidden = true
                self.bottomConstraint.constant = self.popupOffset
                self.popupView.layer.cornerRadius = 0
//                self.closedTitleLabel.transform = .identity
//                self.openTitleLabel.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(CGAffineTransform(translationX: 0, y: -15))
            }
            self.view.layoutIfNeeded()
        })
        
        // the transition completion block
        transitionAnimator.addCompletion { position in
            
            // update the state
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
                //                self.videoPreviewLayer?.isHidden = self.currentState == .open ? false : true
                self.qrView.isHidden = self.currentState == .open ? false : true
            case .current:
                ()
            }
            
            // manually reset the constraint positions
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = self.popupOffset
            }
            
            // remove all running animators
            self.runningAnimators.removeAll()
            
        }
        
        // an animator for the title that is transitioning into view
        let inTitleAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeIn, animations: {
            switch state {
            case .open:
                //                self.videoPreviewLayer?.isHidden = false
                self.qrView.isHidden = false
//                self.openTitleLabel.alpha = 1
            case .closed:
                //                self.videoPreviewLayer?.isHidden = true
                self.qrView.isHidden = true
//                self.closedTitleLabel.alpha = 1
            }
        })
        inTitleAnimator.scrubsLinearly = false
        
        // an animator for the title that is transitioning out of view
        let outTitleAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeOut, animations: {
            switch state {
            case .open:
                //                self.videoPreviewLayer?.isHidden = false
                self.qrView.isHidden = false
//                self.closedTitleLabel.alpha = 0
            case .closed:
                //                self.videoPreviewLayer?.isHidden = true
                self.qrView.isHidden = true
//                self.openTitleLabel.alpha = 0
            }
        })
        outTitleAnimator.scrubsLinearly = false
        
        // start all animators
        transitionAnimator.startAnimation()
        inTitleAnimator.startAnimation()
        outTitleAnimator.startAnimation()
        
        // keep track of all running animators
        runningAnimators.append(transitionAnimator)
        runningAnimators.append(inTitleAnimator)
        runningAnimators.append(outTitleAnimator)
    }

    // MARK: - Enumerations
    private enum State {
        case open
        case closed
        
        var opposite: State {
            switch self {
            case .open: return .closed
            case .closed: return .open
            }
        }
        
    }
    
    // MARK: - Properties
    private lazy var panRecognizer: InstantPanGestureRecognizer = {
        let recognizer = InstantPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        return recognizer
    }()
    
    private let popupOffset: CGFloat = -440
    private var currentState: State = .closed {
        didSet {
            if currentState == .open {
                qrView.isHidden = false
            } else {
                qrView.isHidden = true
            }
        }
    }
    
    /// All of the currently running animators.
    private var runningAnimators = [UIViewPropertyAnimator]()
    
    /// The progress of each animator. This array is parallel to the `runningAnimators` array.
    private var animationProgress = [CGFloat]()
    
    
    var player: AVAudioPlayer?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissKeyboardGestureRecognizer()
        qrView.setupCaptureSession()
        let captureMetadataOutput = AVCaptureMetadataOutput()
        qrView.captureSession?.addOutput(captureMetadataOutput)
        
        //The queue sets the dispatch queue which to execute the delegate methods on
        // this queue must be serial to ensure that metadata objects are are delievered
        // in the order they were recieved
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //Only metadata objects whose type matches one of the strings in this property are forwarded to the delegate
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
        
        qrView.isHidden = true
        qrView.captureSession?.startRunning()
    }
    
    //Adds an observer to listen for the keyboardWillShowNotification & keyboardWillHideNotifcation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    
    //Removes the observer for the keyboardWillShowNotification & keyboardWillHideNotifcation
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    
    
    
    // MARK: - Private
    
    //Used to move the views frame up when the keyboard is about to be shown so the textfields can be seen
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= (keyboardSize.height - 10)
            }
        }
    }
    
    //Used to move the views frame back to the normal position when the keyboard goes away
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += (keyboardSize.height - 10)
            }
        }
    }
    
    //Adds a gesture recognizer that calls dismissKeyboard(_:)
    private func addDismissKeyboardGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //Resigns the first responder for the textField when clicking away from the keyboard
    @objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        animateTransitionIfNeeded(to: .closed, duration: 1)
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var qrView: QRView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var popupView: UIView! {
        didSet {
            popupView.addGestureRecognizer(panRecognizer)
            popupView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            popupView.layer.shadowColor = UIColor.black.cgColor
            popupView.layer.shadowOpacity = 0.3
            popupView.layer.shadowRadius = 10
        }
    }
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var firstNameTextField: HoshiTextField! {
        didSet {
            firstNameTextField.delegate = self
        }
    }
    @IBOutlet weak var lastNameTextField: HoshiTextField! {
        didSet {
            lastNameTextField.delegate = self
        }
    }
    @IBOutlet weak var emailTextField: HoshiTextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: HoshiTextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var confirmPasswordTextField: HoshiTextField! {
        didSet {
            confirmPasswordTextField.delegate = self
        }
    }
    
    @IBOutlet weak var selectLevelTextField: UITextField! {
        didSet {
            selectLevelTextField.delegate = self
        }
    }
        
    @IBOutlet weak var selectInstrumentTextField: UITextField! {
        didSet {
            selectInstrumentTextField.delegate = self
        }
    }
    @IBOutlet weak var teacherTextField: UITextField! {
        didSet {
            teacherTextField.delegate = self
        }
    }
    

    
    // MARK: - IBActions
    
    @IBAction func addTeacher(_ sender: UITextField) {
        animateTransitionIfNeeded(to: .open, duration: 1)
    }
    
    @IBAction func selectLevel(_ sender: UITextField) {
        presentLevelAlertController(on: sender)
    }
   
    @IBAction func selectInstrument(_ sender: UITextField) {
        presentInstrumentAlertController(on: sender)
    }
    
    private func presentLevelAlertController(on textField: UITextField) {
        let beginnerAction = UIAlertAction(title: "Beginner", style: .default) { (action) in
            textField.text = "Beginner"
        }
        
        let intermediateAction = UIAlertAction(title: "Intermediate", style: .default) { (action) in
            textField.text = "Intermediate"
        }
        
        let expertAction = UIAlertAction(title: "Expert", style: .default) { (action) in
            textField.text = "Expert"
        }
        
        let alert = UIAlertController(title: "Select your level of experience", message: "", preferredStyle: .actionSheet)
        alert.addAction(beginnerAction)
        alert.addAction(intermediateAction)
        alert.addAction(expertAction)
        
        //Used if its an ipad to present as a popover
        let popover = alert.popoverPresentationController
        popover?.permittedArrowDirections = .down
        popover?.sourceView = textField
        popover?.sourceRect = textField.bounds
        
        present(alert, animated: true, completion: nil)
    }
    
    private func presentInstrumentAlertController(on textField: UITextField) {
        let trumpetAction = UIAlertAction(title: "Trumpet", style: .default) { (action) in
            textField.text = "Trumpet"
        }
        
        let fluteAction = UIAlertAction(title: "Flute", style: .default) { (action) in
            textField.text = "Flute"
        }
        
        let violinAction = UIAlertAction(title: "Violin", style: .default) { (action) in
            textField.text = "Violin"
        }
        
        let alert = UIAlertController(title: "Select Your Instrument", message: "", preferredStyle: .actionSheet)
        alert.addAction(trumpetAction)
        alert.addAction(fluteAction)
        alert.addAction(violinAction)
        
        //Used if its an ipad to present as a popover
        let popover = alert.popoverPresentationController
        popover?.permittedArrowDirections = .down
        popover?.sourceView = textField
        popover?.sourceRect = textField.bounds
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // Used to toggle the password textfields to show or hide entry
    @IBAction func toggleSecureEntryOnPasswordTextFields(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if passwordTextField.isSecureTextEntry == false {
                passwordTextField.isSecureTextEntry = true
            } else {
                passwordTextField.isSecureTextEntry = false
            }
        case 1:
            if confirmPasswordTextField.isSecureTextEntry == false {
                confirmPasswordTextField.isSecureTextEntry = true
            } else {
                confirmPasswordTextField.isSecureTextEntry = false
            }
        default:
            break
        }
    }
    
    
    @IBAction func createAccount(_ sender: Any) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let confirmedPassword = confirmPasswordTextField.text,
            let instrument = selectInstrumentTextField.text,
            let level = selectLevelTextField.text
        else {return}
        
        guard password == confirmedPassword else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            //Error creating user checks different errors and updates UI to let user know why there was an error
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                    case .weakPassword:
                        print("weakPassword")
                    case .accountExistsWithDifferentCredential:
                        print("Account already exisits")
                    case .emailAlreadyInUse:
                        print("email in use")
                    case .invalidEmail:
                        print("invalid email")
                    case .missingEmail:
                        print("missing email")
                    default:
                        print("error")
                    }
                }
            }
            
            let database = Firestore.firestore()
            
            let userDocumentInformation = ["email" : email, "firstName": firstName, "lastName" : lastName, "instrument": instrument, "level": level]
            
            if let user = user {
                let usersUniqueIdentifier = user.user.uid
                database.collection("students").document(usersUniqueIdentifier).collection("settings").addDocument(data: userDocumentInformation)
            }
        }
    }
}


// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    //Makes the next textfield the first responder when filling out sign in
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            lastNameTextField.becomeFirstResponder()
        case 1:
            emailTextField.becomeFirstResponder()
        case 2:
            passwordTextField.becomeFirstResponder()
        case 3:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    //Disables keyboard on select level textfield since their are three options to
    //choose from
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 5 || textField.tag == 6 || textField.tag == 7 {
            return false
        }
        return true
    }
    
    //Checks for erros
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 3:
            if passwordTextField.text?.count ?? 0 < 6 {
                passwordTextField.activeBorderLayer.backgroundColor = UIColor.red.cgColor
                passwordTextField.placeholderLabel.textColor = UIColor.red
            }
        case 4:
            if confirmPasswordTextField.text != passwordTextField.text {
                confirmPasswordTextField.activeBorderLayer.backgroundColor = UIColor.red.cgColor
                confirmPasswordTextField.placeholderLabel.textColor = UIColor.red
            }
        default:
            ()
        }
        
        
        
        
    }
}

// MARK: - AVCaptureMetadataOutputObjectDelegate
extension SignUpViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        if metadataObjects.count == 0 {
            print("No QR code is detected")
            return
        }
        
        guard let metadataObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {return}
        
        
        if metadataObject.type == AVMetadataObject.ObjectType.qr {
            if currentState == .open {
                if let qrCodeString = metadataObject.stringValue {
                    print(metadataObject.stringValue!)
                    teacherTextField.text = qrCodeString
                    qrView.captureSession?.stopRunning()
                    playSound()
                    animateTransitionIfNeeded(to: .closed, duration: 1)
                }
            }
        }
    }
    
    
    func playSound() {
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
