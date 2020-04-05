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
    var northWall: Bool = true;
    var southWall: Bool = true;
    var eastWall: Bool = true;
    var westWall: Bool = true;
    //Bool to know if the navigator is in this cell or not
    var navigator: Bool = false;
    //Row and Column location
    var row: Int;
    var col: Int;
    var lineThickness: CGFloat = 5
    
    init(row: Int, col: Int) {
        self.row = row;
        self.col = col;
    }
    
    func DrawView() -> some View {
        ZStack {
            Group {
                if navigator {
                    Circle()
                }
                if northWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                        }
                        .stroke(Color.black, lineWidth: self.lineThickness )
                    }
                }
                if southWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: geo.size.height))
                            path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height))
                        }
                        .stroke(Color.black, lineWidth: self.lineThickness )
                    }
                }
                if eastWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: geo.size.width, y: 0))
                            path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height))
                        }
                        .stroke(Color.black, lineWidth: self.lineThickness)
                    }
                }
                if westWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: 0, y: geo.size.height))
                        }
                        .stroke(Color.black, lineWidth: self.lineThickness)
                    }
                }
            }
        }
    }
}


struct MazeCell_Previews: PreviewProvider {
    static var previews: some View {
        MazeView(rows:5, columns: 5) { row, col in
            MazeCell(row: row, col: col).DrawView()
        }
    }
}
