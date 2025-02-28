# Authentication System – Swift (Mock API Integration)

## 📌 Overview
This project demonstrates the integration of authentication APIs in a Swift application using **Mocky.io**. The implementation includes **signup, signin, session validation, and logout**, with secure session management using **Keychain**.

### 🔗 **Mock API Endpoints Used**
The following **Mocky.io** API endpoints are used in this project:

1. **Signup API**  
   - **Endpoint:** `https://run.mocky.io/v3/f397c42f-1349-4468-8dbe-a1dc6940781b`  
   - **Request:**  
     ```json
     {
       "fullName": "John Doe",
       "email": "john.doe@example.com",
       "password": "SecurePass123!",
       "dateOfBirth": "1990-01-01",
       "gender": "Male"
     }
     ```
   - **Response:**  
     ```json
     {
       "success": true,
       "message": "User registered successfully!"
     }
     ```

2. **Signin API**  
   - **Endpoint:** `https://run.mocky.io/v3/6d509e87-3088-41b1-92d0-45a53c8317b3`  
   - **Request:**  
     ```json
     {
       "email": "john.doe@example.com",
       "password": "SecurePass123!"
     }
     ```
   - **Response:**  
     ```json
     {
       "type": "success",
       "user": {
         "fullName": "John Doe",
         "email": "john.doe@example.com"
       }
     }
     ```

3. **Session Validation API (Auto-Login Check)**  
   - **Endpoint:** `https://run.mocky.io/v3/9ca83e68-e667-4d45-abbe-873f9df38b55`  
   - **Response:**  
     ```json
     {
       "sessionValid": true,
       "user": {
         "fullName": "John Doe",
         "email": "john.doe@example.com"
       }
     }
     ```

4. **Logout API**  
   - **Endpoint:** `https://run.mocky.io/v3/7d49cd0e-c6fb-49ba-aa48-f96df90bff1d`  
   - **Response:**  
     ```json
     {
       "success": true,
       "message": "Logged out successfully!"
     }
     ```

---

## 🚀 **Implementation Details**
- **Mock API Behavior:**  
  🔹 **All the APIs return successful responses (`true`)** by default.  
  🔹 Since failure cases were not simulated, **custom error handling** was implemented for session validation and invalid credentials.  
  🔹 The **signin API always returns success**, so additional logic is included to handle incorrect logins.

- **Session Management:**  
  ✅ **User authentication token is securely stored in Keychain**  
  ✅ **Auto-login feature checks the session validity on app startup**  
  ✅ **If session expires, the user is redirected to the login screen**

---

## 🛠 **How to Run the Project**
1. Clone the repository:
   ```sh
   git clone https://github.com/Puspamraj/Pushpam_Infotech_Demo.git
