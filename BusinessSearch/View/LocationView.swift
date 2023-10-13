import SwiftUI
import MapKit

struct LocationView: View {

    private enum Constants {
        static let mapBounds = MapCameraBounds(minimumDistance: 1000, maximumDistance: 1000)
        static let mapWidth: CGFloat = 75
        static let mapHeight: CGFloat = 75
        static let markerImageName = "fork.knife"
    }

    private let name: String
    private let address: [String]
    private let coordinate: CLLocationCoordinate2D

    init(name: String,
         address: [String],
         coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.coordinate = coordinate
    }

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                ForEach(address, id: \.self) { line in
                    Text(line)
                }
            }
            Spacer()
            Map(bounds: Constants.mapBounds,
                interactionModes: []) {
                Marker(coordinate: coordinate) {
                    Image(systemName: Constants.markerImageName)
                }
            }
            .frame(width: Constants.mapWidth, height: Constants.mapHeight)
            .onTapGesture {
                MKMapItem.openMaps(with: self.mkMapItemForCoordinate)
            }
        }
        .padding()
        .background(Color.secondarySystemBackground)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
    }

    var mkMapItemForCoordinate: [MKMapItem] {
        let placemark = MKPlacemark(coordinate: coordinate)
        let item = MKMapItem(placemark: placemark)
        item.name = self.name
        return [item]
    }
}

#Preview {
    LocationView(name: "Playa Cabana",
                 address: ["111 Dupont Street",
                           "Toronto, ON M5R 1V4",
                           "Canada"],
                 coordinate: CLLocationCoordinate2D(latitude: 52, longitude: 52))
}
