import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel = DashboardViewModelImplementation(
        nowPlayingMoviesApi: NowPlayingMoviesApiImplementation(),
        popularMoviesApi: PopularMoviesApiImplementation(),
        topRatedMoviesApi: TopRatedMoviesApiImplementation(),
        upcomingMoviesApi: UpcomingMoviesApiImplementation()
    )
    
    var body: some View {
        ZStack(alignment: .bottom) {

            TabView {
                ZStack {
                    GradientView(firstColor: .red, secondColor: .purple, thirdColor: .blue)
                    ScrollView(.vertical,showsIndicators: false) {
                        VStack(alignment: .leading) {
                            // Now Playing Movies Section
                            MovieSectionTitleView(title: "Now Playing", fontSize: 24)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.nowPlayingMovies) { movie in
                                        MovieCardView(posterPath: movie.posterPath, movieTitle: movie.title)
                                    }
                                }
                            }.background(Color.clear)
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
                            .background(Color.clear)
                            
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
                            .background(Color.clear)
                            
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
                            .background(Color.clear)
                        }.background(Color.clear)
                    }.background(Color.clear)
                    .padding()
                    .onAppear {
                        viewModel.fetchNowplayingMovies()
                        viewModel.fetchPopularMovies()
                        viewModel.fetchTopRatedMovies()
                        viewModel.fetchUpcomingMovies()
                    }
                }.background(Color.clear)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Dashboard")
                }
            
                
                Text( "SearchView")
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }

                Text("SettingsView")
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                Text( "Profile")
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
            }
            .background(Color.clear) // Clear to show custom background
        }

    }
}

#Preview {
    DashboardView()
}
