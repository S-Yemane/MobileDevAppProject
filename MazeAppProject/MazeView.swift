//
//  MazeView.swift
//  MazeAppProject
//
//  Created by CSUFTitan on 3/29/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import SwiftUI

struct MazeView<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        Group {
            VStack(spacing: 0) {
                ForEach(0 ..< rows, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< self.columns, id: \.self) { column in
                            self.content(row, column)
                            
                        }
                    }
                }
            }
        }.frame(width: 400, height: 400)
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct MazeView_Previews: PreviewProvider {
    static var previews: some View {
        Maze(rows: 10, cols: 10, seed: nil).DrawMaze()
    }
}
