import SwiftUI
import AVKit

struct LocalVideoPlayerView: View {
    let title: String
    let remoteURL: URL?
    let localVideoName: String?
    let sourceCredit: String

    @State private var player: AVPlayer?

    private var localURL: URL? {
        guard let localVideoName else { return nil }
        return Bundle.main.url(forResource: localVideoName, withExtension: "mp4")
    }

    private var selectedURL: URL? {
        // Prioridade para vídeo real remoto; fallback para vídeo local, se existir.
        remoteURL ?? localURL
    }

    var body: some View {
        VStack(spacing: 16) {
            if let player {
                VideoPlayer(player: player)
                    .frame(minHeight: 280)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(.horizontal)
                    .onAppear { player.play() }
                    .onDisappear { player.pause() }

                VStack(spacing: 6) {
                    Text("Vídeo real")
                        .font(.headline)
                    Text(sourceCredit)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
            } else {
                ContentUnavailableView(
                    "Vídeo real não carregou",
                    systemImage: "video.slash",
                    description: Text("Use uma URL direta .mp4/.mov/HLS ou coloque um MP4 real em Resources/Videos e marque em Copy Bundle Resources.")
                )
            }

            Spacer()
        }
        .padding(.top)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            guard player == nil, let url = selectedURL else { return }
            player = AVPlayer(url: url)
        }
    }
}
