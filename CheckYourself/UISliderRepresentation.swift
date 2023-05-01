//
//  UISliderRepresentation.swift
//  CheckYourself
//
//  Created by Roman Lantsov on 01.05.2023.
//

import SwiftUI

struct UISliderRepresentation: UIViewRepresentable {
    @Binding var currentValue: Double
    let thumbOpacity: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = Float(currentValue)
        slider.thumbTintColor = .red
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.changeSliderValue),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.thumbTintColor = UIColor(
            red: 1,
            green: 0,
            blue: 0,
            alpha: thumbOpacity / 100
        )
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(currentValue: $currentValue)
    }
}

//MARK: - Coordinator
extension UISliderRepresentation {
    final class Coordinator: NSObject {
        @Binding var currentValue: Double
        
        init(currentValue: Binding<Double>) {
            self._currentValue = currentValue
        }
        
        @objc func changeSliderValue(_ sender: UISlider) {
            currentValue = Double(sender.value)
        }
    }
}

struct UISliderRepresentation_Previews: PreviewProvider {
    static var previews: some View {
        UISliderRepresentation(currentValue: .constant(50), thumbOpacity: 50)
    }
}
