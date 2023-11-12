//
//  ViewModelType.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/12.
//

import Foundation

// protocol 이용해 Input Ouput 구조 추상화
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
