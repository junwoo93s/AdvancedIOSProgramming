//
//  CollectionViewController.swift
//  ParkScroll
//
//  Created by Junwoo Seo on 9/29/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ParkCollectionCell"
private let itemsPerRow = CGFloat(2)
private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)


class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let parkModel = Model()
    var tapCellIndexPath = IndexPath()
    var ImageZoomView = UIView()
    var ImageZoomViewImageView = UIImageView()
    var ZoomMinimumScale = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return parkModel.parkTotalCount()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkModel.imageTotalCount(i: section)
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rows = indexPath.row
        let section = indexPath.section
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,for: indexPath) as! CollectionViewCell
        cell.CellParkImageView.image = UIImage(named: parkModel.imageNameCall(i: section, j: rows))
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            switch kind {
            case UICollectionElementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ParkHeader", for: indexPath) as! CollectionReusableView
                headerView.HeaderLabel.text = parkModel.parkLabelCall(i: indexPath.section)
                return headerView
            default:
                assert(false, "Unexpected element kind")
            }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spaceBetween = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - spaceBetween
        let widthBetweenItem = availableWidth / itemsPerRow
        
        let returnValue = CGSize(width: widthBetweenItem, height: widthBetweenItem)
        return returnValue
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
  
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        let cellIndex = indexPath.row
        let imageName = parkModel.imageNameCall(i: section, j: cellIndex)
        let image = UIImage(named: imageName)
        let currentCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureHandler(sender:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        
        tapCellIndexPath = indexPath
        ImageZoomView.bounds = UIScreen.main.bounds
        ImageZoomView.center = collectionView.center
        ImageZoomViewImageView = UIImageView(image: image)
        ImageZoomViewImageView.frame = currentCell.frame
        ImageZoomViewImageView.center = collectionView.convert(currentCell.center, to: collectionView.superview)
        ImageZoomViewImageView.backgroundColor = UIColor.white
        ImageZoomViewImageView.contentMode = UIViewContentMode.scaleAspectFit
        ImageZoomView.addGestureRecognizer(pinchGesture)
        ImageZoomView.addGestureRecognizer(tapGesture)
        
        collectionView.isUserInteractionEnabled = false
        ImageZoomView.addSubview(ImageZoomViewImageView)
        self.view.superview?.addSubview(ImageZoomView)
        self.view.superview?.bringSubview(toFront: ImageZoomView)
        ZoomMinimumScale = 1
        UIView.animate(withDuration: 0.8) {
            self.ImageZoomViewImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }

    @objc func tapGestureHandler(gestureRecognizer: UITapGestureRecognizer){
        if ZoomMinimumScale == 1
        {
            let currentCell = collectionView?.cellForItem(at: tapCellIndexPath) as! CollectionViewCell
            let originalImagePosition = collectionView?.convert(currentCell.center, to: collectionView?.superview)
            collectionView?.isUserInteractionEnabled = true
            
            UIView.animate(withDuration: 1.0, animations: {
                self.ImageZoomViewImageView.frame = currentCell.CellParkImageView.frame
                self.ImageZoomViewImageView.center = originalImagePosition!
                self.ImageZoomViewImageView.backgroundColor = UIColor.clear
                
            }, completion: {
                (finished:Bool) in self.ImageZoomView.removeFromSuperview()
                self.ImageZoomViewImageView.removeFromSuperview()
            })
            
            collectionView?.sendSubview(toBack: ImageZoomView)
            collectionView?.reloadData()
            collectionView?.deselectItem(at: tapCellIndexPath, animated: true)
        }
    }
    
    @objc func pinchGestureHandler(sender:UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let currentScale: CGFloat = self.ImageZoomView.frame.width / self.ImageZoomView.bounds.width
            let newScale = currentScale * sender.scale
            let transform = CGAffineTransform(scaleX: newScale, y: newScale)
            ImageZoomViewImageView.transform = transform
            ZoomMinimumScale = newScale
        }
        if sender.scale <= 1
        {
            ImageZoomViewImageView.transform = CGAffineTransform.identity
            sender.scale = 1
            ZoomMinimumScale = 1
        }
    }

}
