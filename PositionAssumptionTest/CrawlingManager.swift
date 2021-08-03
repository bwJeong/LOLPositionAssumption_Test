//
//  CrawlingManager.swift
//  PositionAssumptionTest
//
//  Created by Byungwook Jeong on 2021/08/02.
//

import Foundation
import SwiftSoup

struct CrawlingManager {
    private func getHTMLString(url: String, completion: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            if let url = URL(string: url) {
                do {
                    let html = try String(contentsOf: url)
                    
                    completion(html)
                } catch let err {
                    print(String(describing: err))
                }
            }
        }
    }
    
    private func championPath(completion: @escaping (String) -> Void) {
        getHTMLString(url: "https://www.op.gg/champion/statistics") { html in
            do {
                let doc: Document = try SwiftSoup.parse(html)
                let elements: Elements = try doc.getElementsByClass("champion-index__champion-list").select("a")

                for element in elements {
                    let basePath = "https://www.op.gg"
                    let championPath = try element.attr("href")
                    let fullPath = basePath + championPath
                    
                    completion(fullPath)
                }
            } catch let err {
                print(String(describing: err))
            }
        }
    }
    
    func championInfo() {
        championPath { championPath in
            getHTMLString(url: championPath) { html in
                do {
                    let doc: Document = try SwiftSoup.parse(html)
                    let positionElements: Elements = try doc.getElementsByClass("champion-stats-header__position__role")
                    let rateElements: Elements = try doc.getElementsByClass("champion-stats-header__position__rate")
                    
                    print(championPath.split(separator: "/")[3])
                    
                    for i in 0 ..< positionElements.count {
                        let positionElement = try positionElements[i].text()
                        let rateElement = try rateElements[i].text()
                        
                        print(positionElement, rateElement)
                    }
                } catch let err {
                    print(String(describing: err))
                }
            }
        }
    }
}
