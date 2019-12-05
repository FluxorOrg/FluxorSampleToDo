//
//  ActivityIndicator.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 25/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
