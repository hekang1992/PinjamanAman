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
        let alert = UIAlertController(
            title: "无法访问通讯录",
            message: "请在系统设置中开启通讯录权限",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        vc.present(alert, animated: true)
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
