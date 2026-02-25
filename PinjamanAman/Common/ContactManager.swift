//
//  ContactManager.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/10.
//


import UIKit
import Contacts
import ContactsUI

struct ContactResult: Codable {
    let closer: String
    let blend: String
}

final class ContactManager: NSObject {
    
    static let shared = ContactManager()
    private let store = CNContactStore()
    
    private override init() {}
    
    func checkAuthorization(from vc: UIViewController,
                            authorized: @escaping () -> Void) {
        
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized, .limited:
            authorized()
            
        case .notDetermined:
            store.requestAccess(for: .contacts) { granted, _ in
                DispatchQueue.main.async {
                    if granted {
                        authorized()
                    } else {
                        self.showSettingAlert(from: vc)
                    }
                }
            }
            
        case .denied, .restricted:
            showSettingAlert(from: vc)
            
        @unknown default:
            break
        }
    }
    
    private func showSettingAlert(from vc: UIViewController) {
        let title = AppLanguageCodeManager.getLanguageCode() == "1105" ? "Contacts Permission" : "Izin Kontak"
        let message = AppLanguageCodeManager.getLanguageCode() == "1105" ? "o verify your identity, prevent fraud and improve review efficiency, we need your contacts permission. Please enable it in Settings." : "Untuk verifikasi identitas, cegah penipuan dan tingkatkan efisiensi, kami memerlukan izin kontak. Silakan aktifkan di Pengaturan."
        AppAlertCofigManager.showAuthAlert(title: title, message: message)
    }
    
    func fetchAllContacts(completion: @escaping ([ContactResult]) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            var results: [ContactResult] = []
            
            let keys: [CNKeyDescriptor] = [
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor
            ]
            
            let request = CNContactFetchRequest(keysToFetch: keys)
            
            try? self.store.enumerateContacts(with: request) { contact, _ in
                
                let phones = contact.phoneNumbers
                    .map { $0.value.stringValue }
                    .filter { !$0.isEmpty }
                
                guard !phones.isEmpty else { return }
                
                let name = "\(contact.familyName)\(contact.givenName)"
                let phoneString = phones.joined(separator: ",")
                
                results.append(
                    ContactResult(
                        closer: phoneString,
                        blend: name
                    )
                )
            }
            
            DispatchQueue.main.async {
                completion(results)
            }
        }
    }

    
    func presentContactPicker(from vc: UIViewController,
                              completion: @escaping (ContactResult?) -> Void) {
        
        self.pickerCompletion = completion
        
        let picker = CNContactPickerViewController()
        picker.delegate = self
        picker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        
        vc.present(picker, animated: true)
    }
    
    private var pickerCompletion: ((ContactResult?) -> Void)?
}

// MARK: - CNContactPickerDelegate
extension ContactManager: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController,
                       didSelect contact: CNContact) {
        
        let name = "\(contact.familyName) \(contact.givenName)"
        
        guard let firstPhone = contact.phoneNumbers.first?.value.stringValue else {
            pickerCompletion?(nil)
            return
        }
        
        let result = ContactResult(
            closer: firstPhone,
            blend: name
        )
        
        pickerCompletion?(result)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        pickerCompletion?(nil)
    }
}
