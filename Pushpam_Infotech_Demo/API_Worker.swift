//
//  API_Worker.swift
//  Pushpam_Infotech_Demo
//
//  Created by Pushpam Raj on 27/02/25.
//

import Foundation

final class API_Worker {
    
    static let shared = API_Worker()
    
    //  Check Session API
    func checkSession() async -> User? {
        guard let sessionCheckURL = URL(string: "https://run.mocky.io/v3/9ca83e68-e667-4d45-abbe-873f9df38b55") else {
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: getURLRequest(url: sessionCheckURL))
            if let sessionResponse = try? JSONDecoder().decode(SessionCheckResponse.self, from: data),
               sessionResponse.sessionValid {
                KeychainHelper.saveUser(sessionResponse.user!)
                return sessionResponse.user
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }

    
    //  Sign up API
    func signup(user: SignupRequest) async -> Bool {
        guard let signupURL = URL(string: "https://run.mocky.io/v3/f397c42f-1349-4468-8dbe-a1dc6940781b"), let request = postURLRequest(url: signupURL, model: user) else {
            return false
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try? JSONDecoder().decode(SignupResponse.self, from: data)
            return result?.success ?? false
        } catch {
            return false
        }
    }

    
    //  Sign in API
    func signin(email: String, password: String) async -> (String, User?) {
        let signinData = SigninRequest(email: email, password: password)
        guard let signinURL = URL(string: "https://run.mocky.io/v3/6d509e87-3088-41b1-92d0-45a53c8317b3"), let request = postURLRequest(url: signinURL, model: signinData) else {
            return ("Invalid URL", nil)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let signinResponse = try? JSONDecoder().decode(SigninResponse.self, from: data),
               signinResponse.type == "success" {
                KeychainHelper.saveUser(signinResponse.user)
                return ("Login successful!", signinResponse.user)
            } else {
                return ("Invalid credentials", nil)
            }
        } catch {
            return ("Network error: \(error.localizedDescription)", nil)
        }
    }

    
    // Logout API
    func logout() async -> (Bool, String) {
        guard let logoutURL = URL(string: "https://run.mocky.io/v3/7d49cd0e-c6fb-49ba-aa48-f96df90bff1d"), let request = postURLRequest(url: logoutURL) else {
            return (false, "Invalid URL")
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let result = try? JSONDecoder().decode(LogoutResponse.self, from: data), result.success {
                KeychainHelper.clearUser()
                return (true, "Logged out successfully!")
            } else {
                return (false, "Failed to log out")
            }
        } catch {
            return (false, "Network error: \(error.localizedDescription)")
        }
    }
    
}


private extension API_Worker {
    
    func getURLRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func postURLRequest(url: URL, model: RequestType? = nil) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let model = model {
            let bodyData = try? JSONEncoder().encode(model)
            request.httpBody = bodyData
        }
        return request
    }
}
