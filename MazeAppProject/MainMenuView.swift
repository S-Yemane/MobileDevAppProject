//
//  MainMenuView.swift
//  MazeAppProject
//
//  Created by CSUFTitan on 4/4/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import SwiftUI

struct MainMenuView: View {
    @State var playingGame: Bool = false
    
    var body: some View {
        Group {
            if playingGame {
                Maze(rows: 10, cols: 10, seed: nil).DrawMaze()
            } else {
                VStack {
                    Button(action: {
                        self.playingGame.toggle()
                    }) {
                        Text("Play")
                    }
                }
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
