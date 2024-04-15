import Foundation
import CoreWLAN

class WiFiInfo: ObservableObject {
    @Published var ssid: String = "Unknown SSID"
    @Published var bssid: String = "Unknown BSSID"
    @Published var security: String = "Unknown Security"

    func fetchWiFiDetails() {
        print("Fetching WiFi details...")
        guard let interface = CWWiFiClient.shared().interface(), interface.powerOn() else {
            print("WiFi interface not available or powered off.")
            DispatchQueue.main.async {
                self.ssid = "Wi-Fi Not Available"
                self.bssid = "Wi-Fi Not Available"
                self.security = "Wi-Fi Not Available"
            }
            return
        }

        if let currentSSID = interface.ssid() {
            print("Current SSID: \(currentSSID)")
        } else {
            print("SSID is nil")
        }

        if let currentBSSID = interface.bssid() {
            print("Current BSSID: \(currentBSSID)")
        } else {
            print("BSSID is nil")
        }

        let currentSecurity = self.securityDescription(interface.security())
        DispatchQueue.main.async {
            self.ssid = interface.ssid() ?? "Error"
            self.bssid = interface.bssid() ?? "Error"
            self.security = currentSecurity
            print("SSID: \(self.ssid), BSSID: \(self.bssid), Security: \(self.security)")
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
