//
//  VideoPicker.swift
//  OpenControl
//
//  Created by Александр Алексеев on 07.05.2023.
//

import SwiftUI
import UIKit


struct VideoPicker: UIViewControllerRepresentable {
  
  @Binding var videoURL: URL?
  @Environment(\.presentationMode) var presentationMode
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.mediaTypes = ["public.movie"]
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let parent: VideoPicker
    
    init(parent: VideoPicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      guard let url = info[.mediaURL] as? URL else { return }
      parent.videoURL = url
      parent.presentationMode.wrappedValue.dismiss()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      parent.presentationMode.wrappedValue.dismiss()
    }
    
  }
  
}

//
//struct VideoPicker_Previews: PreviewProvider {
//    static var previews: some View {
//       // VideoPicker()
//    }
//}
