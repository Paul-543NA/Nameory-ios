//
//  EditPersonView.swift
//  Nameory
//
//  Created by Paul Festor on 17/03/2024.
//

import SwiftUI
import PhotosUI
import SwiftData

struct EditPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var person: Person
    @Binding var navigationPath: NavigationPath
    
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var showingActionSheet = false
    @State private var showPhotoPicker = false
    @State private var showAvatarEditor = false
    @State private var isEventViewPresented = false
    
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]
    
    var body: some View {
        
        Form {
            
            Section {
                Button(action: {
                       showingActionSheet = true
                }) {
                    HStack {
                        Spacer()
                        PersonImageView(person: person, width: 250, height: 250, cornerRadius: 10)
                        Spacer()
                    }
                }
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Choose Action"), message: nil, buttons: [
                        .default(Text("Add Photo")) { showPhotoPicker = true },
                        .default(Text("Edit Avatar")) { addAvatar() },
                        .cancel()
                    ])
                }
            }.listRowBackground(Color.clear)
            
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                DatePicker("Date met", selection: $person.dateMet, displayedComponents: [.date])
            }
            
            Section("Where did you meet?") {
                HStack {
                    if let eventName = person.metAt?.name {
                        Text(eventName)
                    } else {
                        Text("Select an Event")
                            .foregroundColor(Color.blue)
                    }
                    Spacer()
                }
                .background { Color.clear }
                .onTapGesture { isEventViewPresented = true }
            }
            
            Section("Details") {
                TextField("Notes about this person", text: $person.notes, axis: .vertical)
            }
        }
        .navigationTitle("Edit person")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedPhotoItem, loadPhotoData)
        .photosPicker(isPresented: $showPhotoPicker, selection: $selectedPhotoItem, matching: .images)
        .navigationDestination(isPresented: $isEventViewPresented) {
            EventsSelectionScreen(person: person)
        }
        .sheet(isPresented: $showAvatarEditor) {
            AvatarEditView(avatar: Binding($person.avatar)!)
        }
        .onDisappear {
            let personHasNoName = person.name == ""
            let personHasNoPicture = (person.avatar == nil && person.photoData == nil)
            if personHasNoName && personHasNoPicture
            {
                modelContext.delete(person)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { doneButton }
        }
    }
    
    var doneButton: some View {
        Button("Done") {
            navigationPath.removeLast()
        }
    }
    
    func addAvatar() {
        if let _ = person.avatar {
            showAvatarEditor = true
        } else {
            let avatar = Avatar.defaultAvatar()
            modelContext.insert(avatar)
            person.avatar = avatar
            showAvatarEditor = true
        }
    }
    
    func loadPhotoData() {
        Task { @MainActor in
            person.photoData = try await selectedPhotoItem?.loadTransferable(type: Data.self)
        }
    }
}

//#Preview {
//    do {
//        let previewer = try Previewer()
//        return EditPersonView(person: previewer.person, navigationPath: .constant(NavigationPath())).modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to generate preview with error \(error.localizedDescription)")
//    }
//}
