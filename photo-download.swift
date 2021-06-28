enum FetchError: Error {
    case badID
    case badImage
}

extension UIImage {
    var thumbnail: UIImage? {
        get async {
            self.preparingThumbnail(of: CGSize(width: 40, height: 40))
        }
    }
}


func fetchThumbnail() async throws -> UIImage {
    let request = thumbnailURLRequest()
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badID }
    let maybeImage = UIImage(data: data)
    guard let thumbnail = await maybeImage?.thumbnail else { throw FetchError.badImage }
    return thumbnail
}

func thumbnailURLRequest() -> URLRequest {
    return URLRequest(url: URL(string: "https://www.google.co.jp/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png")!)
}

async {
    let image = try await fetchThumbnail()
    print(image)
}
