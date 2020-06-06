//
//  Binding.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import Foundation

/** This is a generic class that you can set up on any type T.
    This will aid in 2 way binding, as we have set the listener on that value T of didSet.
    you can bind to that variable to listen for any change to that variable T
 */
class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value:T) {
        self.value = value
    }

    //you can stop listening by passing nil
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

