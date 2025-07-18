//
//  FindMateViewModel.swift
//  MatchMate
//
//  Created by Shubh Jain on 17/07/25.
//

import Foundation
import Combine

class FindMateViewModel : ObservableObject {
    private let service : ApiServices
    @Published var profiles : [UserEntity] = []
    private let coreDataManager = CoreDataManager.shared
    
    public init(service : ApiServices = ApiServices(baseURL: Constants.baseURL)) {
        self.service = service
        fetchProfilesFromApi()
        fetchSavedProfiles()
    }
    
    func fetchProfilesFromApi(){
        Task{
            let profile = try await self.service.fetchDetails(endpoint:Constants.endPoint)
            if profile != nil {
                self.saveToCoreData(fetchedProfiles: profile?.results ?? [])
            }
            else{
                print("Profile Not Fetched")
            }
        }
    }
    func fetchSavedProfiles(){
        DispatchQueue.main.async {
            self.profiles = self.coreDataManager.fetchUser()
        }
    }
    private func saveToCoreData( fetchedProfiles : [UserModel]){
        let userIds = Set(profiles.map {$0.userId})
        for user in fetchedProfiles {
            if !userIds.contains(user.login?.uuid ?? "") {
                coreDataManager.addPeople(id: user.login?.uuid ?? "", firstName: user.name?.first ?? "", lastName: user.name?.last ?? "", imageURL: user.picture?.large ?? "", status: "", city: "", state: "", country: "")
            }
            else{
                print("Already Exists")
            }
        }
        self.fetchSavedProfiles()
    }
    
    func accept(user : UserEntity) {
        coreDataManager.updatePeopleStatus(id: user.userId ?? "", status: "Accepted")
        fetchSavedProfiles()
    }
    func reject(user : UserEntity) {
        coreDataManager.updatePeopleStatus(id: user.userId ?? "", status: "Rejected")
        fetchSavedProfiles()
    }
    func syncDataToServer() {
        
    }
}
