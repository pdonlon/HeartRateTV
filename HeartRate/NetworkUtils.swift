//
//  NetworkUtils.swift
//  HeartRate
//
//  Created by Philip Donlon on 2/21/24.
//

import Foundation

func mockNetworkData() -> Data {
    let cardJSONs = """

    [
        {
            "title": "Philip",
            "thumbnail": "https://avatars.githubusercontent.com/u/2906828?s=100"
        },
        {
            "title": "Ricky",
            "thumbnail": "https://rickyayoub.com/pages/about.page/png/me.jpg"
        },
        {
            "title": "Jason",
            "thumbnail": "https://images.squarespace-cdn.com/content/v1/5a301164268b96adc28fe647/1586009407723-5IS0U9N7UIR6HVCCWO9B/LCB_17.jpg?format=2500w"
        },
    ]

    """
    let JSONdata = Data(cardJSONs.utf8)
    return JSONdata
}
    
func utf8Data(from url: URL) -> Data? {
    var data: Data? = nil
        do {
            let contents = try String(contentsOf: url, encoding: .utf8)
            data = contents.data(using: .utf8)
        } catch {
            print("Error: \(error)")
        }
    return data
}
    
func makeCall(_ urlString: String) -> Data {
//    let urlString = "https://yoururlhere.com" // Hardcoded URL
    
    if let url = URL(string: urlString), let data = utf8Data(from: url) {
        return data
    }
    return Data()
}

