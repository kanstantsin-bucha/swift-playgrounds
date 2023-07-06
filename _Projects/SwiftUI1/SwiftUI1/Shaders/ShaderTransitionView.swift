//
//  ShaderTransitionView.swift
//  SwiftUI1
import SwiftUI

@available(iOS 17, *)
struct ShaderTransitionView: View {
    private let size: CGPoint = CGPoint(x: 300, y: 200)
    private var effectValue: CGFloat = 0
    @State private var isFirst = true
    private var isShaderViewVisible = false
    
    var shiftTransition: AnyTransition {
        let insertionTransition: AnyTransition = .modifier(
            active: ShiftTransitionModifier(effectValue: -1),
            identity: ShiftTransitionModifier(effectValue: 0)
        )
        let removalTransition: AnyTransition = .modifier(
            active: ShiftTransitionModifier(effectValue: -1),
            identity: ShiftTransitionModifier(effectValue: 0)
        )

        return .asymmetric(insertion: insertionTransition, removal: removalTransition)
    }
   
    
    private var sineShader: Shader {
        let shaderLibrary = ShaderLibrary.default
        return Shader(
            function: ShaderFunction(
                library: shaderLibrary,
                name: "sineShader"
            ),
            arguments: [.float2(self.size)]
        )
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea()
            VStack {
                if isShaderViewVisible {
                    testView(systemName: "cross.fill")
                        .distortionEffect(sineShader, maxSampleOffset: CGSize(width: 500, height: 500))
                        .overlay(Rectangle().stroke(Color.blue))
                }
                if isFirst {
                    testView(systemName: "globe")
                        .distortionEffect(sineShader, maxSampleOffset: CGSize(width: 500, height: 500))
                        .overlay(Rectangle().stroke(Color.blue))
                        .transition(shiftTransition)
                       
                } else {
                    testView(systemName: "cross")
                        .transition(shiftTransition)
                }
                    
                Button("Toggle") {
                    withAnimation {
                        isFirst.toggle()
                    }
                }
            }
        }
    }
    
    private func testView(systemName: String) -> some View {
        VStack {
            Image(systemName: systemName)
                .imageScale(.large)
            Text("Hello, Shader Effect!")
        }
        .frame(width: size.x, height: size.y)
        .background(Color.blue.opacity(0.1))
    }
}

@available(iOS 17, *)
struct DistortionTransitionViewPreview: PreviewProvider {
    static var previews: some View {
        ShaderTransitionView()
    }
}


@available(iOS 17, *)
struct ShiftTransitionModifier: ViewModifier {
    let size: CGPoint = CGPoint(x: 300, y: 200)
    var effectValue: CGFloat = 0
    
    private var transitionShader: Shader {
        let shaderLibrary = ShaderLibrary.default
        return Shader(
            function: ShaderFunction(
                library: shaderLibrary,
                name: "transitionShader"
            ),
            arguments: [.float2(self.size), .float(self.effectValue)]
        )
    }
    
    private var slideAwayShader: Shader {
        let shaderLibrary = ShaderLibrary.default
        return Shader(
            function: ShaderFunction(
                library: shaderLibrary,
                name: "slideAwayShader"
            ),
            arguments: [.float2(self.size), .float(self.effectValue),  .float(1)]
        )
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: self.size.x, height: self.size.y)
            .distortionEffect(self.slideAwayShader, maxSampleOffset: CGSize(width: 500, height: 500))
    }
}
