//
//  LogViewController
//  Tripless
//
//  Created by hko on 11/10/18.
//  Copyright © 2018 hko. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
    weak var tripDBHelperDelegate: TripDBHelper?
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let reuseIdentifier = "cell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0)
    fileprivate let itemsPerRow: CGFloat = 1
    fileprivate var tripData: [TripData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    private func reloadData() {
        guard let tripData = tripDBHelperDelegate?.getAllTripData() else
        {
            return
        }
        self.tripData = tripData
        collectionView.reloadData()
    }
    
    @objc
    fileprivate func refresh(sender: UIRefreshControl) {
        reloadData()
        sender.endRefreshing()
    }
    
    @objc
    fileprivate func deleteCell(sender: UISwipeGestureRecognizer) {
        let cell = sender.view as? UICollectionViewCell ?? UICollectionViewCell()
        let trip = tripData[tripData.count - (collectionView.indexPath(for: cell)!.row + 1)]
        tripDBHelperDelegate?.removeTrip(trip: trip)
        reloadData()
        showToast(message: "Trip Deleted")
    }
    
    private func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations:
            {
                toastLabel.alpha = 0.0
        }, completion:
            { (_) in
                toastLabel.removeFromSuperview()
        })
    }
}

// MARK: - UICollectionViewDataSource
extension LogViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tripData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? LogCell ?? LogCell()
        let trip = tripData[tripData.count - (indexPath.item + 1)]
        cell.logData = ("(\(trip.lat), \(trip.long))", "")
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(deleteCell))
        swipeGesture.direction = UISwipeGestureRecognizer.Direction.right
        cell.addGestureRecognizer(swipeGesture)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LogViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath)
        -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int)
        -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int)
        -> CGFloat
    {
        return 5.0
    }
}

