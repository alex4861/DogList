//
//  ListItem.swift
//  DogListUI
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import SwiftUI

struct ListItem: View {

    /// The entity representing a dog.
    let entity: DogEntity

    var body: some View {
            HStack(alignment: .bottom, spacing: 0) {
                AsyncImage(url: URL(string: entity.image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .accessibilityIdentifier(entity.dogName)
                            .frame(width: 180 * 0.65, height: 180)
                            .cornerRadius(16)
                    } else if phase.error != nil {
                        Image("ErrorImage")
                            .resizable()
                            .accessibilityIdentifier("ErrorImage")
                            .frame(width: 180 * 0.65, height: 180)
                            .cornerRadius(16)
                    } else {
                        VStack { }
                        .frame(width: 180 * 0.65, height: 180)
                        .background(.gray)
                        .cornerRadius(16)
                    }

                }
                .zIndex(2)
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(entity.dogName)
                            .font(Font.system(size: 22, weight: .regular))
                            .foregroundStyle(.appPrimary)
                        Spacer()
                        Text(entity.description)
                            .font(Font.system(size: 14, weight: .regular))
                            .foregroundStyle(.appSecondary)
                        Spacer()
                        Text("Almost \(entity.age) years")
                            .font(Font.system(size: 14, weight: .medium))
                            .foregroundStyle(.appPrimary)

                    }
                    Spacer()
                }
                .padding(.trailing, 10)
                .padding(.vertical, 16)
                .padding(.leading, 36)
                .background(.white)
                .cornerRadius(16)
                .offset(x: -20)
                .zIndex(1)
                .frame(height: 180-30)
            }

    }

}

#Preview {
    let entity = DogEntity(dogName: "Buddy",
                           description: "A friendly golden retriever",
                           age: 3,
                           image: "https://example.com/image.jpg")
    ListItem(entity: entity)
}
