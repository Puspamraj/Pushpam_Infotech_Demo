//
//  LaunchController.swift
//  Pushpam_Infotech_Demo
//
//  Created by Pushpam Raj on 27/02/25.
//

import UIKit

class LaunchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        checkSession()
    }
}

private extension LaunchController {
    
    func checkSession() {
        Task {
            if let offlineUser = KeychainHelper.getUser() {
                // move to home if we have offline user info
                navigationController?.pushViewController(WelcomeController(user: offlineUser), animated: false)
            } else if let user = await API_Worker.shared.checkSession() {
                // move to home if we get user session
                navigationController?.pushViewController(WelcomeController(user: user), animated: false)
            } else {
                // move to signup if we dont have user info
                navigationController?.pushViewController(SignInUserController(), animated: false)
            }
        }
    }
}
