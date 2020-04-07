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
        NavigationView {
                NavigationLink(destination: MazeGameView(rows: 10, cols: 10)) {
                    Text("Play")
                        .font(.title)
                    }
            }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}

struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(40)
            .padding(.horizontal, 20)
    }
}
