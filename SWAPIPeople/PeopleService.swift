
import Foundation

struct PeopleService {
    
    let session = URLSession.shared
    
    func getPeople(completion: @escaping(([Result]) -> Void)) {
        
        guard let url = URL(string: "https://swapi.dev/api/people/") else { return }
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8)!)
                guard let response = response as? HTTPURLResponse else { return }
                switch response.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    do {
                        let people = try decoder.decode(People.self, from: data)
                        DispatchQueue.main.async {
                            completion(people.results)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                default:
                    print(response.statusCode, "Unexpected!")
                    break
                }
            }
        }
        task.resume()
    }
}
