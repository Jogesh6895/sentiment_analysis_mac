//
//  ViewController.swift
//  LiveSentimentAnalysis
//
//  Created by Jogesh Ghadai on 15/03/20.
//  Copyright © 2020 Jogesh Ghadai. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet weak var text_box_outlet: NSTextField!
    @IBOutlet weak var sentiment_score_label: NSTextField!
    @IBOutlet weak var result_label: NSTextField!
    @IBOutlet weak var dynamic_text_outlet: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dynamic_text_outlet.delegate = self
    }
    
    
    @IBAction func submit(_ sender: Any) {
        print(text_box_outlet.stringValue)
        var commandOutput = ""
        commandOutput = try self.executeCommand(command: "/Users/jogeshghadai/anaconda3/envs/workenv/bin/python3", args: ["/Users/jogeshghadai/Desktop/Live_Sentiment_Analysis/sentiment_analysis.py",text_box_outlet.stringValue])
        print("Sentiment Score: \(commandOutput)")
        self.sentiment_score_label.stringValue = "Sentiment Score: \(commandOutput)"
        self.result_label.stringValue = self.text_box_outlet.stringValue
        if let sentiment_score = Double(commandOutput.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)) {
            if sentiment_score == 0.0 {
                self.result_label.textColor = NSColor.yellow
            }else if sentiment_score < 0.0 {
                self.result_label.textColor = NSColor.red
            }else {
                self.result_label.textColor = NSColor.green
            }
        }
    }
    
    func executeCommand(command: String, args: [String]) -> String {
        let task = Process()
        task.launchPath = command
        task.arguments = args
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
        return output
    }
    
    func controlTextDidChange(_ obj: Notification) {
        print(dynamic_text_outlet.stringValue)
        var commandOutput = ""
        commandOutput = try self.executeCommand(command: "/Users/jogeshghadai/anaconda3/envs/workenv/bin/python3", args: ["/Users/jogeshghadai/Desktop/Live_Sentiment_Analysis/sentiment_analysis.py",dynamic_text_outlet.stringValue])
        print("Sentiment Score: \(commandOutput)")
        self.sentiment_score_label.stringValue = "Sentiment Score: \(commandOutput)"
        self.result_label.stringValue = self.dynamic_text_outlet.stringValue
        if let sentiment_score = Double(commandOutput.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)) {
            if sentiment_score == 0.0 {
                self.result_label.textColor = NSColor.yellow
            }else if sentiment_score < 0.0 {
                self.result_label.textColor = NSColor.red
            }else {
                self.result_label.textColor = NSColor.green
            }
        }
    }
}

