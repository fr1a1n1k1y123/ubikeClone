//
//  UBikeAPIManager.swift
//  UBikeClone
//
//  Created by 羅群瀝 on 2023/10/29.
//

import Foundation

class UBikeAPIManager{
    static let shared = UBikeAPIManager()
    private init (){}
    
    var youBikeStations = [YouBikeStation]()
    
    func getUBikeInfo(completion: @escaping ([YouBikeStation]?) -> Void){
        if let url = URL(string: "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json") {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data{
                    do {
                        let decoder = JSONDecoder()
                        completion(try decoder.decode([YouBikeStation].self, from: data))
                    } catch  {
                        completion(nil)
                        print("錯誤：\(error)")
                    }
                    
                }else{
                    print("錯誤：\(error)")
                }
            }.resume()
            
        }else{
            print("URL失敗")
        }
    }

}
