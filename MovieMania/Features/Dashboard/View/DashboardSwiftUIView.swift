import SwiftUI

struct DashboardSwiftUIView: View {
    @StateObject var viewModel = DashboardViewModelImplementation(
        nowPlayingMoviesApi: NowPlayingMoviesApiImplementation(),
        popularMoviesApi: PopularMoviesApiImplementation(),
        topRatedMoviesApi: TopRatedMoviesApiImplementation(),
        upcomingMoviesApi: UpcomingMoviesApiImplementation()
    )
    
    var body: some View {
        // VStack {
        //   List(viewModel.nowPlayingMovies) { movie in
        //                HStack {
        //                    // Display the movie poster
        //                    MovieImageView(imagePath: movie.posterPath)
        //
        //                    // Display the movie title
        //                    Text(movie.title)
        //                        .font(.headline)
        //                        .padding()
        //                }
        //    }
        
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("Now Playing")
                    .font(.title)
                    .padding([.leading, .top])
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.nowPlayingMovies) { movie in
                            MovieCardView(posterPath: movie.posterPath, movieTitle: movie.title)
                        }
                    }
                }
                .frame(height: 200)
                
                // Popular Movies Section
                Text("Popular Movies")
                    .font(.title)
                    .padding([.leading, .top])
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.popularMovies) { movie in
                            MovieCardView(posterPath: movie.posterPath, movieTitle: movie.title)
                        }
                    }
                }
                .frame(height: 200)
                
                // Top Rated Movies Section
                Text("Top Rated Movies")
                    .font(.title)
                    .padding([.leading, .top])
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.topRatedMovies) { movie in
                            MovieCardView(posterPath: movie.posterPath, movieTitle: movie.title)
                        }
                    }
                }
                .frame(height: 200)
                
                // Upcoming Movies Section
                Text("Upcoming Movies")
                    .font(.title)
                    .padding([.leading, .top])
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.upcomingMovies) { movie in
                            MovieCardView(posterPath: movie.posterPath, movieTitle: movie.title)
                        }
                    }
                }
                .frame(height: 200)
            }
            
        }
        
        .onAppear {
            viewModel.fetchNowplayingMovies()
            viewModel.fetchPopularMovies()
            viewModel.fetchTopRatedMovies()
            viewModel.fetchUpcomingMovies()
        }
        //    }
    }
}
struct MovieCardView: View {
    let posterPath: String?
    let movieTitle: String
    @State private var fetchedImage: Image? = nil
    
    var body: some View {
        VStack {
            MovieImageView(imagePath: posterPath ?? "")
                .frame(width: 100, height: 150)
                .cornerRadius(10)
            Text(movieTitle)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(width: 100)
        }
        .padding()
    }
}
struct MovieImageView: View {
    let imagePath: String?
    @State private var fetchedImage: Image? = nil
    @StateObject var viewModel = DashboardViewModelImplementation(
        nowPlayingMoviesApi: NowPlayingMoviesApiImplementation(),
        popularMoviesApi: PopularMoviesApiImplementation(),
        topRatedMoviesApi: TopRatedMoviesApiImplementation(),
        upcomingMoviesApi: UpcomingMoviesApiImplementation()
    )
    var body: some View {
        VStack {
            if let image = viewModel.fetchedImage {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 150)
                
            } else {
                Text("Loading image...")
                    .onAppear {
                        viewModel.fetchImage(from: imagePath ?? "")
                    }
            }
        }
    }
}

#Preview {
    DashboardSwiftUIView()
}
