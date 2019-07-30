//
//  ViewModel.swift
//  SwiftUIList
//
//  Created by Karthi on 01/07/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class ViewModel: BindableObject {
    
    
    let didChange = PassthroughSubject<ViewModel, Never>()
    
    init() {
        getToDoItems()
    }
    
    
    
    var toDoItems = [Todo]() {
        didSet {
        didChange.send(self)
        }
    }
    
    func getToDoItems() {
        ApiService.toDoListItems { (toDo) in
            self.toDoItems = toDo!
        }
    }
    
    
}
