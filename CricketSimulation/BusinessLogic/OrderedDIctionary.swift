//
//  OrderedDIctionary.swift
//  CricketSimulation
//
//  Created by Easha.T on 26/09/19.
//  Copyright © 2019 Easha.T. All rights reserved.
//

struct OrderedDictionary<Tk: Hashable, Tv> {
    var keys: Array<Tk> = []
    var values: Dictionary<Tk,Tv> = [:]

    var count: Int {
        assert(keys.count == values.count, "Keys and values array out of sync")
        return self.keys.count;
    }

    init() {}

    subscript(index: Int) -> Tv? {
        get {
            let key = self.keys[index]
            return self.values[key]
        }
        set(newValue) {
            let key = self.keys[index]
            if (newValue != nil) {
                self.values[key] = newValue
            } else {
                self.values.removeValue(forKey: key)
                self.keys.remove(at: index)
            }
        }
    }

    subscript(key: Tk) -> Tv? {
        get {
            return self.values[key]
        }
        set(newValue) {
            if newValue == nil {
                self.values.removeValue(forKey: key)
                self.keys = self.keys.filter {$0 != key}
            } else {
                let oldValue = self.values.updateValue(newValue!, forKey: key)
                if oldValue == nil {
                    self.keys.append(key)
                }
            }
        }
    }
}
