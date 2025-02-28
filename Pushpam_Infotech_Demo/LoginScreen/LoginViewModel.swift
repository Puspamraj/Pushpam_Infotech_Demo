//
//  LoginViewModel.swift
//  Pushpam_Infotech_Demo
//
//  Created by Pushpam Raj on 28/02/25.
//

import Foundation

final class LoginViewModel {
    
    func handleOnLogInClick(email: String, password: String) async -> User? {
        var fetchedUser: User?
        let (isValid, message) = validateLogin(email: email, password: password)
        if isValid {
            let (errorMessage, user) = await API_Worker.shared.signin(email: email, password: password)
            if let user {
                fetchedUser = user
            } else {
                print(errorMessage)
            }
        } else {
            print(message)
        }
        return fetchedUser
    }
}


private extension LoginViewModel {
    
    func validateLogin(email: String, password: String) -> (isValid: Bool, message: String) {

        if !validateEmail(email) {
            return (false, "Please enter a valid email address.")
        }
        
        if !validatePassword(password) {
            return (false, "Password must be at least 6 characters long and include at least 1 uppercase letter, 1 number, and 1 special character.")
        }
        
        return (true, "Signup successful!")
    }


    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{6,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
}
