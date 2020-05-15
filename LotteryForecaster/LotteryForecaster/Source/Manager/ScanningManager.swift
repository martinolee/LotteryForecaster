//
//  ScanningManager.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/11.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift

class ScanningManager: NSObject {
  static let shared = ScanningManager()
  
  var url$ = PublishSubject<URL>()
  
  private let captureSession = AVCaptureSession()
  
  func scanQRCode(with view: UIView) throws {
    
    guard let captureDevice = AVCaptureDevice.default(for: .video) else {
      throw ScanningError.noCamerAvailable
    }
    
    guard let captureInput = try? AVCaptureDeviceInput(device: captureDevice) else {
      throw ScanningError.videoInputInitFail
    }
    
    let metaDataOutput = AVCaptureMetadataOutput()
    metaDataOutput.setMetadataObjectsDelegate(self, queue: .main)
    
    captureSession.addInput(captureInput)
    captureSession.addOutput(metaDataOutput)
    
    metaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    
    let captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    captureVideoPreviewLayer.videoGravity = .resizeAspectFill
    captureVideoPreviewLayer.frame = view.bounds
    view.layer.addSublayer(captureVideoPreviewLayer)
    
    captureSession.startRunning()
  }
  
  private override init() {
    super.init()
  }
}

extension ScanningManager: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    guard
      let machineReadableCode = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
      machineReadableCode.type == AVMetadataObject.ObjectType.qr,
      let stringURL = machineReadableCode.stringValue,
      let url = URL(string: stringURL)
    else { return }
    
    url$.onNext(url)
  }
}
