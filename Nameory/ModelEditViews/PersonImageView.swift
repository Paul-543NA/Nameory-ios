//
//  PersonImageView.swift
//  Nameory
//
//  Created by Paul Festor on 28/03/2024.
//

import SwiftUI
import SwiftData

struct PersonImageView: View {

    @Bindable var person: Person
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    
    var body: some View {
        if let imageData = person.photoData, let uiimage = UIImage(data: imageData) {
            Image(uiImage: uiimage)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipShape(.rect(cornerRadius: cornerRadius))
                
        } else if let avatar = person.avatar {
            AvatarView(avatar: avatar)
                .frame(width: width, height: height)
                .clipShape(.rect(cornerRadius: cornerRadius))
        } else {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: width, height: height)
                .clipShape(.rect(cornerRadius: cornerRadius))
                .scaledToFit()
        }
    }
}



#Preview {
    do {
        let previewer = try Previewer()
        return PersonImageView(person: previewer.person, width: 250, height: 250, cornerRadius: 20)
    } catch {
        return Text("Failed to generate preview with error \(error.localizedDescription)")
    }
}
