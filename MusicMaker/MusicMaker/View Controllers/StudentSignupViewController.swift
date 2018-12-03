//
//  StudentSignupViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Lottie

class StudentSignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkmarkView.animation = "checked_done_"
        checkmarkView.contentMode = .scaleAspectFit
        checkmarkView.play()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var checkmarkView: LOTAnimationView!
    
    
    // MARK: - Properties
    var isSigningUpWithGoogle = false
    var teacherUniqueId: String?

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
