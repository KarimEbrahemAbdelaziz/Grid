//
//  ContentModeExample.swift
//  Grid_Example
//
//  Created by Denis Obukhov on 28.05.2020.
//  Copyright © 2020 Exyte. All rights reserved.
//

import SwiftUI
import ExyteGrid

struct ContentModeExample: View {
    private struct Model: Hashable {
        let text: String
        let span: GridSpan
        let color = UIColor.random.lighter(by: 50)
    }
    
    @State var contentMode: GridContentMode = .scroll

    var body: some View {
        VStack {
            self.modesPicker
            
            if self.contentMode == .intrinsic {
                ScrollView(.vertical) {
                    VStack {
                        self.headerView
                        self.gridView
                        self.footerView
                    }
                }
            } else {
                self.gridView
            }
        }
    }
    
    private var gridView: some View {
        Grid(models, id: \.self, tracks: 3) {
            VCardView(text: $0.text, color: $0.color)
                .gridSpan($0.span)
        }
        .gridContentMode(self.contentMode)
        .gridFlow(.rows)
    }

    private let models: [Model] = [
        Model(text: placeholderText(length: 30), span: [1, 1]),
        Model(text: placeholderText(length: 50), span: [1, 1]),
        Model(text: placeholderText(length: 20), span: [1, 1]),
        Model(text: placeholderText(length: 100), span: [2, 1]),
        Model(text: placeholderText(length: 150), span: [1, 1]),
        Model(text: placeholderText(length: 75), span: [1, 1]),
        Model(text: placeholderText(length: 155), span: [1, 1]),
        Model(text: placeholderText(length: 150), span: [1, 2]),
        Model(text: placeholderText(length: 160), span: [2, 1]),
        Model(text: placeholderText(length: 300), span: [3, 1])
    ]
    
    private var modesPicker: some View {
        Picker("Mode", selection: $contentMode) {
            ForEach([GridContentMode.scroll, GridContentMode.fill, GridContentMode.intrinsic], id: \.self) {
                Text($0.description).tag($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private var headerView: some View {
        self.rectangleView(text: "Header", color: .green)
            .frame(height: 100)
    }
    
    private var footerView: some View {
        self.rectangleView(text: "Footer", color: .blue)
            .frame(height: 50)
    }
    
    private func rectangleView(text: String, color: UIColor) -> some View {
        ColorView(color.withAlphaComponent(0.6))
            .overlay(
                Text(text)
                    .font(.system(.headline))
            )
            .padding([.leading, .trailing], 5)
    }
}

struct ContentModeExample_Previews: PreviewProvider {
    static var previews: some View {
        ContentModeExample()
    }
}
