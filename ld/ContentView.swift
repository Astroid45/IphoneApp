import SwiftUI
import AVKit

class LoopingAVPlayerViewController: AVPlayerViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playLoopingVideo()
    }
    
    private func playLoopingVideo() {
        guard let player = player else { return }
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { [weak self] _ in
            player.seek(to: .zero)
            player.play()
        }
        
        player.play()
    }
}

struct ContentView: View {
    @State private var isToggleOn = false
    @State private var sliderValue = 0.5
    @State private var isActive = true
    
    var body: some View {
        NavigationView {
            ZStack {
                VideoPlayerView(videoURL: Bundle.main.url(forResource: "hand", withExtension: "mp4"))
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    NavigationLink(destination: Login()) {
                        VStack {
                            Image(systemName: "link.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.white)
                                .padding(.top, 300)
                            Text("Connect")
                                .font(.custom("Academy Engraved LET Plain:1.0", size: 50))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct VideoPlayerView: UIViewControllerRepresentable {
    let videoURL: URL?
    
    func makeUIViewController(context: Context) -> LoopingAVPlayerViewController {
        let playerViewController = LoopingAVPlayerViewController()
        playerViewController.showsPlaybackControls = false
        
        if let videoURL = videoURL {
            let player = AVPlayer(url: videoURL)
            playerViewController.player = player
        }
        
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: LoopingAVPlayerViewController, context: Context) {
        if let videoURL = videoURL {
            let player = AVPlayer(url: videoURL)
            uiViewController.player = player
        }
    }
}

