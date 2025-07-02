//
//  ImageViews.swift
//  ImageSplitter-tut1
//
//  Created by Jeevanjot Singh on 30/06/25.
//

import SwiftUI

class SimpleVariables {
    var simpleVar: Double = 100.0
    var mag1Var: Double = 1
    var mag2Var: Double = 1
}

struct ImageViews: View {
    
    
    let width: Double
    let height: Double
    
    @State private var toggle = false
    
    var vars = SimpleVariables()
    
    
    @GestureState private var oldValue: Double?
    
    @State private var img1Zoom: Double = 1
    @State private var img2Zoom: Double = 1
    

    var dragGesture: some Gesture {
        DragGesture(coordinateSpace: .named("ImageComparison"))
            .updating($oldValue) { value, state, _ in
                state = min(width-5, max(0, value.location.x))
                vars.simpleVar = state!
            }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 40) {
                Slider(value: $img2Zoom, in: 1...5)
                Slider(value: $img1Zoom, in: 1...5)
            }
            
            ZStack {
                Image("1003")
                    .resizable()
                    .scaleEffect(img1Zoom)
                    .clipShape(MyClipShape2ndImg())
                    .contentShape(MyClipShape2ndImg())

                
                
                Image("1004")
                    .resizable()
                    .scaleEffect(img2Zoom)
                    .clipShape(MyClipShape(value: (oldValue == nil ? vars.simpleVar : oldValue!) / width))
                    .contentShape(MyClipShape(value: (oldValue == nil ? vars.simpleVar : oldValue!) / width))
                
                Rectangle()
                    .fill(.white)
                    .contentShape(MyRectangleShapeHit(originX: oldValue == nil ? vars.simpleVar : oldValue!))
                    .opacity(oldValue == nil ? 1 : 0.5)
                    .clipShape(MyRectangleShape(originX: oldValue == nil ? vars.simpleVar : oldValue!, widthAdd: oldValue == nil ? 5 : 10))
                    .gesture(dragGesture)
                    .animation(.default, value: oldValue == nil)
            }
        }
        

    }
    
}

struct MyRectangleShapeHit: Shape {
    var originX: Double
    
    nonisolated func path(in rect: CGRect) -> Path {
        var rect = rect
        rect.size.width = 40
        rect.origin.x = originX - 20
        return Path(roundedRect: rect, cornerRadius: 20)
    }
}

struct MyRectangleShape: Shape {
    var originX: Double
    var widthAdd: Double
    
    var animatableData: Double {
        get {
            widthAdd
        } set {
            widthAdd = newValue
        }
    }
    
    nonisolated func path(in rect: CGRect) -> Path {
        var rect = rect
        rect.size.width = widthAdd
        rect.origin.x = originX
        return Path(roundedRect: rect, cornerRadius: 20)
    }
}
