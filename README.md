# MEMOiRS
**ME**dia**MO**nks **i**OS [**R**eally good an able to do other stuff good, too] **S**ample

Just a quick code sample for an App that fetches info from a the JSONPlaceholder API, and builds on top of that.

Data Models use Codable for easy JSON mapping.

Networking is done through [Moya](https://github.com/Moya/Moya), which is a higher level Networking API built on top of Alamofire.
It allows for highly expressive, very generic and scallable network models. Also, it's ridiculously simple to use, which is nice.
Specially since data models are Codable compliant.
I use generics to potentially be able to better scale the networking models to other HTTP methods (all methods for this app are GET)

1- It lists photo albums (for the passed User) using a TableView.

2- It lists photos within an album (for the given album) using a collectionView. It loads the photos using [Kingfisher](https://github.com/onevcat/Kingfisher) for the thumbnails.

3- Finally, we use [Lightbox](https://github.com/hyperoslo/Lightbox) to display the full-res image on a nice swipeable view that also does key-color background painting.
