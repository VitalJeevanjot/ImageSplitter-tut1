//
//  MagnificatioTesting.swift
//  ImageSplitter-tut1
//
//  Created by Jeevanjot Singh on 30/06/25.
//

import SwiftUI

struct MagnificatioTesting: View {
    @GestureState private var magnifyBy = 1.0


    var magnification: some Gesture {
        MagnifyGesture()
            .updating($magnifyBy) { value, gestureState, transaction in
                gestureState = value.magnification
            }
    }


    var body: some View {
        GeometryReader {
            geom in
            Image("1003")
                .resizable()
                .frame(width: geom.size.width, height: geom.size.height)
                .scaleEffect(magnifyBy)
                .gesture(magnification)
        }.coordinateSpace(name: "inew")
        
    }
}



#Preview {
    MagnificatioTesting()
}
