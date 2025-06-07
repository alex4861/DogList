//
//  UIImageExtension+DownSample.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import UIKit

extension UIImage {

    convenience init?(data: Data, maxDimension: CGFloat = 480) {
        guard !data.isEmpty else { return nil }
        let options = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let source = CGImageSourceCreateWithData(data as CFData, options) else { return nil }

        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimension
        ] as CFDictionary

        guard let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOptions) else { return nil }
        self.init(cgImage: cgImage)
    }

}
