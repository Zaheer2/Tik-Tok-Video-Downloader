//
//  Image.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 07.04.2022.
//

import SwiftUI

extension Image {
    func circleIconModifier() -> some View {
        self
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .shadow(color: Color.white, radius: 2)
            .padding(.top, 60)
            .padding(.bottom, 20)
    }
    
    func iconModifier(width: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width)
    }
}

extension UIImage {
    static var minsize = CGSize(width: 300, height: 200)
    static var maxSize = CGSize(width: 1000, height: 1500)
    
    
    func save(to filename: String, directory: Directory) {
        // first resize large images
        let image = resizeLargeImage()
        let url = Constant.getURL(for: directory).appendingPathComponent("\(filename)")
      
        do {
            try image.pngData()?.write(to: url)
            print("Save image")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func load(filename: String, directory: Directory) -> UIImage? {
        let url = Constant.getURL(for: directory).appendingPathComponent("\(filename)")
        if let imageData = try? Data(contentsOf: url) {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
    
    static func remove(filename: String, directory: Directory) {
        let url = Constant.getURL(for: directory).appendingPathComponent("\(filename)")
            try? FileManager.default.removeItem(at: url)
    }
}

// MARK: - GET IMAGE SIZE
extension UIImage {
    func initialSize() -> CGSize {
        var width = Constant.Size.defaultElementSize.width
        var height = Constant.Size.defaultElementSize.height
        
        if self.size.width >= self.size.height {
            width = max(Self.minsize.width, width)
            width = min(Self.maxSize.width, width)
            height = self.size.height * (width / self.size.width)
        } else {
            height = max(Self.minsize.height, height)
            height = min(Self.maxSize.height, height)
            width = self.size.width * (height / self.size.height)
        }
        return CGSize(width: width, height: height)
    }
    
    static func imageSize(named imageName: String) -> CGSize {
        if let image = UIImage(named: imageName) {
            return image.initialSize()
        }
        return .zero
    }
}

// MARK: - RESIZE IMAGE
extension UIImage {
    func resizeLargeImage() -> UIImage {
        let defaultSize: CGFloat = 160
        if size.width <= defaultSize ||
            size.height <= defaultSize { return self }
        
        let scale: CGFloat
        if size.width >= size.height {
            scale = defaultSize / size.width
        } else {
            scale = defaultSize / size.height
        }
        let newSize = CGSize(
            width: size.width * scale,
            height: size.height * scale)
        return resize(to: newSize)
    }
    
    func resize(to size: CGSize) -> UIImage {
        // UIGraphicsImageRenderer sets scale to device's screen scale
        // change the scale to 1 to get the real image size
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

