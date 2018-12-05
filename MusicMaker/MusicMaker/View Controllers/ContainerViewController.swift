//
//  ContainerViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ContainerViewController: UIViewController {

    
    // MARK: - Properties
    var student: Student?
   
    

    // MARK: - IBOutlets
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var teachersView: UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudent()
        teachersView.addGestureRecognizer(tapGesture)
        teachersView.addGestureRecognizer(touchGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        menuButtonTapped()
        teachersViewController.sideMenuIsShowing = teachersViewController.sideMenuIsShowing ? false : true
    }
    
    @IBAction func showQR(_ sender: Any) {
        
    }

    override func viewDidLayoutSubviews() {
        if self.sideMenu.alpha == 0 {
            self.sideMenu.transform = CGAffineTransform(translationX: -self.sideMenu.frame.width, y: 0)
        }
        self.sideMenu.alpha = 1
    }
    
    // MARK: - Private Methods
    private func hideSideMenu() {
        UIView.animate(withDuration: 0.4, animations: {
            self.sideMenu.transform = CGAffineTransform(translationX: -self.sideMenu.frame.width, y: 0)
            self.teachersView.transform = .identity
        }) { (_) in
            self.sideMenu.layer.shadowOpacity = 0
        }
        currentState = .closed
    }

    private func showSideMenu() {
        sideMenu.alpha = 1
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.sideMenu.layer.shadowOpacity = 0.8
            self.sideMenu.transform = .identity
            self.teachersView.transform = CGAffineTransform(translationX: self.sideMenu.frame.width, y: 0)
        })
        currentState = .open
    }
    
    private func fetchStudent() {
        if student == nil {
            guard let currentUsersUid = Auth.auth().currentUser?.uid else {return}
            let database = Firestore.firestore()
            let studentsCollectionReference = database.collection("students").document(currentUsersUid)
            studentsCollectionReference.getDocument { (document, error) in
                if let document = document {
                    if let dataDescription = document.data() as? [String : String] {
                        self.student = Student(dataDescription)
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowUserProfile":
            let destinationVC = segue.destination.children[0] as? UserProfileViewController
            destinationVC?.student = student
        case "ResetPassword":
            let destinationVC = segue.destination.children[0] as? ResetPasswordViewController
            destinationVC?.student = student
        case "ShowSideMenu":
            if let destinationVC = segue.destination as? SideMenuViewController {
                destinationVC.delegate = self
            }
        case "ShowTeachers":
            if let navController = segue.destination as? UINavigationController {
                if let teachersVC = navController.children[0] as? TeachersViewController {
                    teachersVC.delegate = self
                }
            }
        default:
            break
        }
    }
    
    // MARK: - Animations
    private lazy var touchGesture: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(viewPanned(recognizer:)))
        recognizer.cancelsTouchesInView = false
        return recognizer
    }()
    
    private var currentState: State = .closed
    private var animationProgress: CGFloat = 0
    private var transitionAnimator: UIViewPropertyAnimator!
    
    private enum State {
        case open
        case closed
        
        var opposite: State {
            switch self {
            case .open:
                return .closed
            case .closed:
                return .open
            }
        }
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(viewTapped))
        recognizer.cancelsTouchesInView = false
        return recognizer
    }()
    
    @objc func viewTapped() {
        if currentState == . open {
            hideSideMenu()
        }
    }
    
    @objc private func viewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animateTransitionIfNeeded(to: currentState.opposite, duration: 0.5)
            transitionAnimator.pauseAnimation()
            animationProgress = transitionAnimator.fractionComplete
        case .changed:
            let translation = recognizer.translation(in: teachersView)
            var fraction = translation.x / self.view.frame.width
            if currentState == .open { fraction *= 1 }
            if transitionAnimator.isReversed { fraction *= 1 }
            transitionAnimator.fractionComplete = fraction + animationProgress
            
        case .ended:
            let xVelocity = recognizer.velocity(in: teachersView).x
            let shouldClose = xVelocity > 0
            if xVelocity == 0 {
                transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }
            switch currentState {
            case .open:
                if !shouldClose && !transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
                if shouldClose && transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
            case .closed:
                if shouldClose && !transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
                if !shouldClose && transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
            }
            transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            ()
        }
    }
    
    
    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
        
        transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            switch state {
            case .open:

                self.sideMenu.transform = CGAffineTransform(translationX: -self.sideMenu.frame.width, y: 0)
                self.teachersView.transform = .identity
                
                
            case .closed:
                self.sideMenu.layer.shadowOpacity = 0.8
                self.sideMenu.transform = .identity
                self.teachersView.transform = CGAffineTransform(translationX: self.sideMenu.frame.width, y: 0)
            }
            self.view.layoutIfNeeded()
        }
        
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
        }
        transitionAnimator.startAnimation()
        
        
    }
    
    
}

// MARK: - TeachersViewControllerDelegate
extension ContainerViewController: TeachersViewControllerDelegate {
    func menuButtonTapped() {
        currentState == . open ? hideSideMenu() : showSideMenu()
    }
}

// MARK: - SideMenuDelegate
extension ContainerViewController: SideMenuDelegate {
    func userProfileClicked() {
        self.performSegue(withIdentifier: "ShowUserProfile", sender: nil)
    }
    
    func resetPasswordTapped() {
         self.performSegue(withIdentifier: "ResetPassword", sender: nil)
    }
}



