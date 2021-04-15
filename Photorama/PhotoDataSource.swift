//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by vaibhavi on 2021-03-26.
//


import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource{
    var photos = [Photo]()
    //Implementing the collection view data source methods
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) ->
    Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let identifier = "PhotoCollectionViewCell"
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier:identifier, for: indexPath) as!
            PhotoCollectionViewCell
        cell.update(displaying: nil) //Dequeuing PhotoCollectionViewCell instances
        return cell
    }
}
