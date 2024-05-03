//
//  Auth Manager.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 29/03/2024.
//

import Foundation


class AuthManager {
    static let shared : AuthManager = AuthManager()
    
    var signInUrl : URL? {
        let base = "https://accounts.spotify.com/authorize?"
        let string = "\(base)response_type=code&client_id=\(AppConstants.clientId)&scope=\(AppConstants.scopes)&redirect_uri=\(AppConstants.redirectUrl)&showdialog=true"
        return URL(string: string)
    }
    var isSignedIn : Bool {
        return accessToken != nil
    }
    
   private var accessToken : String?{
        return UserDefaults.standard.string(forKey: "access_token")
    }
    private var refershToken : String?{
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
   private var tokenExpireDate : Date?{
       return UserDefaults.standard.object(forKey: "expire_date") as? Date
    }
    private var shouldRefreshToken : Bool{
        guard let tokenExpireDate = tokenExpireDate else{return false}
        let currentDate = Date()
        let sixMinutes = TimeInterval(560)
        return currentDate.addingTimeInterval(sixMinutes) >= tokenExpireDate
    }
    
    func getToken(code : String,completion : @escaping ((Bool)->Void)){
        guard let url = URL(string: AppConstants.tokenApiUrl) else{
            return
        }
        guard let basicToken = "\(AppConstants.clientId):\(AppConstants.clientSecret)".data(using: .utf8)?.base64EncodedString()
        else{
            print("faild to turn to base 64")
            completion(false)
            return
        }
        let request = createRequest(url: url, basicToken: basicToken, query2: "code", query2Value: code,
                    query3: "redirect_uri", query3Value: AppConstants.redirectUrl,
                    grantTypeValue: "authorization_code")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data , error == nil else {
                completion(false)
                print("error : \(error?.localizedDescription ?? "")")
                return
            }
            do{
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(token: result)
                print(result)
                completion(true)

            }catch{
                completion(false)
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    private func cacheToken(token : AuthResponse){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(token.access_token, forKey: "access_token")
        userDefaults.setValue(Date().addingTimeInterval(TimeInterval(token.expires_in)), forKey: "expire_date")
        if token.refresh_token == nil {
            userDefaults.setValue(token.access_token, forKey: "access_tokrn")
        }else{
            userDefaults.setValue(token.refresh_token, forKey: "refresh_token")
        }

    }
    func refreshToken(completion : @escaping (Result<String,Error>) -> Void){
//        guard shouldRefreshToken else{
//            guard let token = self.accessToken else{
//                return
//            }
//            completion(.success(token))
//            return
//        }
        guard let refershToken = refershToken else{
            return
        }
        guard let url = URL(string: AppConstants.tokenApiUrl) else{return}
        guard let basicToken = "\(AppConstants.clientId):\(AppConstants.clientSecret)".data(using: .utf8)?.base64EncodedString()
        else{
            print("faild to turn to base 64")
            completion(.failure(ApiErrors.somethingWentWrong))
            return
        }
        let request = createRequest(url: url, basicToken: basicToken, query2: "refresh_token", query2Value: refershToken,
                    query3: "client_id", query3Value: AppConstants.clientId,
                    grantTypeValue: "refresh_token")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data , error == nil else{return}
        
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(token: result)
                completion(.success(result.access_token))
            }catch{
                completion(.failure(ApiErrors.somethingWentWrong))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    private func createRequest(url : URL,basicToken : String,query2 : String, query2Value : String,query3 : String, query3Value : String, grantTypeValue : String ) -> URLRequest{
        var component = URLComponents()
        component.queryItems = [
        URLQueryItem(name: "grant_type", value: grantTypeValue),
        URLQueryItem(name: query2, value: query2Value),
        URLQueryItem(name: query3, value: query3Value),
        ]
        var request  = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = component.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(basicToken)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
}

