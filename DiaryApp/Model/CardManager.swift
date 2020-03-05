//
//  CardManager.swift
//  DiaryApp
//
//  Created by 장창순 on 02/03/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit
import RealmSwift

class CardManager {
    
    static let shared = CardManager()
    
    private var realm = try! Realm()
    
    private var cardList: Results<Card>?
    
    var cardListCount: Int {
        get {
            cardList?.count ?? 0
        }
    }
    
    private init() {
        cardList = realm.objects(Card.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    func getCardFromList(_ at: Int) -> Card {
        return cardList![at]
    }
    
    func save<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    func addNewCard(_ content: String, _ image: UIImage) {
        let newCard = Card(content, image)
        save(newCard)
    }
    
    func editCardByIndex(_ content: String, _ image: UIImage , at: Int ) {
        do {
            try realm.write {
                cardList![at].content = content
                //cardList![at].title = title
                cardList![at].image = NSData(data: image.jpegData(compressionQuality: 0.7)!)
            }
        } catch {
            print(error)
        }
    }
}
