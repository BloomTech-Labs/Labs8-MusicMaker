//
//  UserProfileViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/15/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class UserProfileViewController: UIViewController {

    //Reference to firestore 
    let database = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sample for querying firestore for student information
        guard let currentUsersUniqueID = Auth.auth().currentUser?.uid else {return}
        print(currentUsersUniqueID)
        let studentsCollectionReference = database.collection("students").document(currentUsersUniqueID)
        studentsCollectionReference.getDocument { (document, error) in
            if let document = document {
                if let dataDescription = document.data() {
                    print(dataDescription["level"])
                }
            } else {
                print("Document does not exist in cache")
            }
        }
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
