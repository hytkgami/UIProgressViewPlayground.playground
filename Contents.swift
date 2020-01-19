//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    var count: Int64 = 0
    let progress = Progress(totalUnitCount: 100)
    var timer: Timer?
    
    var resetButton: UIButton!

    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 820))
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        setupProgressBar()
        setupResetButton()
        setupTimer()
    }
    
    func setupTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func setupProgressBar() {
        let screenBounds = UIScreen.main.bounds
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: 8))
        progressView.setProgress(0.0, animated: true)
        progressView.observedProgress = progress
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .blue
        progressView.center = view.center
        view.addSubview(progressView)
    }
    
    func setupResetButton() {
        resetButton = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        resetButton.setTitle("Reset", for: .normal)
        resetButton.isEnabled = false
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetButton.backgroundColor = .gray
        view.addSubview(resetButton)
    }
    
    @objc func update() {
        count += 20
        UIView.animate(withDuration: 0.1) {
            self.progress.completedUnitCount = self.count
        }
        if progress.isFinished || progress.isCancelled {
            self.timer?.invalidate()
            self.resetButton.isEnabled = true
        }
    }
    
    @objc func reset() {
        self.resetButton.isEnabled = false
        self.progress.completedUnitCount = 0
        self.count = 0
        setupTimer()
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
