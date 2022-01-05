//
//  Agents.swift
//  Valorant-Guide
//
//  Created by Manav Deep Singh Lamba on 03/01/22.
//

import Foundation

// MARK: - Agent
struct Agent: Codable, Identifiable{
    var uuid: String
    var displayName: String
    var id: String { uuid }
}


class Api : ObservableObject{
    @Published var agents = [Agent]()
    
    func loadData(completion:@escaping ([Agent]) -> ()) {
        guard let url = URL(string: "https://valorant-api.com/v1/agents") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let agents = try! JSONDecoder().decode([Agent].self, from: data!)
            print(agents)
            DispatchQueue.main.async {
                completion(agents)
            }
        }.resume()
        
    }
}
