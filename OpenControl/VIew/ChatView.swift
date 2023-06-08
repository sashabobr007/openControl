//
//  ChatView.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 20.04.2023.
//
import SwiftUI
import PhotosUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ChatView: View {
    var user : User?
    let id = Database.shared.getUuid()
   
//    init(user: User?) {
//        self.user = user
//        self.chat = ChatViewModel(user: user)
//        self.id = Database.shared.getUuid()
//
//        //print(self.id!)
//    }
    @State var selectedItems: [PhotosPickerItem] = []

    @State private var image : UIImage?
    @State private var videoURL: URL?
    @State private var documentURL: URL?


    @State private var showSheet = false
    @State private var showingVideoPicker = false
    @State private var showingDocumentPicker = false
    
    @State var chatText = ""
    @ObservedObject var chat : ChatViewModel
    
    @State var mDate = ""
    
    @Binding var show : Bool

    
    var body: some View {
        VStack{
            Button {
                show.toggle()
            } label: {
                ZStack{
                   
                    Text("Закрыть чат").foregroundColor(mainColorOrange1)
                }

            }.frame(width: 100, height: 100)

            ScrollView{
                ScrollViewReader{ scrollViewProxy in
                    VStack{
                        
                    ForEach(chat.chatMessages){ message in
                        
                        VStack{
                            
                            if message.fromId == self.id{
                                
                                HStack{
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        
                                        if message.docType.count == 0{
                                        HStack{
                                            
                                                
                                                Text(message.text).foregroundColor(.white)
                                            }.padding().background(mainColorBlue1).cornerRadius(27, corners: [.bottomLeft, .topLeft, .topRight]).cornerRadius(2, corners: .bottomRight)
                                            
                                            Text(message.timeHM).foregroundColor(mainColorBlue1)
                                            
                                        }
                                        else{
//                                            AsyncImage(url: URL(string: message.docUrl), content: { image in
//                                                image.resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 10))
//
//                                            }, placeholder: {
//                                                ProgressView()
//                                            }).frame(width: 100, height: 100)
                                        }
                                    }
                                }.padding(.horizontal).padding(.top, 8)
                            }else {
                                HStack{
                                    VStack(alignment: .leading){
                                        if message.docType.count == 0{
                                            HStack{
                                                
                                                Text(message.text).foregroundColor(Color(hex: "3A3A41"))
                                            }.padding().background(Color(hex: "F0F0F5")).cornerRadius(27, corners: [.bottomRight, .topLeft, .topRight]).cornerRadius(2, corners: .bottomLeft)
                                            
                                            Text(message.timeHM)
                                            
                                        }else{
                                            AsyncImage(url: URL(string: message.docUrl), content: { image in
                                                image.resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 10))
                                                
                                            }, placeholder: {
                                                ProgressView()
                                            }).frame(width: 100, height: 100)
                                        }
                                    }
                                    Spacer()
                                    
                                }.padding(.horizontal).padding(.top, 8)
                            }
                        }
                        
                        
                    }
                    
                    
                HStack{
                    Spacer()
                }
                .id("Empty")
                
            }
                    .onReceive(chat.$count){_ in
                        withAnimation(.easeOut(duration: 0.5)){
                            scrollViewProxy.scrollTo("Empty", anchor: .bottom)
                        }
                    }
                    .onAppear {
                       // self.mDate = chat.chatMessages[0].timeDay
                    }
                
                
            }
                
                
            }.background(Color(hex: "FCFCFD")).clipped()
            
            VStack{
                
                HStack {
                    if self.image != nil{
                        Image(uiImage: self.image!)
                      .resizable().frame(width: 100, height: 100)
                    .background(Color.black.opacity(0.2))
                      .aspectRatio(contentMode: .fill)
                      .clipShape(Circle())
                    }
                                

                        }
                    .padding(.horizontal, 20)
                    .sheet(isPresented: $showSheet) {
                                
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)

                                
                                
                        }.sheet(isPresented: $showingVideoPicker) {
                            VideoPicker(videoURL: self.$videoURL)
                          }
                
                        .sheet(isPresented: $showingDocumentPicker) {
                          DocumentPicker(documentURL: self.$documentURL)
                        }

                
                HStack(spacing: 16){
                    
//
//                    PhotosPicker(selection: $selectedItems,
//                                 matching: .any(of: [.images, .videos])) {
//                        Image(systemName: "photo")
//
//                    }
                    
//                    Menu {
//
//
//
//                        Button {
//                            showSheet = true
//                        } label: {
//                            Image(systemName: "photo")
//                        }
//
//                        Button {
//                            self.showingDocumentPicker = true
//
//                        } label: {
//                            Image(systemName: "doc.fill.badge.plus")
//                        }
//
//                        Button {
//                            self.showingVideoPicker = true
//
//                        } label: {
//                            Image(systemName: "video.and.waveform")
//
//                        }
//
//
//                    } label: {
//                        Image(systemName: "square.and.arrow.up")
//                    }
                    
//                    Button {
//                        showSheet = true
//                    } label: {
//                        Image(systemName: "square.and.arrow.up")
//                    }
                    
                    
                    
                    ZStack{
                        TextField("Написать сообщение", text: $chat.text).textFieldStyle(.roundedBorder).clipShape(Capsule())
                       
                        HStack{
                            Spacer()
                            Button {
                                
                                if chat.text.count != 0{
                                    chat.handleSend(text: "", docUrl: "", docType: "")
                                }else{
                                    
                                    if self.image != nil {
                                        chat.sendDoc(uploadData: compressImage(image: self.image!) ?? Data(), picker: .image, file: nil)
                                        
                                        self.image = nil
                                        
                                    }
                                    if self.videoURL != nil {
                                        let videoData = try? Data(contentsOf: videoURL!)
                                        chat.sendDoc(uploadData: videoData ?? Data(), picker: .video, file: nil)
                                    }
                                    if self.documentURL != nil{
                                        let name = documentURL?.deletingPathExtension().lastPathComponent
                                        print(name)
                                        chat.sendDoc(uploadData: Data(), picker: .file, file: documentURL)
                                        
                                    }
                                    
                                }
                                
                            } label: {
                                Image(systemName: "paperplane.fill").font(.system(size: 24)).foregroundColor(mainColorBlue1)
                            }.padding(.horizontal).padding(.vertical, 8).cornerRadius(4).padding(.top, 5)
                            
                            
                        }
                    }
                    
                    
                }.padding(.horizontal).padding(.bottom, 5).background(Color(hex: "D9D9D9"))
            }
        }
        
        //.navigationTitle(user?.email ?? "email").navigationBarTitleDisplayMode(.inline)
//        .toolbar(content: {
//            HStack{
//                VStack(alignment: .leading){
//                    Text("Полина Кузьминкина")
//                    Text("инспектор")
//
//                }
//                Text("             ")
//                Spacer()
//
//                NavigationLink {
//                    Video(user: user)
//                } label: {
//                    ZStack{
//                        //  Circle().foregroundColor(Color(hex: "DADADA")).frame(width: 35, height: 35)
//                        Image(systemName: "video.and.waveform").foregroundColor(mainColorBlue1)
//                    }
//                }
//            }
//
//        })
        
        
    }
    
    
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            ChatView(user: User(uid: "sdf", email: "test"))
//        }
//    }
//}
