//
//  SwiftUIView.swift
//  Runner
//
//  Created by Иван Чернокнижников on 21.03.2024.
//

import SwiftUI

struct SwiftUIView: View {
    let arg1: String
    let arg2: Int
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            Text("Argument 1: \(arg1)")
            Text("Argument 2: \(arg2)")
            Button("Back to Flutter") {
                self.backToFlutter()
            }
//            Button(action: {
//                self.isPresented.toggle()
//            }) {
//                Text("Open SwiftUI View")
//            }
//            .sheet(isPresented: $isPresented) {
//                //                    /*AnotherSwiftUIView*/()
//            }
        }
    }
    
    func backToFlutter() {
        
        let returnValue = "Data from SwiftUI"
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
               let navigationController = appDelegate.window?.rootViewController as? UINavigationController,
               let flutterViewController = navigationController.viewControllers.first as? FlutterViewController {
                
                // Create the method channel using the correct binaryMessenger
                let channel = FlutterMethodChannel(name: "my_flutter_plugin", binaryMessenger: flutterViewController.binaryMessenger)
                
                // Send the data back to Flutter
                print("Invoke method")
                channel.invokeMethod("onDataReturned", arguments: [arg1,arg2])
            }
           
        if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
            // Check if the FlutterViewController is on the stack.
            if navigationController.viewControllers.first is         FlutterViewController {
                navigationController.popViewController(animated: true)
            }
        }
    }
}

#Preview {
    SwiftUIView(arg1: "", arg2: 0)
}
