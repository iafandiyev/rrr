import SwiftUI

/// Root view that switches between the start, playing and game-over screens.
struct ContentView: View {
    @StateObject private var game = GameManager()

    var body: some View {
        Group {
            switch game.state {
            case .start:
                StartView(startGame: game.startGame)

            case .playing:
                GameView(game: game)

            case .gameOver:
                GameOverView(
                    score: game.score,
                    highScore: game.highScore,
                    restart: game.restart
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
