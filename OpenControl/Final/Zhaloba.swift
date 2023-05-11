//
//  Zhaloba.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 05.05.2023.
//

import SwiftUI

struct Zhaloba: View {
    var body: some View {
        TabView {
            
            Text("dfcds")

            ZhalobaQuestion()

                    }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        
        
    }
}

struct Zhaloba_Previews: PreviewProvider {
    static var previews: some View {
        Zhaloba()
    }
}
