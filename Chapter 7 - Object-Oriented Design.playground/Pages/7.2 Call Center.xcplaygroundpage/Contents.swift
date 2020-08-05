//: [Previous](@previous)
import Combine
import Foundation

//: ### Imagine you have a call center with three levels of employees: respondent, manager, and director. An incoming telephone call must be first allocated to a respondent who is free. If the respondents can't handle the call, he or she must escalate the call to a manager. If the manager is not free or not able to handle it, then the call should be escalated to a director. Design the class and data structure for this problem. Implement a method dispatchCall() which assigns a call to the first available employee.

// Using different Observer patterns:
// Combine, Delegate, NotificationCenter, None




/// Use Combine


struct Call {}

enum Role { case respondent, manager, director}

class Employee {
    private(set) var currentCall: Call? = nil

    // replace delegate with PassthroughSubject
    let completed = PassthroughSubject<Role, Never>()
    let escalated = PassthroughSubject<(Role, Call), Never>()

    let role: Role

    init(_ role: Role){
        self.role = role
    }

    func assignToCall(_ call: Call){
        self.currentCall = call
    }

    func completeCall(){
        currentCall = nil
        completed.send(role)
    }

    func escalateCall() {
        guard let currentCall = currentCall else { return }
        print("escalated.send")
        escalated.send((role, currentCall))
    }

}

class CallCenter {
    private(set) var standardQueue = [Call]()
    private(set) var managerQueue = [Call]()
    private(set) var directorQueue = [Call]()

    let directors: [Employee]
    let managers: [Employee]
    let respondents: [Employee]

    var firstAvailableEmployee: Employee? {
        return respondents.filter({ $0.currentCall == nil }).randomElement()
    }

    var firstAvailableManager: Employee? {
        return managers.filter({ $0.currentCall == nil }).randomElement()
    }

    var firstAvailableDirector: Employee? {
        return directors.filter({ $0.currentCall == nil }).randomElement()
    }
    
    // required to prevent our subscription from being immediately deallocated
    var subscriptions = Set<AnyCancellable>()

    init(respondents: [Employee], managers: [Employee], directors: [Employee]){
        self.respondents = respondents
        self.managers = managers
        self.directors = directors

        for employee in (respondents + managers + directors) {
            employee.completed
                .handleEvents(receiveOutput: { [unowned self] role in
                    self.completeCall(role)
                }).sink { _ in }
                .store(in: &subscriptions)

            employee.escalated
                .handleEvents(receiveOutput: { [unowned self] (role, call) in
                    print("ROLE CALL", role, call)
                    self.escalateCall(role, call)
                }).sink { _ in }
                .store(in: &subscriptions)
        }

    }

    func completeCall(_ role: Role){
        switch role {
        case .respondent:
            if !standardQueue.isEmpty, let employee = firstAvailableEmployee  {
                employee.assignToCall(standardQueue.removeFirst())
            }
        case .manager:
            if !managerQueue.isEmpty, let manager = firstAvailableManager {
                manager.assignToCall(managerQueue.removeFirst())
            }
        case .director:
            if !directorQueue.isEmpty, let director = firstAvailableDirector {
                director.assignToCall(managerQueue.removeFirst())
            }
        }

    }

    func escalateCall(_ role: Role, _ call: Call){
        print("ROLE", role, call)
        switch role {
        case .respondent:
            managerQueue.append(call)
        case .manager:
            directorQueue.append(call)
        case .director:
            break
        }
        handleEscalatedCall()
    }

    func dispatchCall(_ call: Call){
        standardQueue.append(call)
        if let employee = firstAvailableEmployee {
            employee.assignToCall(standardQueue.removeFirst())
        }
    }

    func handleEscalatedCall(){
        if let manager = firstAvailableManager {
            manager.assignToCall(managerQueue.removeFirst())
        } else if let director = firstAvailableDirector {
            director.assignToCall(managerQueue.removeFirst())
        }
    }


}


let callCenter = CallCenter(
    respondents: [Employee(.respondent)],
    managers: [Employee(.manager)],
    directors: [Employee(.director)]
)

let call = Call()

callCenter.dispatchCall(call)
print("respondent", callCenter.respondents.first?.currentCall ?? "")
print("manager", callCenter.managers.first?.currentCall ?? "")
print("director", callCenter.directors.first?.currentCall ?? "")

print("standardQueue", callCenter.standardQueue)
callCenter.dispatchCall(call)
print("standardQueue", callCenter.standardQueue)

callCenter.respondents.first?.escalateCall()
print("manager", callCenter.managers.first?.currentCall ?? "")
print("director", callCenter.directors.first?.currentCall ?? "")

callCenter.respondents.first?.escalateCall()
print("manager", callCenter.managers.first?.currentCall ?? "")
print("director", callCenter.directors.first?.currentCall ?? "")





/// Delegate Pattern


//struct Call {}
//
//enum Role { case respondent, manager, director}
//
//class Employee {
//    private(set) var currentCall: Call? = nil
//    weak var delegate: CallHanderDelegate?
//    let role: Role
//
//    init(_ role: Role){
//        self.role = role
//    }
//
//    func assignToCall(_ call: Call){
//        self.currentCall = call
//    }
//
//    func completeCall(){
//        currentCall = nil
//        delegate?.completeCall(role)
//    }
//
//    func escalateCall() {
//        guard let currentCall = currentCall else { return }
//        delegate?.escalateCall(role, currentCall)
//    }
//
//}
//
//protocol CallHanderDelegate: class {
//    func completeCall(_: Role)
//    func escalateCall(_: Role, _:Call)
//}
//
//class CallCenter {
//    private(set) var standardQueue = [Call]()
//    private(set) var managerQueue = [Call]()
//    private(set) var directorQueue = [Call]()
//
//    let directors: [Employee]
//    let managers: [Employee]
//    let respondents: [Employee]
//
//    var firstAvailableEmployee: Employee? {
//        return respondents.filter({ $0.currentCall == nil }).randomElement()
//    }
//
//    var firstAvailableManager: Employee? {
//        return managers.filter({ $0.currentCall == nil }).randomElement()
//    }
//
//    var firstAvailableDirector: Employee? {
//        return directors.filter({ $0.currentCall == nil }).randomElement()
//    }
//
//    init(respondents: [Employee], managers: [Employee], directors: [Employee]){
//        self.respondents = respondents
//        self.managers = managers
//        self.directors = directors
//
//        for employee in (respondents + managers + directors) {
//            employee.delegate = self
//        }
//
//    }
//
//    func dispatchCall(_ call: Call){
//        standardQueue.append(call)
//        if let employee = firstAvailableEmployee {
//            employee.assignToCall(standardQueue.removeFirst())
//        }
//    }
//
//    func handleEscalatedCall(){
//        if let manager = firstAvailableManager {
//            manager.assignToCall(managerQueue.removeFirst())
//        } else if let director = firstAvailableDirector {
//            director.assignToCall(managerQueue.removeFirst())
//        }
//    }
//
//
//}
//
//extension CallCenter: CallHanderDelegate {
//    func completeCall(_ role: Role){
//        switch role {
//        case .respondent:
//            if !standardQueue.isEmpty, let employee = firstAvailableEmployee  {
//                employee.assignToCall(standardQueue.removeFirst())
//            }
//        case .manager:
//            if !managerQueue.isEmpty, let manager = firstAvailableManager {
//                manager.assignToCall(managerQueue.removeFirst())
//            }
//        case .director:
//            if !directorQueue.isEmpty, let director = firstAvailableDirector {
//                director.assignToCall(managerQueue.removeFirst())
//            }
//        }
//
//    }
//
//    func escalateCall(_ role: Role, _ call: Call){
//        switch role {
//        case .respondent:
//            managerQueue.append(call)
//        case .manager:
//            directorQueue.append(call)
//        case .director:
//            break
//        }
//        handleEscalatedCall()
//    }
//}
//
//
//let callCenter = CallCenter(
//    respondents: [Employee(.respondent)],
//    managers: [Employee(.manager)],
//    directors: [Employee(.director)]
//)
//
//let call = Call()
//
//callCenter.dispatchCall(call)
//print("respondent", callCenter.respondents.first?.currentCall)
//print("manager", callCenter.managers.first?.currentCall)
//print("director", callCenter.directors.first?.currentCall)
//
//print("standardQueue", callCenter.standardQueue)
//callCenter.dispatchCall(call)
//print("standardQueue", callCenter.standardQueue)
//
//callCenter.respondents.first?.escalateCall()
//print("manager", callCenter.managers.first?.currentCall)
//print("director", callCenter.directors.first?.currentCall)
//
//callCenter.respondents.first?.escalateCall()
//print("manager", callCenter.managers.first?.currentCall)
//print("director", callCenter.directors.first?.currentCall)





/// Use NotificationCenter


//struct Call {}
//
//enum Role { case respondent, manager, director}
//
//class Employee {
//    private(set) var currentCall: Call?
//    let role: Role
//
//    init(_ role: Role){
//        self.role = role
//    }
//
//    func assignToCall(_ call: Call){
//        self.currentCall = call
//    }
//
//    func completeCall(){
//        currentCall = nil
//        NotificationCenter.default.post(name: .finishCall, object: self)
//    }
//
//    func escalateCall() {
//        guard currentCall != nil else { return }
//        NotificationCenter.default.post(name: .escalateCall, object: self)
//    }
//
//}
//
//extension Notification.Name {
//    static var escalateCall: Notification.Name {
//        .init("EscalateCall")
//    }
//
//    static var finishCall:Notification.Name {
//        .init("FinishCall")
//    }
//}
//
//class CallCenter {
//    private(set) var standardQueue = [Call]()
//    private(set) var managerQueue = [Call]()
//    private(set) var directorQueue = [Call]()
//
//    let directors: [Employee]
//    let managers: [Employee]
//    let respondents: [Employee]
//
//    var firstAvailableEmployee: Employee? {
//        return respondents.filter({ $0.currentCall == nil }).randomElement()
//    }
//
//    var firstAvailableManager: Employee? {
//        return managers.filter({ $0.currentCall == nil }).randomElement()
//    }
//
//    var firstAvailableDirector: Employee? {
//        return directors.filter({ $0.currentCall == nil }).randomElement()
//    }
//
//    init(respondents: [Employee], managers: [Employee], directors: [Employee]){
//        // could also use general [Employee] and use role to break into groups
//        self.respondents = respondents
//        self.managers = managers
//        self.directors = directors
//
//        NotificationCenter.default.addObserver(self, selector: #selector(escalateCall), name: .escalateCall, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(callCompleted), name: .finishCall, object: nil)
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    @objc func callCompleted(_ notification: Notification){
//        guard let employee = notification.object as? Employee else { return }
//
//        employee.completeCall()
//
//        switch employee.role {
//        case .respondent:
//            if !standardQueue.isEmpty, let employee = firstAvailableEmployee  {
//                employee.assignToCall(standardQueue.removeFirst())
//            }
//        case .manager:
//            if !managerQueue.isEmpty, let manager = firstAvailableManager {
//                manager.assignToCall(managerQueue.removeFirst())
//            }
//        case .director:
//            if !directorQueue.isEmpty, let director = firstAvailableDirector {
//                director.assignToCall(managerQueue.removeFirst())
//            }
//        }
//
//    }
//
//    func dispatchCall(_ call: Call){
//        standardQueue.append(call)
//        if let employee = firstAvailableEmployee {
//            employee.assignToCall(standardQueue.removeFirst())
//        }
//    }
//
//    func handleEscalatedCall(){
//        if let manager = firstAvailableManager {
//            manager.assignToCall(managerQueue.removeFirst())
//        } else if let director = firstAvailableDirector {
//            director.assignToCall(managerQueue.removeFirst())
//        }
//    }
//
//    @objc func escalateCall(_ notification: Notification){
//        guard let employee = notification.object as? Employee, let currentCall = employee.currentCall else { return }
//
//        switch employee.role {
//        case .respondent:
//            managerQueue.append(currentCall)
//        case .manager:
//            directorQueue.append(currentCall)
//        case .director:
//            break
//        }
//        handleEscalatedCall()
//        print("Escalate", (notification.object as? Employee)?.role)
//    }
//}
//
//
//let callCenter = CallCenter(
//    respondents: [Employee(.respondent)],
//    managers: [Employee(.manager)],
//    directors: [Employee(.director)]
//)
//
//let call = Call()
//
//callCenter.dispatchCall(call)
//dump(callCenter.respondents)
//dump(callCenter.managers)
//dump(callCenter.directors)
//callCenter.dispatchCall(call)
//
//callCenter.respondents.first?.escalateCall()
//callCenter.respondents.first?.escalateCall()





/// First Attempt With No Observers


//class Employee {
//    private(set) var isAvailable: Bool = true
//
//    func assignToCall(_ call: Call){
//        isAvailable = false
//    }
//
//    // maybe used in a completion handler at end of call duration
//    func completeCall(){
//        isAvailable = true
//    }
//
//}
//
//class Respondent: Employee {
//
//}
//
//class Manager: Employee {
//
//}
//
//class Director: Employee {
//
//}
//
//struct Call {
//    // Has a person
//    // & any other Ids or defining features for this call
//}
//
//// This uses one callQueue but we could have different callQueue for escalated calls to managers/directors and standard callQueue for respondents
//class CallCenter {
//    var callQueue = [Call]()
//    let directors: [Director]
//    let managers: [Manager]
//    let respondents: [Respondent]
//
//    var firstAvailableEmployee: Employee? {
//        if let respondent = respondents.filter(\.isAvailable).randomElement() {
//            return respondent
//        } else if let manager = managers.filter(\.isAvailable).randomElement() {
//            return manager
//        } else if let director = directors.filter(\.isAvailable).randomElement() {
//            return director
//        }
//        return nil
//    }
//
//    init(respondents: [Respondent], managers: [Manager], directors: [Director]){
//        self.respondents = respondents
//        self.managers = managers
//        self.directors = directors
//    }
//
//    func callCompleted(for employee: Employee){
//        employee.completeCall()
//
//        if !callQueue.isEmpty, let employee = firstAvailableEmployee  {
//            employee.assignToCall(callQueue.removeFirst())
//        }
//    }
//
//    func dispatchCall(_ call: Call){
//        callQueue.append(call)
//        if let employee = firstAvailableEmployee {
//            employee.assignToCall(callQueue.removeFirst())
//        }
//    }
//
//    func escalateToManger(){}
//    func escalateToDirector(){}
//}
//
//
//let callCenter = CallCenter(
//    respondents: [Respondent()],
//    managers: [Manager()],
//    directors: [Director()]
//)
//
//let call = Call()
//
//callCenter.dispatchCall(call)
//dump(callCenter.respondents)
//dump(callCenter.managers)
//dump(callCenter.directors)
//
//callCenter.dispatchCall(Call())
//dump(callCenter.respondents)
//dump(callCenter.managers)
//dump(callCenter.directors)
//
//callCenter.dispatchCall(Call())
//dump(callCenter.respondents)
//dump(callCenter.managers)
//dump(callCenter.directors)
//callCenter.callQueue
//
//callCenter.dispatchCall(Call())
//dump(callCenter.respondents)
//dump(callCenter.managers)
//dump(callCenter.directors)
//callCenter.callQueue
//
//callCenter.dispatchCall(Call())
//dump(callCenter.respondents)
//dump(callCenter.managers)
//dump(callCenter.directors)
//callCenter.callQueue
//
//callCenter.callCompleted(for: callCenter.respondents.first!)
//dump(callCenter.respondents)
//dump(callCenter.managers)
//dump(callCenter.directors)
//callCenter.callQueue

//: [Next](@next)
