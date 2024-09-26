import SwiftUI

struct DashboardSwiftUIView: View {
    @StateObject var viewModel = DashboardViewModelImplementation(
        nowPlayingMoviesApi: NowPlayingMoviesApiImplementation(),
        popularMoviesApi: PopularMoviesApiImplementation(),
        topRatedMoviesApi: TopRatedMoviesApiImplementation(),
        upcomingMoviesApi: UpcomingMoviesApiImplementation()
    )
    
    var body: some View {
        TabView {
            ZStack {
                
                GradientView(firstColor: .red, secondColor: .purple, thirdColor: .blue)
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        MovieSectionTitleView(title: "Now Playing", fontSize: 24)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.nowPlayingMovies) { movie in
                                    MovieCardView(posterPath: movie.posterPath, movieTitle: movie.title)
                                }
                            }
                        }
                        .frame(height: 200)
                        
                        // Popular Movies Section
                        MovieSectionTitleView(title: "Popular Movies", fontSize: 24)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.popularMovies) { movie in
                                    MovieCardView(posterPath: movie.posterPath, movieTitle: movie.title)
                                }
                            }
                        }
                        .frame(height: 200)
                        
                        // Top Rated Movies Section
                        MovieSectionTitleView(title: "Top Rated Movies", fontSize: 24)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.topRatedMovies) { movie in
                                    MovieCardView(posterPath: movie.posterPath, movieTitle: movie.title)
                                }
                            }
                        }
                        .frame(height: 200)
                        
                        // Upcoming Movies Section
                        MovieSectionTitleView(title: "Upcoming Movies", fontSize: 24)
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
                
            }.tabItem {
                Label("Dashboard", systemImage: "house")
            }
            
            // Other tab: For example, Search or Profile tab
            Text("Search Movies")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}



#Preview {
    DashboardSwiftUIView()
}
