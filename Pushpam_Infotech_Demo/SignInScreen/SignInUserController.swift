//
//  SignInUserController.swift
//  Pushpam_Infotech_Demo
//
//  Created by Pushpam Raj on 28/02/25.
//

import UIKit

class SignInUserController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    private let viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupDatePicker()
        setupGenderPicker()
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        let requestedUser = SignupRequest(fullName: nameField.text ?? "",
                                 email: emailField.text ?? "",
                                 password: passwordField.text ?? "",
                                 dateOfBirth: dobField.text ?? "",
                                 gender: genderField.text ?? "")
        Task {
            signupButton.isEnabled = false
            let isSuccess = await viewModel.handleOnSignUpClick(user: requestedUser, confirmPassword: confirmPasswordField.text ?? "")
            if isSuccess {
                navigationController?.pushViewController(WelcomeController(user: User(fullName: requestedUser.fullName, email: requestedUser.email)), animated: true)
            } else {
                signupButton.isEnabled = true
            }
        }
        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        navigationController?.pushViewController(LogInUserController(), animated: true)
    }
    
}


private extension SignInUserController {
    
    func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        dobField.inputView = datePicker
        
        // Tool bar with done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissDatePicker))
        toolbar.setItems([doneButton], animated: true)
        dobField.inputAccessoryView = toolbar
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let pickedDate = datePicker.date
        if viewModel.validateDOBPicker(dob: pickedDate) {
            dobField.text = dateFormatter.string(from: pickedDate)
        } else {
            print("Age must be 18 or above")
        }
    }
    
    @objc func dismissDatePicker() {
        dobField.resignFirstResponder()
    }
    
    func setupGenderPicker() {
        let genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderField.inputView = genderPicker
        
        // Tool bar with done button for the gender picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissGenderPicker))
        toolbar.setItems([doneButton], animated: true)
        genderField.inputAccessoryView = toolbar
    }
    
    @objc func dismissGenderPicker() {
        genderField.resignFirstResponder()
    }
}


extension SignInUserController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Number of rows in the picker (Male, Female, Other)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.genderCount
    }

    // Title for each row in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.getGender(index: row)
    }

    // Called when the user selects a row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderField.text = viewModel.getGender(index: row)
    }
}
