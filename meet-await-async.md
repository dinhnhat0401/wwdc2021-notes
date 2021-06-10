# meet async/await

- What is await/async

swift syntax to write asynchronous code.
available from swift 5.5

Async functions let you write concurrent code without the need for callbacks, by using the await keyword.
Calling an async function will suspend and then be resumed whenever a value or error is produced.

- How to use await/async

Fetching a thumbnail: (Sample from wwdc2021)

<img width="634" alt="Screen Shot 2021-06-09 at 15 18 52" src="https://user-images.githubusercontent.com/2002871/121484394-22f69080-ca0a-11eb-8f59-87de1789b4ad.png">

completion verison

```swift
func fetchThumbnail(for id: String, completion: @escaping (UIImage?, Error?) -> Void) {
    let request = thumbnailURLRequest(for: id)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(nil, error)
        } else if (response as? HTTPURLResponse)?.statusCode != 200 {
            completion(nil, FetchError.badID)
        } else {
            guard let image = UIImage(data: data!) else {
                completion(nil, FetchError.badImage)
                return
            }
            image.prepareThumbnail(of: CGSize(width: 40, height: 40)) { thumbnail in
                guard let thumbnail = thumbnail else {
                    completion(nil, FetchError.badImage)
                    return
                }
                completion(thumbnail, nil)
            }
        }
    }
    task.resume()
}
```    

await/async version

```swift
func fetchThumbnail(for id: String) async throws -> UIImage {
    let request = thumbnailURLRequest(for: id)  
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badID }
    let maybeImage = UIImage(data: data)
    guard let thumbnail = await maybeImage?.thumbnail else { throw FetchError.badImage }
    return thumbnail
} 
```

- How await/async works?

normal function call
<img width="1125" alt="Screen Shot 2021-06-10 at 16 43 05" src="https://user-images.githubusercontent.com/2002871/121485196-eecf9f80-ca0a-11eb-8285-9a9339d3f8f7.png">

async function call which will be eventually suspense if needed and give back the control to the System.
<img width="1132" alt="Screen Shot 2021-06-10 at 16 45 09" src="https://user-images.githubusercontent.com/2002871/121485522-39511c00-ca0b-11eb-9a9f-3670907899a4.png">


- Why await/async?

  - Shorter code
  - Completion is error prone due to lack of missing completion calling checker method

- How to test?

- How to bridge between async and sync function

Use `async { code block }`

```
struct ThumbnailView: View {
    @ObservedObject var viewModel: ViewModel
    var post: Post
    @State private var image: UIImage?

    var body: some View {
        Image(uiImage: self.image ?? placeholder)
            .onAppear {
                async {
                    self.image = try? await self.viewModel.fetchThumbnail(for: post.id)
                }
            }
    }
}
```

- How to bridge between callback/delegate and await/async

```
// Existing function
func getPersistentPosts(completion: @escaping ([Post], Error?) -> Void) {       
    do {
        let req = Post.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        let asyncRequest = NSAsynchronousFetchRequest<Post>(fetchRequest: req) { result in
            completion(result.finalResult ?? [], nil)
        }
        try self.managedObjectContext.execute(asyncRequest)
    } catch {
        completion([], error)
    }
}

// Async alternative
func persistentPosts() async throws -> [Post] {       
    typealias PostContinuation = CheckedContinuation<[Post], Error>
    return try await withCheckedThrowingContinuation { (continuation: PostContinuation) in
        self.getPersistentPosts { posts, error in
            if let error = error { 
                continuation.resume(throwing: error) 
            } else {
                continuation.resume(returning: posts)
            }
        }
    }
}
```

Note
