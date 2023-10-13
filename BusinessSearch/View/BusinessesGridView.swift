import SwiftUI

struct BusinessesGridView: View {

    @Bindable private var viewModel: BusinessesGridViewModel

    init(viewModel: BusinessesGridViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewModel.businesses) { business in
                        NavigationLink {
                            BusinessDetailsView(viewModel: business.businessDetailsViewModel)
                        } label: {
                            BusinessTile(viewModel: business)
                        }
                        .accessibilityIdentifier(business.name)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("BusinessGridTitle")
            .toolbar {
                Menu {
                    ForEach(BusinessSortOption.allCases, id: \.self) { sortOption in
                        Button {
                            viewModel.sortBusinesses(by: sortOption)
                        } label: {
                            Label(sortOption.label, systemImage: sortOption.imageName)
                        }
                    }
                } label: {
                    Text("SortToolbarButton")
                }
            }
            .accessibilityIdentifier("businessesScrollView")
        }
        .searchable(text: $viewModel.searchQuery)
        .onSubmit(of: .search) {
            self.loadBusinesses()
        }
        .task {
            self.loadBusinesses()
        }
        .alert(isPresented: $viewModel.errorOccured) {
            Alert(title: Text("BusinessesLoadErrorText"),
                  primaryButton: .default(Text("BusinessesLoadErrorAlertRetry"), 
                                          action: { self.loadBusinesses() }),
                  secondaryButton: .cancel())
        }
    }

    private func loadBusinesses() {
        Task {
            try await viewModel.loadBusinesses()
        }
    }
}

#Preview {
    BusinessesGridView(viewModel: BusinessesGridViewModel())
}
