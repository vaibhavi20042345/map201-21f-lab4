//
//  PhotosViewController.swift
//  Photorama
//
//  Created by vaibhavi on 2021-03-26.
//

import UIKit
//Conforming to UICollectionViewDelegate
class PhotosViewController: UIViewController, UICollectionViewDelegate{
    //Adding an image view
    //Declaring new properties for collection view support
    @IBOutlet var collectionView: UICollectionView!
    //Adding a PhotoStore property
    var store: PhotoStore!
    //Declaring new properties for collection view support
    let photoDataSource = PhotoDataSource()
    //Initiating the web service request
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting the collection view data source
        collectionView.dataSource = photoDataSource
        //Setting the collection view delegate
        collectionView.delegate = self
        //Updating the data source on load
        updateDataSource()
        //store.fetchInterestingPhotos()
        //Printing the results of the request
        store.fetchInterestingPhotos {
            (photosResult) in
            /*
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                //Updating the collection view with the web service data
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0)) */
            self.updateDataSource()
        }
        
    }
    //Finally Fetching the cellâ€™s image on to the screen
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        // Download the image data, which could take some time
        store.fetchImage(for: photo) { (result) -> Void in
            /*The index path for the photo might have changed
             between the time the request started and finished, so find the most
             recent index path */
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                  case let .success(image) = result else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section:0)
            // When the request finishes, find the current cell for this photo
            if let cell = self.collectionView.cellForItem(at:
                                                            photoIndexPath)
                as?
                PhotoCollectionViewCell {
                cell.update(displaying: image)
            }
        }
    }
    
    //Injecting the photo and store
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier {
        case "showPhoto":
            if let selectedIndexPath =
                collectionView.indexPathsForSelectedItems?.first
            {
                let photo =
                    photoDataSource.photos[selectedIndexPath.row]
                let destinationVC = segue.destination as!
                    PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    //Implementing a method to update the data source
    private func updateDataSource() {
        store.fetchAllPhotos {
            (photosResult) in
            switch photosResult {
            case let .success(photos):
                self.photoDataSource.photos = photos
            case .failure:
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
}

