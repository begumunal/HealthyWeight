//
//  CustomVideoPlayer.swift
//  HealthyWeight
//
//  Created by Begum Unal on 8.05.2023.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class CustomVideoPlayer : UIView{
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
