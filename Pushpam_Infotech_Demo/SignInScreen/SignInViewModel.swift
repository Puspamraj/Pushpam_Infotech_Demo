//
//  SignInViewModel.swift
//  Pushpam_Infotech_Demo
//
//  Created by Pushpam Raj on 28/02/25.
//

import Foundation

final class SignInViewModel {
    
    private var genders: [String] = ["Male", "Female", "Others"]
    
    var genderCount: Int {
        genders.count
    }
    
    func getGender(index: Int) -> String {
        if index < genderCount {
            return genders[index]
        } else {
            return ""
        }
    }
    
    func handleOnSignUpClick(user: SignupRequest, confirmPassword: String) async -> Bool {
        var shouldNavigateToHome = false
        let (isValid, message) = validateSignup(user: user, confirmPassword: confirmPassword)
        if isValid {
            if await API_Worker.shared.signup(user: user) {
                shouldNavigateToHome = true
            } else {
                print("Could not signup")
            }
        } else {
            print(message)
        }
        return shouldNavigateToHome
    }

    func validateDOBPicker(dob: Date) -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()
        let ageComponents = calendar.dateComponents([.year], from: dob, to: currentDate)
        let age = ageComponents.year ?? 0
        return age >= 18
    }
}


private extension SignInViewModel {
    
    func validateSignup(user: SignupRequest, confirmPassword: String) -> (isValid: Bool, message: String) {
        
        if !validateFullName(user.fullName) {
            return (false, "Full name cannot be empty.")
        }
        
        if !validateEmail(user.email) {
            return (false, "Please enter a valid email address.")
        }
        
        if !validatePassword(user.password) {
            return (false, "Password must be at least 6 characters long and include at least 1 uppercase letter, 1 number, and 1 special character.")
        }
        
        if !validateConfirmPassword(confirmPassword, password: user.password) {
            return (false, "Confirm password does not match the password.")
        }
        
        if !validateDOB(user.dateOfBirth) {
            return (false, "You must be at least 18 years old.")
        }
        
        if !validateGender(user.gender) {
            return (false, "Please select a gender.")
        }
        
        return (true, "Signup successful!")
    }

    
    func validateFullName(_ fullName: String) -> Bool {
        return !fullName.isEmpty
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

    func validateConfirmPassword(_ confirmPassword: String, password: String) -> Bool {
        return !password.isEmpty && confirmPassword == password
    }
    
    func validateDOB(_ dob: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        guard let birthDate = dateFormatter.date(from: dob) else {
            return false
        }
        let calendar = Calendar.current
        let currentDate = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
        guard let age = ageComponents.year else {
            return false
        }
        return age >= 18
    }
    
    func validateGender(_ gender: String) -> Bool {
        !gender.isEmpty
    }
}
