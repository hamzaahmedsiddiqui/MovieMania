
import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel = DashboardViewModel(
        nowPlayingMoviesApi: NowPlayingMoviesApiImplementation(),
        popularMoviesApi: PopularMoviesApiImplementation(),
        topRatedMoviesApi: TopRatedMoviesApiImplementation(),
        upcomingMoviesApi: UpcomingMoviesApiImplementation()
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background View
                GradientView(firstColor: .red, secondColor: .purple, thirdColor: .blue)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        // Now Playing Movies Section
                        MovieSection(title: .nowPlaying, movies: viewModel.state.nowPlayingMovies, viewModel: viewModel)
                        
                        // Popular Movies Section
                        MovieSection(title: .popular, movies: viewModel.state.popularMovies, viewModel: viewModel)
                        
                        // Top Rated Movies Section
                        MovieSection(title: .topRated, movies: viewModel.state.topRatedMovies, viewModel: viewModel)
                        
                        // Upcoming Movies Section
                        MovieSection(title: .upcoming, movies: viewModel.state.upcomingMovies, viewModel: viewModel)
                    }
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }
}

/// Movie Section View with Navigation
struct MovieSection: View {
    let title: MovieSectionType
    let movies: [Movie]
    let viewModel: DashboardViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            MovieSectionTitleView(title: title.rawValue, fontSize: 24)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                            MovieCardView(movie: movie)
                        }
                    }
                }
            }
            .onChange(of: movies.last) { lastMovie in
                guard let lastMovie = lastMovie else { return }
                if movies.firstIndex(of: lastMovie) == movies.count - 1 {
                    viewModel.fetchNowPlayingMovies(pageNo: 2)
                }
            }
        }
    }
}

enum MovieSectionType:String {
    case popular    =  "Popular Movies"
    case topRated   =  "Top Rated Movies"
    case upcoming   =  "Upcoming Movies"
    case nowPlaying =  "Now Playing Movies"
}
