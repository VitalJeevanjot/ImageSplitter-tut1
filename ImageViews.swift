//
//  ImageViews.swift
//  ImageSplitter-tut1
//
//  Created by Jeevanjot Singh on 30/06/25.
//

import SwiftUI

class SimpleVariables {
    var simpleVar: Double = 100.0
}

struct ImageViews: View {
    
    
    let width: Double
    let height: Double
    
    @State private var toggle = false
    
    var vars = SimpleVariables()
    
    
    @GestureState private var oldValue: Double?
    
    
    @GestureState private var magnifyBy1 = 1.0
    @GestureState private var magnifyBy2 = 1.0
    
    
    var magnification1: some Gesture {
        MagnifyGesture()
            .updating($magnifyBy1) { value, gestureState, transaction in
                gestureState = value.magnification
            }
    }
    
    var magnification2: some Gesture {
        MagnifyGesture()
            .updating($magnifyBy2) { value, gestureState, transaction in
                gestureState = value.magnification
            }
    }
    
    var dragGesture: some Gesture {
        DragGesture(coordinateSpace: .named("ImageComparison"))
            .updating($oldValue) { value, state, _ in
                state = min(width-5, max(0, value.location.x))
                vars.simpleVar = state!
            }
    }
    
    var body: some View {
        ZStack {
            Image("1003")
                .resizable()
//                .aspectRatio(3/4, contentMode: .fit)
                .scaleEffect(magnifyBy1)
                .clipShape(MyClipShape2ndImg())
                .gesture(magnification1)
                .onTapGesture {
                    print("tapping on 1")
                }
            
            
            Image("1004")
                .resizable()
//                .aspectRatio(3/4, contentMode: .fit)
                .scaleEffect(magnifyBy2)
                .gesture(magnification2)
                .clipShape(MyClipShape(value: (oldValue == nil ? vars.simpleVar : oldValue!) / width))
                .contentShape(MyClipShape(value: (oldValue == nil ? vars.simpleVar : oldValue!) / width))
                .onTapGesture {
                    print("tapping on 2")
                }
            
            Rectangle()
                .fill(.white)
                .contentShape(MyRectangleShapeHit(originX: oldValue == nil ? vars.simpleVar : oldValue!))
                .opacity(oldValue == nil ? 1 : 0.5)
                .clipShape(MyRectangleShape(originX: oldValue == nil ? vars.simpleVar : oldValue!, widthAdd: oldValue == nil ? 5 : 10))
//                .aspectRatio(3/4, contentMode: .fit)
                .gesture(dragGesture)
                .animation(.default, value: oldValue == nil)
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
