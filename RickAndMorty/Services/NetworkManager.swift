import Foundation

class NetworkManager {
  
  static let shared = NetworkManager()
  
  private init() {}
  
  func fetchData(from url: String?, with completion: @escaping (RickAndMorty) -> Void) {
    guard let stringURL = url else { return }
    guard let url = URL(string: stringURL) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      if let error = error {
        print(error)
        return
      }
      
      guard let data = data else { return }
      
      do {
        let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
        DispatchQueue.main.async {
          completion(rickAndMorty)
        }
      } catch let error {
        print(error)
      }
      
    }.resume()
  }
  
  func fetchEpisode(from url: String, completion: @escaping(Episode) -> Void) {
    guard let url = URL(string: url) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard let data = data else {
        print(error?.localizedDescription ?? "no descripption")
        return
      }
      
      do {
        let episode = try JSONDecoder().decode(Episode.self, from: data)
        DispatchQueue.main.async {
          completion(episode)
        }
      } catch let error {
        print(error)
      }
    }.resume()
  }
  
  func fetchCharacter(from url: String, completion: @escaping(Result) -> Void) {
    guard let url = URL(string: url) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard let data = data else {
        print(error?.localizedDescription ?? "no descripption")
        return
      }
      
      do {
        let result = try JSONDecoder().decode(Result.self, from: data)
        DispatchQueue.main.async {
          completion(result)
        }
      } catch let error {
        print(error)
      }
    }.resume()
  }
}

class ImageManager {
  static var shared = ImageManager()
  
  private init() {}
  
  func fetchImages(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data, let response = response else {
        print(error?.localizedDescription ?? "No error description")
        return
      }
      
      guard url == response.url else { return }
      
      completion(data, response)
    }.resume()
  }
}
