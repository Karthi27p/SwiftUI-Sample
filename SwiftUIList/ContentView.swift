//
//  ContentView.swift
//  SwiftUIList
//
//  Created by Karthi on 25/06/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @State var toDoModel = ViewModel()
    
    
    var body: some View {
        List(toDoModel.toDoItems) { toDoItem in
            VStack {
                Text(toDoItem.title)
            }
    }
}
}

#if DEBUG

struct ContentView_Previews : PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
#endif
