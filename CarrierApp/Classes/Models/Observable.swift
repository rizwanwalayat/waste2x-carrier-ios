//
//  Observable.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 05/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
