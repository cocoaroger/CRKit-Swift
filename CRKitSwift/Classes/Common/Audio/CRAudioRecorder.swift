//
//  CRAudioRecorder.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import AVKit

protocol CRAudioRecorderDelegate: class {
    func prepared(success: Bool, recorder: AVAudioRecorder?) // 是否准备好录音
    func prepared(success: Bool, player: AVAudioPlayer?, duration: TimeInterval) // 是否准备好播放
}

/// 录音器
class CRAudioRecorder: NSObject {
    public var isRecording: Bool = false
    public weak var delegate: CRAudioRecorderDelegate?
    /// 准备录制
    public func prepareRecord() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { [unowned self] (allowed) in
                if allowed {
                    self.delegate?.prepared(success: false, recorder: nil)
                }
            }
            break
        case .denied:
            UIAlertController.showMicFailed()
            break
        case .granted:
            self.setupAudioRecord()
            break
        }
        
        
    }
    // 结束
    public func stopRecord() {
        // 设置音频外放
        let session = AVAudioSession.sharedInstance()
        do {
            if #available(iOS 10.0, *) {
                try session.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            } else {
            }
            try session.setActive(true)
        } catch let e as NSError {
            CRLog("\(e.description)")
        }
        isRecording = false
        _audioRecorder?.stop()
    }
    // 准备播放
    public func preparePlay() {
        self.setupAudioPlayer()
    }
    // 停止播放
    public func stopPlay() {
        _audioPlayer?.stop()
    }
    // 录制好的数据
    public func recordedData() -> Data? {
        var data: Data?
        do {
            try data = Data(contentsOf: self.filePath().1)
        } catch let e as NSError {
            CRLog("\(e.description)")
        }
        return data
    }
    
    private var _audioRecorder: AVAudioRecorder?
    private var _audioPlayer: AVAudioPlayer?
    // 文件路径
    private func filePath() -> (String, URL) {
        let fileName = "record_audio_file.aac"
        var path = NSTemporaryDirectory()
        path.append(fileName)
        return (path, URL(fileURLWithPath: path))
    }
    // 移除音频文件
    private func removeFile() {
        let filemanager = FileManager()
        if filemanager.isReadableFile(atPath: self.filePath().0) {
            do {
                try filemanager.removeItem(at: self.filePath().1)
            } catch let e as NSError {
                CRLog("\(e.description)")
            }
        }
    }
    // 创建音频录制
    private func setupAudioRecord() {
        // 设置音频会话支持录音和音乐播放
        let session = AVAudioSession.sharedInstance()
        do {
            if #available(iOS 10.0, *) {
                try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default)
            } else {
            }
            try session.setActive(true)
        } catch let e as NSError {
            CRLog("\(e.description)")
        }
        self.removeFile()
        // 录音参数
        let settings = [ // 30s 70k
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 2,
            AVLinearPCMBitDepthKey: 16,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue ]
        //        let settings = [ // 30s 373k
        //            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        //            AVSampleRateKey: 44100,
        //            AVNumberOfChannelsKey: 2,
        //            AVLinearPCMBitDepthKey: 16,
        //            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue ]
        
        do {
            _audioRecorder = try AVAudioRecorder(url: self.filePath().1, settings: settings)
        } catch let e as NSError {
            CRLog("\(e.description)")
            self.delegate?.prepared(success: false, recorder: nil)
            return
        }
        _audioRecorder?.delegate = self
        let success = _audioRecorder?.prepareToRecord() ?? false
        self.delegate?.prepared(success: success, recorder: _audioRecorder)
    }
    // 创建音频播放
    private func setupAudioPlayer() {
        // 播放参数
        do {
            let file = FileManager()
            let hasFile = file.isReadableFile(atPath: self.filePath().0)
            if hasFile {
                _audioPlayer = try AVAudioPlayer(contentsOf: self.filePath().1)
            } else {
                self.delegate?.prepared(success: false, player: nil, duration: 0.0)
            }
        } catch let e as NSError {
            CRLog("\(e.description)")
            self.delegate?.prepared(success: false, player: nil, duration: 0.0)
        }
        _audioPlayer?.numberOfLoops = 0
        let success = _audioPlayer?.prepareToPlay() ?? false
        self.delegate?.prepared(success: success, player: _audioPlayer, duration: _audioPlayer?.duration ?? 0.0)
    }
}

extension CRAudioRecorder: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        CRLog("录音状态：\(flag)")
    }
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        CRLog("录音失败：\(error.debugDescription)")
    }
}
