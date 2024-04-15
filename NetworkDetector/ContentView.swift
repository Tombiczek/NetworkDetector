import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            MainPage()
                .tabItem {
                    Text("Network Detector")
            }
            SettingsPage()
                .tabItem {
                    Text("Settings")
            }
        }
        .tint(.orange)
    }
}

#Preview {
    ContentView()
}
