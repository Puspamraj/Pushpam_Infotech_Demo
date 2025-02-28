//
//  Models.swift
//  Pushpam_Infotech_Demo
//
//  Created by Pushpam Raj on 27/02/25.
//


protocol RequestType: Codable { }

// Signup Request Model
struct SignupRequest: RequestType {
    let fullName: String
    let email: String
    let password: String
    let dateOfBirth: String
    let gender: String
}

// Signin Request Model
struct SigninRequest: RequestType {
    let email: String
    let password: String
}



// Signup Response Model
struct SignupResponse: Codable {
    let success: Bool
    let message: String
}

// Signin Response Model
struct SigninResponse: Codable {
    let type: String
    let user: User
}

// Session Check Response Model
struct SessionCheckResponse: Codable {
    let sessionValid: Bool
    let user: User?
}

// Logout Response Model
struct LogoutResponse: Codable {
    let success: Bool
    let message: String
}




// User Model
struct User: Codable {
    let fullName: String
    let email: String
}
