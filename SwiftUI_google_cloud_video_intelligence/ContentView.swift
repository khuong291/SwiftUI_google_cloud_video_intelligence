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
        }
        .padding()
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print(result?.user.getIDToken())
            }
        }
    }
}
