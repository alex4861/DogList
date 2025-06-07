//
//  ListView.swift
//  DogListUI
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import SwiftUI

struct ListView: View {
    @Environment(ViewModel.self) var viewModel
    var body: some View {
        NavigationStack {
            List(viewModel.items, id: \.id) {
                ListItem(entity: $0)
                    .accessibilityIdentifier("DogCell_\($0.id)")
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 12, leading: 10, bottom: 12, trailing: -4))
                    .listRowBackground(EmptyView())
                    .shadow(radius: 0.05)
            }
            .accessibilityIdentifier("DogList")
            .listStyle(.plain)
            .task {
                try? await viewModel.fecthDogs()
            }
            .background(Color.appTertiary)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Back button pressed")
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.appSecondary)
                    }
                    .accessibilityIdentifier("BackButton")
                    .padding(.leading, 12)
                }
                ToolbarItem(placement: .principal) {
                    Text("Dogs We Love")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundStyle(.appPrimary)
                }
            }
            .navigationBarBackButtonHidden(false)
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}

#Preview {
    ListView()
        .environment(ViewModel(serviceManager: ServiceRequest(session: URLSession.shared),
                               databaseManager: Database(),
                               userDefaults: UserDefaults.standard,
                               url: URL(string: "https://jsonblob.com/api/1151549092634943488")))
}
