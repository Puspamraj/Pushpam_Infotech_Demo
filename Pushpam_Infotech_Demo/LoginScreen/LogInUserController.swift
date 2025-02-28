//
//  LogInUserController.swift
//  Pushpam_Infotech_Demo
//
//  Created by Pushpam Raj on 28/02/25.
//

import UIKit

class LogInUserController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func logInTapped(_ sender: UIButton) {
        Task {
            loginButton.isEnabled = false
            if let user = await viewModel.handleOnLogInClick(email: emailField.text ?? "", password: passwordField.text ?? "") {
                navigationController?.pushViewController(WelcomeController(user: user), animated: true)
            } else {
                loginButton.isEnabled = true
            }
        }
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
