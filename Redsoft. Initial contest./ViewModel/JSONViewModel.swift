//
//  JSONViewModel.swift
//  Redsoft. Initial contest.
//
//  Created by g01dt00th on 02.10.2020.
//

import SwiftUI

class JSONViewModel: ObservableObject {
    
    @Published var list = [Product]()
    
    @Published var startFrom = 0
    @Published var filter = ""

    //MARK: - TimeInterval for filter execution delay
    private let filterExecuteDelay: TimeInterval = 0.4

    private var isAllreadyExecuted = false
    
    init() {
        loadData()
    }
    
    
    func loadData() {
        guard !isAllreadyExecuted else {
            return
        }
        
        let urlString = self.filter.isEmpty ? APIConfiguration.startFrom.rawValue + String(self.startFrom) : APIConfiguration.filter.rawValue + self.filter + "&startFrom=\(self.startFrom)"
        
        if !self.filter.isEmpty && self.startFrom == 0 {
            self.list.removeAll()
        }
        
        
        print("[JSONViewModel] try to load data from: \(urlString)")
        guard let url = URL(string: urlString) else {
            return
        }

        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { json, response, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                fatalError(response.debugDescription)
            }

            if let json = json {

                do {

                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    print("[JSONViewModel] decoder configured")
                    print("[JSONViewModel] \(json)\n")
                    let data = try decoder.decode(JSONModel.self, from: json)
                    
                    DispatchQueue.main.async {
                        self.list += data.data
                    }
                    

                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("[JSONViewModel] Key '\(key)' not found:", context.debugDescription)
                    print("[JSONViewModel] codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("[JSONViewModel] Value '\(value)' not found:", context.debugDescription)
                    print("[JSONViewModel] codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("[JSONViewModel] Type '\(type)' mismatch:", context.debugDescription)
                    print("[JSONViewModel] codingPath:", context.codingPath)
                } catch {
                    print("[JSONViewModel] error: ", error.localizedDescription)
                }
            }

        }.resume()
    }
    
    func filterExecute() {
        guard !isAllreadyExecuted else {
            return
        }
        isAllreadyExecuted = true
        DispatchQueue.main.asyncAfter(deadline: .now() + filterExecuteDelay, execute: {
            DispatchQueue.main.async {
                self.startFrom = 0
                self.list.removeAll()
                self.loadData()
                
            }
            self.isAllreadyExecuted = false
        })
    }
    
    func loadNext(_ product: Product) {
        if product.id == self.list.last?.id {
            self.startFrom += 10
            self.loadData()
        }
    }
    
 }

