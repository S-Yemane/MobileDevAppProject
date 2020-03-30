//
//  MazeCell.swift
//  MazeAppProject
//
//  Created by CSUFTitan on 3/24/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import SwiftUI

class MazeCell {
    //Needed for the maze generation algorithm
    var visited = false;
    
    //Bools to keep track of what walls are present
    var northWall = true;
    var southWall = true;
    var eastWall = true;
    var westWall = true;
    //Row and Column location
    var row: Int;
    var col: Int;
    
    init(row: Int, col: Int) {
        self.row = row;
        self.col = col;
    }
    
    func DrawView() -> some View {
        ZStack {
            Text("\(String(self.visited))")
            Group {
                if northWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                        }
                        .stroke(Color.black, lineWidth: 10)
                    }
                }
                if southWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: geo.size.height))
                            path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height))
                        }
                        .stroke(Color.black, lineWidth: 10)
                    }
                }
                if eastWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: geo.size.width, y: 0))
                            path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height))
                        }
                        .stroke(Color.black, lineWidth: 10)
                    }
                }
                if westWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: 0, y: geo.size.height))
                        }
                        .stroke(Color.black, lineWidth: 10)
                    }
                }
            }
        }
    }
}

struct MazeCellView: View {
    var body: some View {
        GeometryReader { geo in
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: geo.size.height))
                path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height))
                path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                path.addLine(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: geo.size.height))
            }
            .stroke(Color.black, lineWidth: 10)
        }
    }
}

struct MazeCell_Previews: PreviewProvider {
    static var previews: some View {
        MazeView(rows:10, columns: 5) { row, col in
            MazeCellView()
        }
    }
}
