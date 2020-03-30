//
//  ContentView.swift
//  MazeAppProject
//
//  Created by CSUFTitan on 3/24/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MazeView(rows:4, columns: 5) { row, col in
            Image(systemName: "\(row * 10 + col).circle").resizable()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
