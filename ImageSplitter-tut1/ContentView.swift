//
//  ContentView.swift
//  ImageSplitter-tut1
//
//  Created by Jeevanjot Singh on 13/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var toggle = false
    
    
    @State private var widthOfLine: Double = 2
    
    
    var body: some View {
        ZStack {
            Rectangle().fill(.yellow)
            
            VStack {

                GeometryReader { geom in
                    ImageViews(width: geom.size.width, height: geom.size.height)
                }
                .aspectRatio(3/4, contentMode: .fit)
                .coordinateSpace(name: "ImageComparison")
//                .border(.orange)
            }.padding()
                .ignoresSafeArea()
            
            
        }
    }
}

struct MyClipShape: Shape {
    var value: CGFloat
    func path(in rect: CGRect) -> Path {
        var rect = rect
        rect.size.width = rect.size.width * value
        return Path(roundedRect: rect, cornerRadius: 0)
    }
}

struct MyClipShape2ndImg: Shape {
    func path(in rect: CGRect) -> Path {
        return Path(roundedRect: rect, cornerRadius: 0)
    }
}


#Preview {
    ContentView()
}
