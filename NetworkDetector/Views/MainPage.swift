import SwiftUI

struct MainPage: View {
    @ObservedObject var wifiInfo = WiFiInfo()
    @StateObject private var locationManager = LocationManager()
    var body: some View {
        HStack{
            VStack {
                Text("Wi-Fi Details")
                    .font(.title)
                Text("SSID: \(wifiInfo.ssid)")
                    .padding()
                Text("BSSID: \(wifiInfo.bssid)")
                    .padding()
                Text("Security: \(wifiInfo.security)")
                    .padding()
                if let location = locationManager.lastLocation {
                    Text("Last location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                        .padding()
                } else {
                    Text("No location data available")
                        .padding()
                }
                if locationManager.authorizationStatus == .notDetermined {
                    Button("Request Location Access") {
                        locationManager.requestAuthorization()
                    }
                }
                Button("Refresh Wi-Fi Info") {
                    wifiInfo.fetchWiFiDetails()
                }
            }
            .onAppear {
                wifiInfo.fetchWiFiDetails()
            }
        }
    }
}

#Preview {
    MainPage()
}
