//
//  ViewController.swift
//  TaskExecutor
//
//  Created by lapshop on 6/17/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var taskStackViewContainer: UIStackView!
    
    var time = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func segmentValueChanged(_ sender: Any)  {
        
        Task {
            try? await fetch()
        }
    }
    
    @MainActor
    fileprivate func updateText()  {
        time *= 2
        Timer.scheduledTimer(withTimeInterval: TimeInterval(time), repeats: true) { [weak self] _ in
            guard let weakSelf = self else {return}
            var label =  UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 60, height: 30)))
            label.text =  "\(weakSelf.getDate())"
            weakSelf.taskStackViewContainer.addArrangedSubview(label)
        }
        
    }
    
    @MainActor
    func fetch()  async throws {
        
        return try await withThrowingTaskGroup(of: Void.self) { group in
            // adding tasks to the group and fetching movies
            group.addTask(priority: .background) {
                   await self.updateText()
                }
        }
    }
    
    
    func getDate() -> String {
        //sleep(10)
        let date = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatterGet.string(from: Date())
    }
    
    
}



