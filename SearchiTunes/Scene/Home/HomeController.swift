//
//  HomeController.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/08.
//

import Foundation

final class HomeController {
    
    enum Section: String, CaseIterable {
        case video
        case travel
        case camera
        case music
        
        var title: String {
            switch self {
            case .video:
                "심심할 때는 비디오 앱"
            case .travel:
                "떠나고 싶은 날엔 여행 앱"
            case .camera:
                "고화질 카메라 앱"
            case .music:
                "힐링 주는 음악 앱"
            }
        }
        
        var term: String {
            switch self {
            case .video:
                "영상"
            case .travel:
                "여행"
            case .camera:
                "카메라"
            case .music:
                "음악"
            }
        }
    }
    
}
