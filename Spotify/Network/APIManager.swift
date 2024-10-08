//
//  APIManager.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 05/04/2024.
//

import Foundation


class APIManager{
    
    static let shared : APIManager = APIManager()
    //MARK: - Profile APIS
    public func getUserProfile(completion : @escaping (Result<UserProfile,Error>) -> Void){
        guard let url = URL(string: "\(AppConstants.baseURL)/me") else{
            return
        }
        createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else{
                    print(error?.localizedDescription ?? "")
                    completion(.failure(ApiErrors.somethingWentWrong))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //MARK: - Home APIS
    public func getNewReleasesAPI(completion :@escaping (Result<NewReleasesResponse,Error>) -> Void){
        guard let safeURL = URL(string: "\(AppConstants.baseURL)/browse/new-releases?limit=25") else{
            return
        }
        createRequest(url: safeURL, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    print(error?.localizedDescription as Any)
                    completion(.failure(ApiErrors.somethingWentWrong))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(ApiErrors.somethingWentWrong))
                }
                
            }
            task.resume()
        }
    }
    
    
    public func getFeaturedPlaylistsAPI(completion : @escaping (Result<FeaturedPlaylistResponse,Error>)-> Void){
        guard let url = URL(string:"\(AppConstants.baseURL)/browse/featured-playlists") else {
            return
        }
        createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(ApiErrors.somethingWentWrong))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                 
                    completion(.success(result))
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(ApiErrors.somethingWentWrong))
                }
            }
            task.resume()
        }
    }
    public func getRecommendationsAPI(completion : @escaping (Result<RecommendationsResponse,Error>)-> Void){
        guard let url = URL(string:"\(AppConstants.baseURL)/recommendations?seed_artists=4NHQUGzhtTLFvgF5SZesLK&seed_genres=classical%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA") else {
            return
        }
        createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(ApiErrors.somethingWentWrong))
                    return
                }
                do {

                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                   
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(ApiErrors.somethingWentWrong))
                }
            }
            task.resume()
        }
    }

    public func getGenreSeedsAPI(completion : @escaping (Result<GenreSeedsResonse,Error>)-> Void){
        guard let url = URL(string:"\(AppConstants.baseURL)/recommendations/available-genre-seeds") else {
            return
        }
        createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(ApiErrors.somethingWentWrong))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(GenreSeedsResonse.self, from: data)
                    completion(.success(result))
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(ApiErrors.somethingWentWrong))
                }
            }
            task.resume()
        }
    }
    //MARK: - Category
    public func getCategories(completion : @escaping (Result<[CategoryItemResponse],Error>) -> Void){
        guard let url = URL(string: AppConstants.baseURL + "/browse/categories") else{
            completion(.failure(ApiErrors.faildParseURL))
            return
        }
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            self?.createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(error!))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(CategoryResponse.self, from: data)
                    completion(.success(result.categories.items))
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    }
    public func getCategoryPlaylist(id : String ,completion : @escaping (Result<FeaturedPlaylistResponse,Error>) -> Void){
        guard let url = URL(string: AppConstants.baseURL + "/browse/categories/\(id)/playlists") else{
            completion(.failure(ApiErrors.faildParseURL))
            return
        }
        createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(error!))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //MARK: - Album
    public func getAlbumDetails(id : String , completion : @escaping (Result<AlbumDetails,Error>)-> Void){
        guard let url = URL(string: AppConstants.baseURL + "/albums/\(id)")else{
            completion(.failure(ApiErrors.somethingWentWrong))
            return
        }
        
        createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else{
                    print(error?.localizedDescription ?? "error")
                    completion(.failure(ApiErrors.somethingWentWrong))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(AlbumDetails.self, from: data)
                    completion(.success(result))
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(ApiErrors.somethingWentWrong))
                }
            }
            task.resume()
        }
    }
    //MARK: - Search
    public func search(query : String, completion : @escaping(Result<SearchResponse,Error>)-> Void){
        guard let url = URL(string: AppConstants.baseURL + "/search?q=\(query)&type=album%2Cplaylist%2Ctrack%2Cartist") else{
            completion(.failure(ApiErrors.faildParseURL))
            return
        }
        createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else{
                    completion(.failure(ApiErrors.somethingWentWrong))
                    print(error?.localizedDescription ?? "")
                    return
                }
                do{
                    let result = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    public func searchTest(query : String, completion : @escaping(Result<SearchResponseTest,Error>)-> Void){
        guard let url = URL(string: AppConstants.baseURL + "/search?q=\(query)&type=album%2Cplaylist%2Ctrack%2Cartist") else{
            completion(.failure(ApiErrors.faildParseURL))
            return
        }
        createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else{
                    completion(.failure(ApiErrors.somethingWentWrong))
                    print(error?.localizedDescription ?? "")
                    return
                }
                do{
                    let result = try JSONDecoder().decode(SearchResponseTest.self, from: data)
                    completion(.success(result))
                    print(result)
                }catch{
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }

    //MARK: - Playlist
    public func getPlayistDetailsAPI(id : String , completion : @escaping (Result<PlaylistDetailsResponse,Error>) -> Void){
        guard let url = URL(string: AppConstants.baseURL + "/playlists/\(id)") else{
            completion(.failure(ApiErrors.faildParseURL))
            return
        }
        createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    print(error?.localizedDescription ?? "")
                    completion(.failure(ApiErrors.somethingWentWrong))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(ApiErrors.somethingWentWrong))
                }
            }
            task.resume()
        }
    }
    public func getUserPlaylists(completion : @escaping (Result<PlaylistsResponse,Error>) -> Void){
        getUserProfile { result in
            switch result {
            case .failure(let error) :
                completion(.failure(error))
            case .success(let user) :
                guard let url = URL(string: AppConstants.baseURL + "/users/\(user.id ?? "")/playlists") else{
                    completion(.failure(ApiErrors.faildParseURL))
                    return
                }
                self.createRequest(url: url, type: .GET) { request in
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data , error == nil else {
                            completion(.failure(ApiErrors.somethingWentWrong))
                            return
                        }
                        do {
                            let result = try JSONDecoder().decode(PlaylistsResponse.self, from: data)
                            print(result)
                            completion(.success(result))
                        }catch{
                            print(error.localizedDescription)
                            completion(.failure(error))
                        }
                    }
                    task.resume()
                }

            }
        }
    }
    public func createPlaylist(name : String, completion: @escaping (Result<Bool,Error>) -> Void){
        getUserProfile { result in
            switch result {
            case .failure(let error) :
                completion(.failure(error))
            case .success(let user) :
                guard let url = URL(string: AppConstants.baseURL + "/users/\(String(describing: user.id ?? ""))/playlists") else{
                    completion(.failure(ApiErrors.faildParseURL))
                    return
                }
                self.createRequest(url: url, type: .POST) { req in
                    var request = req
                    let json = [
                        "name" : name
                    ]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json)
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data , error == nil else{
                            completion(.failure(ApiErrors.somethingWentWrong))
                            return
                        }
                        do {
                            let json = try JSONSerialization.jsonObject(with: data)
                            completion(.success(true))
                        }catch{
                            completion(.failure(error))
                        }
                    }
                    task.resume()
                }
            }
        }
    }
    public func addTrackToPlaylist(playlist : Playlist,track : Track, completion : @escaping (Result<Bool,Error>)->Void){
        guard let url = URL(string: AppConstants.baseURL + "/playlists/\(playlist.id)/tracks") else{
            completion(.failure(ApiErrors.faildParseURL))
            return
        }
        createRequest(url: url, type: .POST) { req in
            var request = req
            let json  = [
                "uris": [
                    "spotify:track:\(track.id)"
                 ],
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, res, error in
                guard let data = data , error == nil else{
                    completion(.failure(ApiErrors.somethingWentWrong))
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    if let response = result as? [String : Any], response["snapshot_id"] as? String != nil {
                        completion(.success(true))
                    }
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func deleteTrackFromPlaylist(playlist : Playlist,track : Track, completion : @escaping (Result<Bool,Error>)->Void){
        guard let url = URL(string: AppConstants.baseURL + "/playlists/\(playlist.id)/tracks") else{
            completion(.failure(ApiErrors.faildParseURL))
            return
        }
        createRequest(url: url, type: .DELETE) { req in
            var request = req
            let json  = [
                "tracks" : [
                   [
                    "uri":
                        "spotify:track:\(track.id)"
                   ]
                     
                ]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, res, error in
                guard let data = data , error == nil else{
                    completion(.failure(ApiErrors.somethingWentWrong))
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    if let response = result as? [String : Any], response["snapshot_id"] as? String != nil {
                        completion(.success(true))
                    }
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    func createUserAlbum(album : Album, completion: @escaping (Result<Bool,Error>) -> Void){
        guard let url = URL(string: AppConstants.baseURL + "/me/albums") else{
            completion(.failure(ApiErrors.faildParseURL))
            return
        }
        createRequest(url: url, type: .PUT) { req in
            var request = req
            let body = [
                "ids": [
                    album.id
                 ]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let task = URLSession.shared.dataTask(with: request) { data, res, error in
                    guard let res = res as? HTTPURLResponse , error == nil else{
                        completion(.failure(ApiErrors.somethingWentWrong))
                        return
                    }
                    print(res.statusCode)
                    completion(.success(res.statusCode == 200))
                }
                task.resume()
            }
        }
    }
    
    public func getUserAlbums(completion : @escaping (Result<UserAlbumResponse,Error>) -> Void){
        guard let url = URL(string: AppConstants.baseURL + "/me/albums") else{
            completion(.failure(ApiErrors.faildParseURL))
            return
        }
        createRequest(url: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data,_, error in
                guard let data = data , error == nil else{
                    completion(.failure(ApiErrors.somethingWentWrong))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserAlbumResponse.self, from: data)
                    print(result)
                    completion(.success(result))
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Private APIS
    private func createRequest(url : URL?,type : HttpMethods ,completion : @escaping (URLRequest)-> Void){
        guard let url = url else{return}
        AuthManager.shared.refreshToken { result in
            switch result {
            case .success(let token):
                var request = URLRequest(url: url)
                request.httpMethod = type.rawValue
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                request.timeoutInterval = 25
                completion(request)
            case .failure(let error):
                print(error)
            }
        }
    }
}

