//
//  TableViewController.swift
//  ParkScroll
//
//  Created by Junwoo Seo on 9/29/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit


//Adding all captions and images name into Array to use in collapse and expand

struct sectionOfPark {
    var caption: [String]
    var image: [UIImage]
    var isCollapsed: Bool
    
    init(caption: [String], image: [UIImage], isCollapsed: Bool = true) {
        self.caption = caption
        self.image = image
        self.isCollapsed = isCollapsed
    }
}

var SectionOfPark = [sectionOfPark]()
/////////////////////////////////////////////////////////////////////////////////




class TableViewController: UITableViewController, UITableViewHeaderFooterViewDelegate {
    
    let parkModel = Model()
    var SectionController = SectionOfPark
    let heightOfCells = 80
    var tapCellIndexPath = IndexPath()
    var ImageZoomView = UIView()
    var ImageZoomViewImageView = UIImageView()
    var ZoomMinimumScale = CGFloat()
    
    override func viewWillAppear(_ animated: Bool) {
        let totalParkNumber = parkModel.parkTotalCount()
        for i in 0 ... totalParkNumber - 1
        {
            let imageTotalNumber = parkModel.imageTotalCount(i: i)
            var imageOfParks = [UIImage]()
            var captionOfParks = [String]()
            for j in 0 ... imageTotalNumber - 1
            {
                let imageName = parkModel.imageNameCall(i: i, j: j)
                let image = UIImage(named: imageName)
                imageOfParks.append(image!)
                let caption = parkModel.captionCall(i: i, j: j)
                captionOfParks.append(caption)
            }
            SectionController.append(sectionOfPark(caption: captionOfParks, image: imageOfParks))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    Number of Section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return parkModel.parkTotalCount()
    }
    
    
    // cell numbers of each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellNumbers = parkModel.imageTotalCount(i: section)
        return cellNumbers
    }
    
    
    // initalizing cells and subviews of the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndex = indexPath.row
        let sectionOfParks = indexPath.section
        let imageCellPosition = tableView.frame.width / 4 * 3
        let image = UIImage(named: parkModel.imageNameCall(i: sectionOfParks, j: cellIndex))
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParkCell", for: indexPath) as! TableViewCell
        cell.ParkCaptionLabel.text = parkModel.captionCall(i: sectionOfParks, j: cellIndex)
        cell.ParkImageView.image = image
        cell.ParkImageView.center.x = imageCellPosition
        return cell
    }
    
    // setting section title by adding HeadingFooterController and Delegate.
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let parkSectionTitle = TableViewHeaderFooterController()
        let title = parkModel.parkLabelCall(i: section)
        parkSectionTitle.Initialization(name: title, section: section, delegate: self)
        return parkSectionTitle
    }
    
    //when it is collapsed make it height 0 so it looks collapsed.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentSection = indexPath.section
        if SectionController[currentSection].isCollapsed == true
        {
            return CGFloat(heightOfCells)
        }
        else
        {
            return 0
        }
    }
    
    // This is From TableViewHeaderFooterController Delegate Function which updates the cells height to 0 when it is tap.
    func collapseSection(header: TableViewHeaderFooterController, section: Int) {
        SectionController[section].isCollapsed = !SectionController[section].isCollapsed
        let totalNumberOfCaption = SectionController[section].caption.count - 1
        tableView.beginUpdates()
                for i in 0 ..< totalNumberOfCaption
                {
                    let eachCell = IndexPath(row: i, section: section)
                    tableView.reloadRows(at: [eachCell], with: .automatic)
                }
        tableView.endUpdates()
    }
    
    @objc func tapGestureHandler(gestureRecognizer: UITapGestureRecognizer){
        if ZoomMinimumScale == 1{
            let currentCell = tableView.cellForRow(at: tapCellIndexPath) as! TableViewCell
            let CellImagePosition = currentCell.frame.width / 4 * 3
            let CellView = tableView.rectForRow(at: tapCellIndexPath).origin
            let PassedimagePosition = tableView.convert(CellView, to: tableView.superview)
            tableView.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.8, animations: {
                self.ImageZoomViewImageView.frame = currentCell.ParkImageView.frame
                self.ImageZoomViewImageView.frame.origin = PassedimagePosition
                self.ImageZoomViewImageView.center.x = CellImagePosition
                self.ImageZoomViewImageView.backgroundColor = UIColor.clear
            }, completion: {
                (finished:Bool) in self.ImageZoomView.removeFromSuperview()
                self.ImageZoomViewImageView.removeFromSuperview()
            })
            tableView.sendSubview(toBack: ImageZoomView)

            tableView.deselectRow(at: tapCellIndexPath, animated: true)
        }
    }

    
    @objc func pinchGestureHandler(sender:UIPinchGestureRecognizer){
        if sender.state == .began || sender.state == .changed{
            let passedScale: CGFloat = self.ImageZoomView.frame.width / self.ImageZoomView.bounds.width
            let nextScale = passedScale * sender.scale
            let transform = CGAffineTransform(scaleX: nextScale, y: nextScale)
            ImageZoomViewImageView.transform = transform
            ZoomMinimumScale = nextScale
        }
        if sender.scale <= 1
        {
            ImageZoomViewImageView.transform = CGAffineTransform.identity
            sender.scale = 1
            ZoomMinimumScale = 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let section = indexPath.section
//        let cellIndex = indexPath.row
//        let imageName = parkModel.imageNameCall(i: section, j: cellIndex)
//        let image = UIImage(named: imageName)
//        let currentCell = tableView.cellForRow(at: indexPath) as! TableViewCell
//        let tableCGPoint = tableView.rectForRow(at: indexPath).origin
//        let imageLocation = currentCell.frame.width / 4 * 3
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureHandler(sender:)))
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        
        tapCellIndexPath = indexPath
        performSegue(withIdentifier: "showDetail", sender: self)
////        ImageZoomView = tableView
//        ImageZoomView.bounds = UIScreen.main.bounds
//        ImageZoomView.center = tableView.center
//        ImageZoomViewImageView = UIImageView(image: image)
//        ImageZoomViewImageView.frame = currentCell.ParkImageView.frame
//        ImageZoomViewImageView.frame.origin = tableView.convert(tableCGPoint, to: tableView.superview)
//        ImageZoomViewImageView.center.x = imageLocation
//        ImageZoomViewImageView.backgroundColor = UIColor.white
//        ImageZoomViewImageView.contentMode = UIViewContentMode.scaleAspectFit
//
//        ImageZoomView.addGestureRecognizer(pinchGesture)
//        ImageZoomView.addGestureRecognizer(tapGesture)
//
//        tableView.isUserInteractionEnabled = false
//        ImageZoomView.addSubview(ImageZoomViewImageView)
//        self.view.superview?.addSubview(ImageZoomView)
//        self.view.superview?.bringSubview(toFront: ImageZoomView)
//        ZoomMinimumScale = 1
//        UIView.animate(withDuration: 0.8) {
//            self.ImageZoomViewImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                tableView.deselectRow(at: indexPath, animated: true)
                controller.detailTitle = parkModel.parkLabelCall(i: indexPath.section)
                controller.detailImage = parkModel.imageNameCall(i: indexPath.section, j: indexPath.row)
                controller.detailCaption = parkModel.captionCall(i: indexPath.section, j: indexPath.row)
            }
        }
    }
}
