//
//  ViewController.swift
//  miniTube
//
//  Created by Aijaz Ali on 20/10/2022.
//

import UIKit
import SDDownloadManager
import WebKit

class ViewController: UIViewController {
    
    // https://d304.d2mefast.net/tb/d/a1/akon_sorry_blame_it_on_me_h264_36868.mp4
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var downloadErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadButton.setTitle("", for: .normal)
        self.downloadErrorLabel.isHidden = true
    }
    
    @IBAction func downloadButtonTapped(_ sender: Any) {
        guard let urlString = self.urlTextField.text, let sourceURL = URL(string: urlString)  else { return }
        self.downloadVidoe(urlRequest: URLRequest(url: sourceURL))
    }
    
    
    private func downloadVidoe(urlRequest: URLRequest) {
        self.progressView.isHidden = false
        self.updateProgress(progress: 0.0)
        let urlRequest: URLRequest = urlRequest
        self.downloadErrorLabel.isHidden = true
        let downloadKey = SDDownloadManager.shared.downloadFile(withRequest: urlRequest, inDirectory: "../../Documents", withName: "\(Int.random(in: 0...100000))okokokok.\("mp4" )",onProgress:{ (progress) in
         //   let percentage = String(format: "%.1f %", (progress * 100))
            // self.progressView = Float(progress)
            self.progressView.progress = Float(progress)
            // if(self.type == "mp4"){
            print("MP4:::::::Download\(progress)")
            self.updateProgress(progress: Float(progress))
            //   }
        }, onCompletion: { [weak self] (error, url) in
            if let error = error {
                print("Error is \(error as NSError)")
                self?.downloadErrorLabel.text = error.localizedDescription
                self?.downloadErrorLabel.isHidden = false
            } else {
                if let url = url {
                    //  self!.addVideoDB(downloadMediaFilePath: url.path)
                    //  self?.play = url.path
                    print("Path: \(url.path)")
                    self?.progressView.isHidden = true
                }
                //  self!.completeDownload(type: self!.type)
            }
        })
        
        print("download key: \(String(describing: downloadKey))")
    }
    func updateProgress(progress: Float) {
        print("update")
        self.progressView.isHidden = false
        self.progressView.progress = progress
    }
}

