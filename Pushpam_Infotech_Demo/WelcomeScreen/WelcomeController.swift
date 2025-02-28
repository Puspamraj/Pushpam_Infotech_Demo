//
//  WelcomeController.swift
//  Pushpam_Infotech_Demo
//
//  Created by Pushpam Raj on 28/02/25.
//

import UIKit

class WelcomeController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    private var user: User

    init(user: User)  {
        self.user = user
        super.init(nibName: "WelcomeController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = user.fullName
        emailLabel.text = user.email
    }


    @IBAction func onLogoutTap(_ sender: UIButton) {
        Task {
            let (isLogoutSuccess, errorMessage) = await API_Worker.shared.logout()
            if isLogoutSuccess {
                if let signInController = navigationController?.viewControllers.first(where: { $0 is SignInUserController }) {
                    navigationController?.popToViewController(signInController, animated: true)
                } else {
                    let signInController = SignInUserController()
                    navigationController?.pushViewController(signInController, animated: true)
                }
            } else {
                print(errorMessage)
            }
        }
    }
}
