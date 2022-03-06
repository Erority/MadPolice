//
//  PainComponent.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct PainComponent: View {

    //MARK: drawing data
    private var colors = [ColorForLine(color: Color.green, title: "Green"),
                          ColorForLine(color: Color.red, title: "Red"),
                          ColorForLine(color: Color.blue, title: "Blue"),
                          ColorForLine(color: Color.black, title: "Black")]
    @State private var currentLine = Line()
    @State var lines: [Line] = []
    
    //MARK: action sheet data
    @State private var isActionSheetPresented = false
    
    //MARK: slider data
    @State private var sliderSpeed: Double = 0
    @State private var isSliderEditing = false
    
    @State private var isChangeWidthBrush = false
    
    @State var sliderValue: Double = 1
    
    @Binding private var paint: UIImage
    @Binding private var takePaint: Bool
    
    init(paint: Binding<UIImage>, takePaint: Binding<Bool>){
        _paint = paint
        _takePaint = takePaint
    }
    
    var sliderToChangeWidthOfBrush: some View {
        
        VStack {
            Slider(value: $sliderValue, in: (1...10))
                .onTapGesture {
                    isChangeWidthBrush = false
                }
            Text("Размер кисти: \(Int(sliderValue))")
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .padding(.horizontal, 16)
        .background(.gray)
    }
    
    var controls: some View {
        HStack {
            
            Menu {
                Section {
                    ForEach (colors) { item in
                        Button (action: {
                            self.currentLine.color = item.color
                        }){
                            Label(item.title, image: "")
                        }
                    }
                }
            }
            label: {
                Label("", image: "IconChooseColor")
            }
        .padding(.leading, 16)
            
            Spacer()
            
            Button(action: {
                isChangeWidthBrush.toggle()
            }) {
                Image("IconChooseSizeBrush")
            }
            
            
            Spacer()
            
            Button(action: {
                lines = []
            }){
                Image("IconErase")
            }
            .padding(.trailing, 20)
            
        }
    }
    
    var body: some View {
        VStack {
            
            VStack{
                controls
                
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.4392156601, green: 0.4392156601, blue: 0.4392156601, alpha: 1)))
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
            }
            .actionSheet(isPresented: $isActionSheetPresented) {
                ActionSheet(title: Text("Проеверка свзяи"))
            }
            
            //MARK: draw area
            GeometryReader{ proxy in
                Canvas { context, size in
                    
                    for line in lines {
                        var path = Path()
                        path.addLines(line.points)
                        context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                    }
                    
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded({ value in
                    self.currentLine = Line(points: [])
                })
                .onChanged({ value in
                    let newPoint = value.location
                    currentLine.points.append(newPoint)
                    currentLine.lineWidth = sliderValue
                    self.lines.append(currentLine)
                }))
                .onChange(of: takePaint) { newValue in
                    takePaint = false
                    paint = self.takeScreenshot(origin: proxy.frame(in: .global).origin, size: proxy.size)
                }
            }
            
            if isChangeWidthBrush{
                withAnimation {
                    sliderToChangeWidthOfBrush
                }
            }
        }
    }
}



//MARK: that structure is repsonsible for draw line
struct Line {
    var points = [CGPoint]()
    var color = Color.red
    var lineWidth: Double = 1.0
}


private struct ColorForLine: Identifiable {
    var id = UUID()
    var color: Color
    var title: String
}
