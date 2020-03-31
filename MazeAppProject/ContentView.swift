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
        Maze(rows: 10, cols: 10, seed: nil).DrawMaze()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
