////  Stollen by JK 20/11/2021.
//
//import SwiftUI
//import Photos
//import AVKit
//import AVFoundation
//
//struct Welcome: Codable {
//    let id: String
//    let createTime: String
//    let desc: String
//    let video: Video
//    
//    struct Video: Codable {
//        let playAddr: String
//        let downloadAddr: String
//        let cover: String
//    }
//}
//
////enum downloaderErrors: Error {
////    case InvalidUrlGiven
////    case JsonScrapFailed
////    case JsonParseFailed
////    case DownloadVideoForbiden
////    case VideoDownloadFailed
////    case VideoSaveFailed
////    case CoverSaveFailed
////}
//
//class TiktokDownloader {
//    let videoUrl: String
//    var fileName: String? = nil
//    var coverFile: String? = nil
//    var dataFile: String? = nil
//    
//    var img: VImageLoader? = nil
//    
//    init(withUrl: String) {
//        videoUrl = withUrl
//    }
//    
//    private func scrapJson(content: String) -> String? {
//        var json: String?
//        var jsond = content.components(separatedBy: "\"ItemModule\":")
//        
//        if jsond.indices.contains(1) {
//            let jsonTemp = jsond[1]
//            
//            if let i = jsonTemp.firstIndex(of: "i") {
//                jsond[1] = String(jsonTemp.suffix(from: i))
//                jsond[1] = "{\"" +  jsond[1]
//            }
//            
//            jsond = jsond[1].components(separatedBy: "},\"UserModule\"")
//            if jsond.indices.contains(0) {
//                json = jsond[0]
//            } else { json = nil }
//            
//        } else { json = nil }
//        
//        return json
//    }
//    
//    public func download(completion: @escaping (Result<Tiktok, downloaderErrors>) -> Void) throws {
//        guard let url = URL(string: videoUrl) else {
//            completion(.failure(.InvalidUrlGiven))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15", forHTTPHeaderField: "User-Agent")
//        request.setValue("https://www.tiktok.com/", forHTTPHeaderField: "Referer")
//        request.setValue("bytes=0-", forHTTPHeaderField: "Range")
//        print(request)
//        
//        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                let html = String(data: data, encoding: .utf8)!
//                guard let json = self.scrapJson(content: html) else {
//                    completion(.failure(.JsonScrapFailed))
//                    return
//                }
//            
//                let data = String(json).data(using: .utf8)!
//                let dot: Welcome?
//                do {
//                    dot = try JSONDecoder().decode(Welcome.self, from: data)
//                } catch {
//                    completion(.failure(.JsonParseFailed))
//                    return
//                }
//                
//                guard let dot = dot else {
//                    completion(.failure(.JsonParseFailed))
//                    return
//                }
//               
//                let videoId = dot.id
//                let videoCreatedTime = dot.createTime
//                
//                self.dataFile = "\(videoId)-\(videoCreatedTime).json"
//                let UUU: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/data/\(self.dataFile!)")
//                let jsonData = try! JSONEncoder().encode(dot)
//                let jsonString = String(data: jsonData, encoding: .utf8)!
//                try! jsonString.write(to: UUU, atomically: true, encoding: .utf8)
//                
//                let dlAddr = dot.video.downloadAddr
//                request.url = URL(string: dlAddr)!
//                HTTPCookieStorage.shared.setCookie(HTTPCookie(properties: [.domain: dlAddr, .path: "/", .name: "tt_webid", .value: "6972893547414586885", .secure: "FALSE", .discard: "TRUE"])!)
//                HTTPCookieStorage.shared.setCookie(HTTPCookie(properties: [.domain: dlAddr, .path: "/", .name: "tt_webid_v2", .value: "6972893547414586885", .secure: "FALSE", .discard: "TRUE"])!)
//                print("start url session")
//                let videoTask = URLSession.shared.dataTask(with: request) { data, response, error in
//                    
//                    if let response = response as? HTTPURLResponse {
//                        if response.statusCode == 206 {
//                            if let data = data {
//                                self.fileName = "\(videoId)-\(videoCreatedTime).mp4"
//                                let UUU: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/\(self.fileName!)")
//                                print("downloading \(self.fileName!)")
//                                do {
//                                    try data.write(to: UUU)
//                                } catch {
//                                    completion(.failure(.VideoSaveFailed))
//                                    return
//                                }
//                                completion(.success(Tiktok(withFileName: "\(videoId)-\(videoCreatedTime)", withData: dot)))
//                                
//                            }
//                        } else {
//                            completion(.failure(.DownloadVideoForbiden))
//                        }
//                    }
//                }
//                videoTask.resume()
//                
//                let coverAddr = dot.video.cover
//                request.url = URL(string: coverAddr)!
//                HTTPCookieStorage.shared.setCookie(HTTPCookie(properties: [.domain: coverAddr, .path: "/", .name: "tt_webid", .value: "6972893547414586885", .secure: "FALSE", .discard: "TRUE"])!)
//                HTTPCookieStorage.shared.setCookie(HTTPCookie(properties: [.domain: coverAddr, .path: "/", .name: "tt_webid_v2", .value: "6972893547414586885", .secure: "FALSE", .discard: "TRUE"])!)
//                
//                let imageTask = URLSession.shared.dataTask(with: request) { data, response, error in
//                    if let data = data {
//                        
//                        self.coverFile = "\(videoId)-\(videoCreatedTime).jpg"
//                        let UUU: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/covers/\(self.coverFile!)")
//                        print("downloading cover\(self.coverFile!)")
//                        do {
//                            try data.write(to: UUU)
//                            //try self.saveToPhotos()
//                        } catch {
//                            completion(.failure(.CoverSaveFailed))
//                            return
//                        }
//                    }
//                }
//                imageTask.resume()
//            }
//        }
//        dataTask.resume()
//    }
//}
//
//struct Tiktok: Identifiable {
//    var id = UUID().uuidString
//    var data: Welcome? = nil
//    var name: String
//    var fileName: String
//    var coverFile: String
//    var dataFile: String
//    var vImg: VImageLoader? = nil
//    var player: AVPlayer?
//    
//    enum fileType {
//        case data
//        case video
//        case cover
//    }
//    
//    
//    init(withFileName: String, withData: Welcome? = nil, player: AVPlayer? = nil) {
//        name = withFileName
//        fileName = "\(withFileName).mp4"
//        coverFile = "\(withFileName).jpg"
//        dataFile = "\(withFileName).json"
//        
//        if withData == nil {
//            let path = FileManager.documentsDirectory().appendingPathComponent("tiktoks/data/\(dataFile)")
//            if let data = try? Data(contentsOf: path) {
//                let decoder = JSONDecoder()
//                do {
//                    self.data = try decoder.decode(
//                        Welcome.self,
//                        from: data)
//                } catch {
//                    print("Error decoding item array: \(error.localizedDescription)")
//                }
//            }
//        } else {
//            data = withData
//        }
//        
//        loadCover()
//    }
//    
//    public func url(forFile: fileType) -> URL {
//        switch forFile {
//        case .video:
//            return FileManager.documentsDirectory().appendingPathComponent("tiktoks/\(fileName)")
//        case .data:
//            return FileManager.documentsDirectory().appendingPathComponent("tiktoks/data/\(dataFile)")
//        case .cover:
//            return FileManager.documentsDirectory().appendingPathComponent("tiktoks/covers/\(coverFile)")
//        }
//    }
//    
//    public mutating func loadCover() {
//        if let data = data {
//            vImg = VImageLoader(withUrl: url(forFile: .cover).relativeString , width: 160, height: 160, data: data, withVideoUrl: url(forFile: .video), bundleNames: ["f": fileName, "d": dataFile, "c": coverFile], sheet: SheetObservable())
//        }
//    }
//    
//    public func delete() {
//        do {
//            try FileManager.default.removeItem(at: self.url(forFile: .video))
//            try FileManager.default.removeItem(at: self.url(forFile: .data))
//            try FileManager.default.removeItem(at: self.url(forFile: .cover))
//        } catch {
//            print("Could not delete file: \(error)")
//        }
//    }
//}
//
//struct TikTokVideoURL {
//    public var withUrl: String
//    private var loaded: Bool
//    @State private var imgData: UIImage? = nil
//    @ObservedObject var Sheet: SheetObservable
//    @State var deleted = false
//    
//    var data: Welcome
//    let videoUrl: URL
//    var videoPlayer: AVPlayer
//    var bundleNames: [String: String]
//    @State var playerState = false
//    @State var playerTime: CMTime = CMTime(seconds: 0, preferredTimescale: 0)
//    public var width: CGFloat
//    public var height: CGFloat
//    
//    init(withUrl: String, width: CGFloat, height: CGFloat, data: Welcome, withVideoUrl: URL, bundleNames: [String:String], sheet: SheetObservable) {
//        self.withUrl = withUrl
//        self.loaded = false
//        self.width = width
//        self.height = height
//        self.data = data
//        self.videoUrl = withVideoUrl
//        self.videoPlayer = AVPlayer(url:  videoUrl)
//        self.Sheet = sheet
//        self.bundleNames = bundleNames
//    }
//    
//    public func openSheet() {
//        print("openSheet fired()")
//        self.Sheet.isActive = true
//    }
//    
//    public func saveToPhotos() throws {
//        PHPhotoLibrary.shared().performChanges({
//            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoUrl)
//        }) { saved, error in
//            if saved {
//                let succesNotif = Notification(text: "Successfully saved to photo", title: "Info")
//                succesNotif.execute()
//            }
//            if (error != nil) {
//                let errNotif = Notification(text: "Failed to save to photo", title: "Error")
//                errNotif.execute()
//            }
//        }
//    }
//    
//    func getImage() {
//        let url = URL(string: withUrl)!
//        let data = try! Data(contentsOf: url)
//        self.imgData = UIImage(data:data)!
//    }
//}
//
//struct VImageLoader: View {
//    
//    public var withUrl: String
//    private var loaded: Bool
//    @State private var imgData: UIImage? = nil
//    @ObservedObject var Sheet: SheetObservable
//    @State var deleted = false
//    
//    var data: Welcome
//    let videoUrl: URL
//    var videoPlayer: AVPlayer
//    var bundleNames: [String: String]
//    @State var playerState = false
//    @State var playerTime: CMTime = CMTime(seconds: 0, preferredTimescale: 0)
//    public var width: CGFloat
//    public var height: CGFloat
//    
//    init(withUrl: String, width: CGFloat, height: CGFloat, data: Welcome, withVideoUrl: URL, bundleNames: [String:String], sheet: SheetObservable) {
//        self.withUrl = withUrl
//        self.loaded = false
//        self.width = width
//        self.height = height
//        self.data = data
//        self.videoUrl = withVideoUrl
//        self.videoPlayer = AVPlayer(url:  videoUrl)
//        self.Sheet = sheet
//        self.bundleNames = bundleNames
//    }
//    
//    public func openSheet() {
//        print("openSheet fired()")
//        self.Sheet.isActive = true
//    }
//    
//    public func saveToPhotos() throws {
//        PHPhotoLibrary.shared().performChanges({
//            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoUrl)
//        }) { saved, error in
//            if saved {
//                let succesNotif = Notification(text: "Successfully saved to photo", title: "Info")
//                succesNotif.execute()
//            }
//            if (error != nil) {
//                let errNotif = Notification(text: "Failed to save to photo", title: "Error")
//                errNotif.execute()
//            }
//        }
//    }
//    
//    func getImage() {
//        let url = URL(string: withUrl)!
//        let data = try! Data(contentsOf: url)
//        self.imgData = UIImage(data:data)!
//    }
//    
//    var body: some View {
//        ZStack{
//            Color.barBackgroundGrey
//            
//            HStack{
//                
//                if imgData != nil {
//                    Image(uiImage: imgData!)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 109, height: 148)
//                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                        .shadow(radius: 7)
//                    
//                } else {
//                    
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color.barBackgroundGrey)
//                            .frame(width: 130, height: 130)
//                            .shadow(color: Color.white, radius: 2)
//                        Image("CirclePhoto")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 130, height: 130)
//                    }
//                    .padding(.horizontal, 10)
//                }
//                
//                VStack(alignment: .leading) {
//                    if let name = self.data.desc {
//                        Text("\(name)")
//                            .font(Font.custom("Montserrat", size: 12.0))
//                            .padding(.top, 10)
//                        //.frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    Spacer()
//                }
//                Spacer()
//            }
//        }
//        .clipShape( RoundedRectangle(cornerRadius: 10))
//        .frame(maxWidth: .infinity)
//        .frame(height: 150)
//        .padding(.horizontal, 10)
//        .padding(.top, 5)
//        
//        .onAppear {
//            if imgData == nil {
//                DispatchQueue.global(qos: .userInitiated).async {
//                    self.getImage()
//                }
//            }
//        }
//    }
//}
//
//class SheetObservable: ObservableObject {
//    @Published var isActive = false
//}

//
//enum downloaderErrors: Error {
//    case InvalidUrlGiven
//    case JsonScrapFailed
//    case JsonParseFailed
//    case DownloadVideoForbiden
//    case VideoDownloadFailed
//    case VideoSaveFailed
//    case CoverSaveFailed
//}
