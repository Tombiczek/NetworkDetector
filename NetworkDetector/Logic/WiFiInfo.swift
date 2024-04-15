import Foundation
import CoreWLAN

class WiFiInfo: ObservableObject {
    @Published var ssid: String = "Unknown SSID"
    @Published var bssid: String = "Unknown BSSID"
    @Published var security: String = "Unknown Security"

    func fetchWiFiDetails() {
        print("Fetching WiFi details...")
        if let interface = CWWiFiClient.shared().interface() {
            let currentSSID = interface.ssid() ?? "Not Connected"
            let currentBSSID = interface.bssid() ?? "Not Connected"
            let currentSecurity = self.securityDescription(interface.security())
            
            print("Current SSID: \(currentSSID)")
            print("Current BSSID: \(currentBSSID)")
            print("Current Security: \(currentSecurity)")

            DispatchQueue.main.async {
                self.ssid = currentSSID
                self.bssid = currentBSSID
                self.security = currentSecurity
            }
        } else {
            DispatchQueue.main.async {
                self.ssid = "Wi-Fi Not Available"
                self.bssid = "Wi-Fi Not Available"
                self.security = "Wi-Fi Not Available"
            }
            print("WiFi interface not available or cannot be accessed.")
        }
    }


    private func securityDescription(_ security: CWSecurity) -> String {
        switch security {
        case .none:
            return "None"
        case .WEP:
            return "WEP"
        case .wpaPersonal:
            return "WPA Personal"
        case .wpaEnterprise:
            return "WPA Enterprise"
        case .wpa2Personal:
            return "WPA2 Personal"
        case .wpa2Enterprise:
            return "WPA2 Enterprise"
        case .wpa3Personal:
            return "WPA3 Personal"
        case .wpa3Enterprise:
            return "WPA3 Enterprise"
        case .personal:
            return "Personal"
        case .enterprise:
            return "Enterprise"
        case .unknown:
            return "Unknown"
        default:
            return "Other"
        }
    }

}
