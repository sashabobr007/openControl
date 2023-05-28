//
//  DocumentPicker.swift
//  OpenControl
//
//  Created by Александр Алексеев on 07.05.2023.
//

import SwiftUI
import UIKit

struct DocumentPicker: UIViewControllerRepresentable {
  
  @Binding var documentURL: URL?
  @Environment(\.presentationMode) var presentationMode
  
  func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
    let picker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  class Coordinator: NSObject, UIDocumentPickerDelegate {
    
    let parent: DocumentPicker
    
    init(parent: DocumentPicker) {
      self.parent = parent
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
      guard let url = urls.first else { return }
      parent.documentURL = url
      parent.presentationMode.wrappedValue.dismiss()
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
      parent.presentationMode.wrappedValue.dismiss()
    }
    
  }
  
}

//struct DocumentPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentPicker()
//    }
//}
