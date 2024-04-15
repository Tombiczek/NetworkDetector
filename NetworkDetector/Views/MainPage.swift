import SwiftUI

struct MainPage: View {
    @ObservedObject var wifiInfo = WiFiInfo()
    var body: some View {
        VStack {
            Text("Wi-Fi Details")
                .font(.title)
            Text("SSID: \(wifiInfo.ssid)")
                .padding()
            Text("BSSID: \(wifiInfo.bssid)")
                .padding()
            Text("Security: \(wifiInfo.security)")
                .padding()
            Button("Refresh Wi-Fi Info") {
                wifiInfo.fetchWiFiDetails()
            }
        }
        .onAppear {
            wifiInfo.fetchWiFiDetails()
        }
    }
}

#Preview {
    MainPage()
}
