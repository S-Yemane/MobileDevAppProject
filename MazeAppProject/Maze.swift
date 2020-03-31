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
    
    var navigator: MazeNavigator;
    
    init(rows: Int, cols: Int, seed: Int?) {
        self.rows = rows;
        self.cols = cols;
        //Seed is either the given value, or a random int
        self.seed = seed ?? Int.random(in: 0..<100);
        
        self.navigator = MazeNavigator(row: 0, col: 0)
        
        createCells();
        GenerateMaze(cell: cells[0][0], iteration: 0);
    }
    
    func createCells() -> Void {
        //Fills the cells array with MazeCell objects
        for numR in 0..<rows {
            //The first array of cells must first be created.
            cells.append([]);
            for numC in 0..<cols {
                //Fill that array with MazeCell objects each iteration
                cells[numR].append(MazeCell.init(row: numR, col: numC, lineThickness: 2))
            }
        }
        cells[0][0].navigator = true
    }
    
    //This is a Recursive Backtracker maze generation algorithm
    func GenerateMaze(cell: MazeCell, iteration: Int) -> Void {
        cell.visited = true;
        cell.distance = iteration;
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
                        cell.westWall = false;
                        neighbor.eastWall = false;
                    } else {
                        cell.eastWall = false;
                        neighbor.westWall = false;
                    }
                } else {
                    if (cell.row == neighbor.row + 1) {
                        cell.northWall = false;
                        neighbor.southWall = false;
                    } else {
                        cell.southWall = false;
                        neighbor.northWall = false;
                    }
                }
                GenerateMaze(cell: neighbor, iteration: iteration + 1);
            }
        }
    }
    
    func DrawMaze() -> some View {
        var offset: CGSize = CGSize.init()
        return MazeView(rows: self.rows, columns: self.cols) { row, col in
            self.cells[row][col].DrawView()
        }
        .gesture(DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
        }
        .onEnded { _ in
            if offset.width > 100 {
                self.SwipeRight()
                print(String("Swipe Left/Right"))
            }
            if offset.height > 100 {
                self.SwipeDown()
                print(String("Swipe Up/Down"))
            }
        })
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

struct Maze_Previews: PreviewProvider {
    static var previews: some View {
        Maze(rows: 10, cols: 10, seed: nil).DrawMaze()
    }
}
