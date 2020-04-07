//
//  MazeCell.swift
//  MazeAppProject
//
//  Created by CSUFTitan on 3/24/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import SwiftUI

class MazeCell : ObservableObject {
    //Needed for the maze generation algorithm
    var visited = false;
    
    //Bools to keep track of what walls are present
    @Published var northWall: Bool = true;
    @Published var southWall: Bool = true;
    @Published var eastWall: Bool = true;
    @Published var westWall: Bool = true;
    //Bool to know if the navigator is in this cell or not
    @Published var navigator: Bool = false;
    @Published var end: Bool = false
    //Row and Column location
    var row: Int;
    var col: Int;
    var lineThickness: CGFloat = 5
    var iteration: Int = -1
    
    init(row: Int, col: Int) {
        self.row = row;
        self.col = col;
    }
    
    func DrawView() -> some View {
        ZStack {
            Group {
                if end {
                    Circle()
                        .background(Color.yellow)
                }
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

struct MazeCellView: View {
    @ObservedObject var cell: MazeCell
    
    var body: some View {
        ZStack {
            Group {
                if cell.end {
                    Circle()
                        .foregroundColor(.yellow)
                        .background(Color.yellow)
                }
                if cell.navigator {
                    Circle()
                }
                if cell.northWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                        }
                        .stroke(Color.black, lineWidth: self.cell.lineThickness )
                    }
                }
                if cell.southWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: geo.size.height))
                            path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height))
                        }
                        .stroke(Color.black, lineWidth: self.cell.lineThickness )
                    }
                }
                if cell.eastWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: geo.size.width, y: 0))
                            path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height))
                        }
                        .stroke(Color.black, lineWidth: self.cell.lineThickness)
                    }
                }
                if cell.westWall {
                    GeometryReader { geo in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: 0, y: geo.size.height))
                        }
                        .stroke(Color.black, lineWidth: self.cell.lineThickness)
                    }
                }
            }
        }
    }
    
    init(cell: MazeCell) {
        self.cell = cell
    }
}


struct MazeCell_Previews: PreviewProvider {
    static var previews: some View {
        MazeView(rows:5, columns: 5) { row, col in
            MazeCellView(cell: MazeCell(row: row, col: col))
        }
    }
}
