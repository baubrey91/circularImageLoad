import UIKit

class CustomImageView: UIImageView {
  
  let progressIndicatorView = CircularLoaderView(frame: .zero)
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    addSubview(progressIndicatorView)
    
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[v]|", options: .init(rawValue: 0),
      metrics: nil, views: ["v": progressIndicatorView]))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[v]|", options: .init(rawValue: 0),
      metrics: nil, views:  ["v": progressIndicatorView]))
    progressIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    
    let url = URL(string: "https://koenig-media.raywenderlich.com/uploads/2015/02/mac-glasses.jpeg")
    sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly, progress:
      { [weak self] receivedSize, expectedSize, _ in

        self?.progressIndicatorView.progress = CGFloat(receivedSize) / CGFloat(expectedSize)
      }) { [weak self] _, error, _, _ in

        if let error = error {
          print(error)
        }
        self?.progressIndicatorView.reveal()
    }
  }
  
}
