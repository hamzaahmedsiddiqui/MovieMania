
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
                        MovieSection(title: "Now Playing", movies: viewModel.state.nowPlayingMovies)
                        
                        // Popular Movies Section
                        MovieSection(title: "Popular Movies", movies: viewModel.state.popularMovies)
                        
                        // Top Rated Movies Section
                        MovieSection(title: "Top Rated Movies", movies: viewModel.state.topRatedMovies)
                        
                        // Upcoming Movies Section
                        MovieSection(title: "Upcoming Movies", movies: viewModel.state.upcomingMovies)
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
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            MovieSectionTitleView(title: title, fontSize: 24)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                            MovieCardView(movie: movie)
                        }
                    }
                }
            }
        }
    }
}
