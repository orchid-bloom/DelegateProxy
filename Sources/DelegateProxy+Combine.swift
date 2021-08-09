//
//  DelegateProxy+Combine.swift
//  DelegateProxy
//
//  Created by Tema.Tian on 2021/8/9.
//  Copyright © 2021 Ryo Aoyama. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
extension Publishers {
    public typealias RetroObjectiveDelegate = DelegateProxy & DelegateProxyType
    struct RetroObjective<Delegate: RetroObjectiveDelegate>: Publisher {
        public typealias Output = Arguments
        public typealias Failure = Never
        
        private let delegate: Delegate
        private let selector: Selector
        
        public init(delegate: Delegate, selector: Selector) {
            self.delegate = delegate
            self.selector = selector
        }
        
        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = SubscriptionRetroObjectiveProxy(
                subscriber: subscriber,
                delegate: delegate,
                selector: selector)
            subscriber.receive(subscription: subscription)
        }
    }
}

@available(iOS 13.0, *)
extension Publishers.RetroObjective {
    private final class SubscriptionRetroObjectiveProxy<S: Subscriber, Delegate: DelegateProxy>: Subscription where S.Input == Arguments {
        private var subscriber: S?
        weak private var delegate: Delegate?
        let selector: Selector
        
        init(subscriber: S, delegate: Delegate, selector: Selector) {
            self.subscriber = subscriber
            self.delegate = delegate
            self.selector = selector
            bind()
        }
        
        private func bind() {
            self.delegate?.receive(selector: selector) {[weak self] arguments in
                _ = self?.subscriber?.receive(arguments)
            }
        }
        
        func request(_ demand: Subscribers.Demand) {
        }
        
        func cancel() {
            subscriber = nil
        }
    }
}

@available(iOS 13.0, *)
public extension Publishers {
    static func proxyDelegate<Delegate: RetroObjectiveDelegate>(_ delegate: Delegate, selector: Selector) -> AnyPublisher<Arguments, Never> {
        Publishers.RetroObjective(delegate: delegate, selector: selector).eraseToAnyPublisher()
    }
}

