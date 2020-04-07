//
//  Maze.swift
//  MazeAppProject
//
//  Created by CSUFTitan on 3/24/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import SwiftUI

class Maze {
    //cells is a 2D array of MazeCell objects
    var cells = [[MazeCell]]();
    
    var rows: Int;
    var cols: Int;
    
    var seed: Int;
    var finalCell: MazeCell;
    
    @State var navigator: MazeNavigator = MazeNavigator(row: 0, col: 0);
    
    init(rows: Int, cols: Int, seed: Int?) {
        self.rows = rows;
        self.cols = cols;
        //Seed is either the given value, or a random int
        self.seed = seed ?? Int.random(in: 0..<100);
        
        finalCell = MazeCell(row: 0, col: 0)
        
        createCells();
        GenerateMaze(cell: cells[0][0], iteration: 1);
        FindEnd()
    }
    
    func createCells() -> Void {
        //Fills the cells array with MazeCell objects
        for numR in 0..<rows {
            //The first array of cells must first be created.
            cells.append([]);
            for numC in 0..<cols {
                //Fill that array with MazeCell objects each iteration
                cells[numR].append(MazeCell(row: numR, col: numC))
            }
        }
        cells[0][0].navigator.toggle()
    }
    
    //This is a Recursive Backtracker maze generation algorithm
    func GenerateMaze(cell: MazeCell, iteration: Int) -> Void {
        cell.visited = true;
        cell.iteration = iteration
        var neighbors = [MazeCell]();
        if (cell.row > 0) {
            neighbors.append(cells[cell.row - 1][cell.col]);
        }
        if (cell.row < rows - 1) {
            neighbors.append(cells[cell.row + 1][cell.col]);
        }
        if (cell.col > 0) {
            neighbors.append(cells[cell.row][cell.col - 1]);
        }
        if (cell.col < cols - 1) {
            neighbors.append(cells[cell.row][cell.col + 1]);
        }
        neighbors.shuffle();
        for neighbor in neighbors {
            if (!neighbor.visited) {
                if (cell.row == neighbor.row) {
                    if (cell.col == neighbor.col + 1) {
                        cells[cell.row][cell.col].westWall = false;
                        cells[neighbor.row][neighbor.col].eastWall = false;
                    } else {
                        cells[cell.row][cell.col].eastWall = false;
                        cells[neighbor.row][neighbor.col].westWall = false;
                    }
                } else {
                    if (cell.row == neighbor.row + 1) {
                        cells[cell.row][cell.col].northWall = false;
                        cells[neighbor.row][neighbor.col].southWall = false;
                    } else {
                        cells[cell.row][cell.col].southWall = false;
                        cells[neighbor.row][neighbor.col].northWall = false;
                    }
                }
                GenerateMaze(cell: neighbor, iteration: iteration + 1);
            }
        }
    }
    
    func FindEnd() -> Void {
        var row: Int = 0
        var col: Int = 0
        var num: Int = 0
        for numR in 0..<self.rows {
            for numC in 0..<self.cols {
                if self.cells[numR][numC].iteration > num {
                    num = self.cells[numR][numC].iteration
                    row = numR
                    col = numC
                }
            }
        }
        cells[row][col].end = true
        finalCell = cells[row][col]
    }
    
    func FinishedMaze() -> Void {
        
    }
    
    func SwipeLeft() -> Void {
        if cells[navigator.row][navigator.col].westWall {
            //Can't go that way user!
            print(String("Can't go that way user!"))
            return
        }
        let x = navigator.row
        var y = navigator.col - 1
        while cells[x][y].northWall && cells[x][y].southWall && !cells[x][y].westWall {
            print(String("Go to the left!"))
            y -= 1
        }
        print(String("Went as far as I could! Landed at row: \(x) col \(y)"))
        cells[navigator.row][navigator.col].navigator = false
        cells[x][y].navigator = true
        navigator.MoveNavigator(row: x, col: y)
    }
    
    func SwipeRight() -> Void {
        if cells[navigator.row][navigator.col].eastWall {
            //Can't go that way user!
            print(String("Can't go that way user!"))
            return
        }
        let x = navigator.row
        var y = navigator.col + 1
        while cells[x][y].northWall && cells[x][y].southWall && !cells[x][y].eastWall {
            print(String("Go to the right!"))
            y += 1
        }
        print(String("Went as far as I could! Landed at row: \(x) col \(y)"))
        cells[navigator.row][navigator.col].navigator = false
        cells[x][y].navigator = true
        navigator.MoveNavigator(row: x, col: y)
        
    }
    
    func SwipeUp() -> Void {
        if cells[navigator.row][navigator.col].northWall {
            //Can't go that way user!
            print(String("Can't go that way user!"))
            return
        }
        var x = navigator.row - 1
        let y = navigator.col
        while cells[x][y].westWall && cells[x][y].eastWall && !cells[x][y].northWall {
            x -= 1
            print(String("Go up!"))
        }
        print(String("Went as far as I could! Landed at row: \(x) col \(y)"))
        cells[navigator.row][navigator.col].navigator = false
        cells[x][y].navigator = true
        navigator.MoveNavigator(row: x, col: y)
    }
    
    func SwipeDown() -> Void {
        if cells[navigator.row][navigator.col].southWall {
            //Can't go that way user!
            print(String("Can't go that way user!"))
            return
        }
        var x = navigator.row + 1
        let y = navigator.col
        while cells[x][y].westWall && cells[x][y].eastWall && !cells[x][y].southWall {
            x += 1
            print(String("Go down!"))
        }
        print(String("Went as far as I could! Landed at row: \(x) col \(y)"))
        cells[navigator.row][navigator.col].navigator = false
        cells[x][y].navigator = true
        navigator.MoveNavigator(row: x, col: y)
    }
}

struct MazeGameView: View {
    var rows: Int
    var cols: Int
    var body: some View {
        var offset: CGSize = CGSize.init()
        let maze = Maze(rows: self.rows, cols: self.cols, seed: nil)
        return MazeView(rows: self.rows, columns: self.cols) { row, col in
            MazeCellView(cell: maze.cells[row][col])
        }
        .gesture(DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
        }
        .onEnded { _ in
            if offset.width > 100 {
                maze.SwipeRight()
                print(String("Swipe Right"))
            } else if offset.width < -100 {
                maze.SwipeLeft()
                print(String("Swipe Left"))
            }
            if offset.height > 100 {
                maze.SwipeDown()
                print(String("Swipe Down"))
            } else if offset.height < -100 {
                maze.SwipeUp()
                print(String("Swipe Up"))
            }
        })
    }
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
    }
}

struct Maze_Previews: PreviewProvider {
    static var previews: some View {
        MazeGameView(rows: 10, cols: 10)
    }
}
