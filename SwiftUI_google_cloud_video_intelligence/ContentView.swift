//
//  ContentView.swift
//  SwiftUI_google_cloud_video_intelligence
//
//  Created by Khuong Pham on 28/11/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State var email = "khuong.pham@2359media.com"
    @State var password = "Password123!"

    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action: login) {
                Text("Sign in")
            }
            Button(action: annotateVideo) {
                Text("Annotate video")
            }
        }
        .padding()
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                Auth.auth().currentUser?.getIDToken() { accessToken, error in
                    print(accessToken)
                }
            }
        }
    }
    
    func annotateVideo() {
        Task {
            do {
                var urlComponents = URLComponents(string: "https://videointelligence.googleapis.com/v1/videos:annotate")
                urlComponents?.queryItems = [
                    URLQueryItem(name: "key", value: Constants.API_KEY)
                ]
                guard let url = urlComponents?.url?.absoluteURL else {
                    return
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImE5NmFkY2U5OTk5YmJmNWNkMzBmMjlmNDljZDM3ZjRjNWU2NDI3NDAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbHVtaW5lMjM1OSIsImF1ZCI6Imx1bWluZTIzNTkiLCJhdXRoX3RpbWUiOjE2Njk2NTIwNTUsInVzZXJfaWQiOiJzdW5zNlBPZ0RDVm5RTEJrMzhZRUV0Z1M1MEQzIiwic3ViIjoic3VuczZQT2dEQ1ZuUUxCazM4WUVFdGdTNTBEMyIsImlhdCI6MTY2OTY1MjA1NSwiZXhwIjoxNjY5NjU1NjU1LCJlbWFpbCI6ImtodW9uZy5waGFtQDIzNTltZWRpYS5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsia2h1b25nLnBoYW1AMjM1OW1lZGlhLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.BrdXPAP4yyBXCwngqm5GQQIKoTvRWszaMSOFD2ycZ2TjNf_t4BvlJOvVYQ5Y85E11qAw4nWIwnIhy-EvXyTWB_jw9c86u-mt2oVBTqyx0CMDiKKHCa3m4jkp6bJUV-3cyoofrhu9Z2Hny_LALdTeD_CrCCoFHyomTrzjHhjgXmRhgr4ZzDY7wDOrL2vnw6LcNWQQzqas9UB1NLrTSk-Xo7qwWNEz94zvY0VjEFrQVOi80O2DjBIRKeMLpZzTXFE5T0q32DMUTLyfS3-QfUUY3R9JPv_uaR-5dJoB3hmGtF9x9JMalSUuLmik7fEP1iOlVq2jHWQLp2RZEBx5IXokDQ", forHTTPHeaderField: "Authorization")
//                request.httpBody = jsonData // A Loc them base64 vao
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    print("-----1> responseJSON: \(responseJSON)")
                    if let responseJSON = responseJSON as? [String: Any] {
                        print("-----2> responseJSON: \(responseJSON)")
                    }
                }
                
                task.resume()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
