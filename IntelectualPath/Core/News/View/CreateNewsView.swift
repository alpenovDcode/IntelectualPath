//
//  CreateNewsView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.05.2024.
//

import SwiftUI

struct CreateNewsView: View {
    @State private var username = ""
    @State private var topic = ""
    @State private var text = ""
    @ObservedObject var viewModel: NewsViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var showPermissionAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Создать новость")) {
                TextField("Имя пользователя", text: .constant(authViewModel.currentUser?.fullName ?? ""))
                    .disabled(true)

                TextField("Тема", text: $topic)
                TextEditor(text: $text)
                    .frame(minHeight: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.vertical)
                
                Button("Опубликовать новость") {
                    viewModel.addNewsItemToFirestore(username: username, topic: topic, text: text)
                    // Reset fields after posting
                    username = ""
                    topic = ""
                    text = ""
                }

            }
        }
    }
}
    
    //struct ImagePicker: UIViewControllerRepresentable {
    //    @Binding var image: UIImage?
    //
    //    func makeUIViewController(context: Context) -> UIImagePickerController {
    //        let picker = UIImagePickerController()
    //        picker.delegate = context.coordinator
    //        return picker
    //    }
    //
    //    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    //
    //    func makeCoordinator() -> Coordinator {
    //        Coordinator(self)
    //    }
    //
    //    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    //        var parent: ImagePicker
    //
    //        init(_ parent: ImagePicker) {
    //            self.parent = parent
    //        }
    //
    //        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    //            if let uiImage = info[.originalImage] as? UIImage {
    //                parent.image = uiImage
    //            }
    //
    //            picker.dismiss(animated: true)
    //        }
    //    }
    //}
    
