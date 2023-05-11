//
//  Picker.swift
//  OpenControl
//
//  Created by Александр Алексеев on 06.05.2023.
//

import SwiftUI
import PhotosUI

struct PickerNew: View {
    @State var selectedItems: [PhotosPickerItem] = []

    var body: some View {
        
        PhotosPicker(selection: $selectedItems,
                     matching: .any(of: [.images, .videos])) {
            Text("Select Multiple Photos")
        }
    }
}

struct Picker_Previews: PreviewProvider {
    static var previews: some View {
        PickerNew()
    }
}
