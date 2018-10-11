//
//  CRAudioPlayer.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import AVKit

/// 播放器
class CRAudioPlayer: NSObject {
    public static let `default` = CRAudioPlayer()
    
    private var _player: AVAudioPlayer? // 通用播放器
    private var _emptyPlayer: AVAudioPlayer? // 空白音乐播放器
    typealias CompleteBlock = ()->()
    private var _completeBlock: CompleteBlock?
    
    /// 播放匹配中音乐
    public func playMatchingMusic(_ isContinue: Bool = false) {
        if let player = _player {
            if isContinue && player.isPlaying {
                player.play()
                return
            }
        }
        
        let path = Bundle.main.path(forResource: "matching_music", ofType: "mp3")!
        _player = self.setupPlay(path: path)
        _player?.numberOfLoops = -1
        _player?.play()
    }
    /// 播放匹配到音乐
    public func playMatchedMusic() {
        let path = Bundle.main.path(forResource: "matched_music", ofType: "mp3")!
        _player = self.setupPlay(path: path)
        _player?.numberOfLoops = -1
        _player?.play()
    }
    /// 播放登录音乐
    public func playLoginMusic() {
        let path = Bundle.main.path(forResource: "login_music", ofType: "mp3")!
        _player = self.setupPlay(path: path)
        _player?.numberOfLoops = -1
        _player?.play()
    }
    /// 播放空白音乐
    public func playEmptyMusic() {
        let path = Bundle.main.path(forResource: "matching_music", ofType: "mp3")!
        _emptyPlayer = self.setupPlay(path: path)
        _emptyPlayer?.numberOfLoops = -1
        _emptyPlayer?.volume = 0.0
        _emptyPlayer?.play()
    }
    /// 停止空白音乐
    public func stopEmptyMusic() {
        _emptyPlayer?.stop()
    }
    /// 停止音乐
    public func stopMusic() {
        _player?.stop()
    }
    /// 暂停音乐
    public func pauseMusic() {
        _player?.pause()
    }
    
    /// 播放录音
    public func playRecord(_ audio: String, _ completeBlock: @escaping CompleteBlock) {
        self.playAudio(audio: audio, completeBlock)
    }
    
    /// 根据文件路径和用户ID播放
    public func playAudio(audio: String?, _ completeBlock: @escaping CompleteBlock) {
        _completeBlock = completeBlock
        guard let audio = audio else {
            completeBlock()
            return
        }
        guard let md5Path = (audio as NSString).md5() else {
            completeBlock()
            return
        }
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let localPath = path + "/" + md5Path + ".acc"
        
        if FileManager.default.isReadableFile(atPath: localPath) {
            _player = self.setupPlay(path: localPath)
            _player?.delegate = self
            _player?.play()
        } else {
            // 下载音频
            CRNetwork.default.download(audio, { [weak self] (data) in
                if let d = data {
                    let success = FileManager.default.createFile(atPath: localPath, contents: d, attributes: nil)
                    if success {
                        DispatchQueue.main.async { [weak self] in
                            self?._player = self?.setupPlay(path: localPath)
                            self?._player?.delegate = self
                            self?._player?.play()
                        }
                    } else {
                        CRLog("播放音频失败")
                        self?._completeBlock?()
                    }
                } else {
                    CRLog("下载音频失败")
                    self?._completeBlock?()
                }
            })
        }
    }
    
    /// 根据路径创建播放器
    private func setupPlay(path: String) -> AVAudioPlayer? {
        guard let url = URL(string: path) else {
            return nil
        }
        let session = AVAudioSession.sharedInstance()
        do {
            if #available(iOS 10.0, *) {
                try session.setCategory(AVAudioSession.Category.playback, mode:AVAudioSession.Mode.default)
            } else {
                // Fallback on earlier versions
            }
            try session.setActive(true)
        } catch let e as NSError {
            CRLog("\(e.description)")
        }
        var player: AVAudioPlayer?
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let e as NSError {
            CRLog("\(e.description)")
            _completeBlock?()
        }
        player?.prepareToPlay()
        return player
    }
}

extension CRAudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        _completeBlock?()
    }
}
