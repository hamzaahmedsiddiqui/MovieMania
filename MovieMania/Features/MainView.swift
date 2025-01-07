import SwiftUI

struct MainView: View {
    @StateObject var viewModel = DashboardViewModel(
        nowPlayingMoviesApi: NowPlayingMoviesApiImplementation(),
        popularMoviesApi: PopularMoviesApiImplementation(),
        topRatedMoviesApi: TopRatedMoviesApiImplementation(),
        upcomingMoviesApi: UpcomingMoviesApiImplementation()
    )
    
    var body: some View {
        ZStack(alignment: .bottom) {

            TabView {
                DashboardView()
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
                        Label("Profile", systemImage: "person")
                    }
            }
            .background(Color.clear) // Clear to show custom background
        }

    }
}

#Preview {
    MainView()
}
