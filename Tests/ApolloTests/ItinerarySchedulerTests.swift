//
//  ItinerarySchedulerTests.swift
//  Apollo
//
//  Created by Joseph Daniels on 11/26/16.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import Dispatch
import RxSwift
import XCTest
@testable import Apollo

class ItinerarySchedulerTests: XCTestCase {
    let bag = DisposeBag()
    let bgQueue = DispatchQueue(label: "bgQueue")


    func testItinerarySchedulerAsync() {
//        var setInScheduler = false
//        var somethingToSetInObservable: String? = nil
//        let await = self.expectation(description: "completion of Itinerary")
//        let name = Itinerary.Name(name: "sample")
//        let simple = Observable.just("Ohai").subscribeOn(Itinerary.scheduler(named: name))
//        simple.subscribe(onNext: { XCTAssert($0 == "Ohai") }).addDisposableTo(bag)
//        Observable<Any>.create { observer in
//            somethingToSetInObservable = "Hey"
//            observer.onCompleted()
//            return SingleAssignmentDisposable()
//        }.subscribeOn(Itinerary.scheduler(named: name))
//        .subscribe(onCompleted: {
//            await.fulfill()
//        })
//        .addDisposableTo(bag)
//        func sample() {
//            Itinerary.scheduler(named: name).flush()
//            XCTAssert(somethingToSetInObservable == "Hey")
//        }
//        bgQueue.async(sample)
//        waitForExpectations(timeout: 1, handler: nil)
    }


    func testSubscribeOn(){

//        var setInScheduler = false
//        var somethingToSetInObservable: String? = nil
//        let await = self.expectation(description: "completion of Itinerary")
//        let name = Itinerary.Name(name: "sample")
//        simple.subscribe(onNext: { XCTAssert($0 == "Ohai") }).addDisposableTo(bag)
//        Observable<Any>.create { observer in
//            somethingToSetInObservable = "Hey"
//            observer.onCompleted()
//            return SingleAssignmentDisposable()
//        }.subscribeOn(Itinerary.scheduler(named: name))
//        .subscribe(onCompleted: {
//            await.fulfill()
//        })
//        .addDisposableTo(bag)
//        func sample() {
//            Itinerary.scheduler(named: name).flush()
//            XCTAssert(somethingToSetInObservable == "Hey")
//        }
//
//        sample()
//        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSimply() {
//        let name = Itinerary.Name(name:"a")
//        let simple = Observable.just("Ohai").subscribeOn(Itinerary.scheduler(named: name))
//        let await = self.expectation(description: "completion of Itinerary")
//        simple.subscribe(onNext:{await.fulfill()}).addDisposableTo(bag)
//        func sample() {
//            Itinerary.scheduler(named: name).flush()
////            XCTAssert(somethingToSetInObservable == "Hey")
//        }
//        sample()
//        waitForExpectations(timeout: 1, handler: nil)
    }


    static var allTests: [(String, (ItinerarySchedulerTests) -> () throws -> Void)] {
        return [
                ("testSimply", testSimply),
                ("testSubscribeOn", testSubscribeOn),
                ("testItinerarySchedulerAsync", testItinerarySchedulerAsync),
        ]
    }
}
