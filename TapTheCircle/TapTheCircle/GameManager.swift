import SwiftUI
import Combine

/// The single source of truth for the "Tap the Circle" reaction game.
///
/// Responsibilities:
/// - Tracks score, remaining time, and game state.
/// - Places the target circle at a random position.
/// - Runs the 30 second countdown timer.
/// - Persists the high score in UserDefaults.
final class GameManager: ObservableObject {

    enum GameState: Equatable {
        case start
        case playing
        case gameOver
    }

    // MARK: - Published state

    @Published var state: GameState = .start
    @Published var score: Int = 0
    @Published var timeRemaining: Int = 0
    @Published var targetPosition: CGPoint = .zero

    @Published var highScore: Int = 0

    // MARK: - Private

    private let gameDuration: Int = 30
    private var timer: AnyCancellable?

    private let userDefaultsKey = "TapTheCircleHighScore"

    init() {
        self.highScore = UserDefaults.standard.integer(forKey: userDefaultsKey)
    }

    // MARK: - Game flow

    func startGame() {
        score = 0
        timeRemaining = gameDuration
        state = .playing
        startTimer()
    }

    func endGame() {
        timer?.cancel()
        state = .gameOver

        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: userDefaultsKey)
        }
    }

    func restart() {
        startGame()
    }

    // MARK: - Target placement

    /// Places the target circle at a random position within the given bounds.
    /// - Parameter bounds: The size of the playable area.
    func placeTarget(in bounds: CGSize) {
        guard bounds.width > 0, bounds.height > 0 else { return }

        let targetSize: CGFloat = 64
        let horizontalPadding: CGFloat = 40
        let topPadding: CGFloat = 160      // room for the score/timer HUD
        let bottomPadding: CGFloat = 100   // room for the home indicator

        let minX = horizontalPadding + targetSize / 2
        let maxX = bounds.width - horizontalPadding - targetSize / 2
        let minY = topPadding + targetSize / 2
        let maxY = bounds.height - bottomPadding - targetSize / 2

        let x = CGFloat.random(in: minX...max(maxX, minX + 1))
        let y = CGFloat.random(in: minY...max(maxY, minY + 1))

        targetPosition = CGPoint(x: x, y: y)
    }

    /// Registers a successful tap on the target.
    func handleTargetTap() {
        guard state == .playing else { return }

        score += 1

        // Haptic feedback for a crisp, tactile response.
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
    }

    // MARK: - Timer

    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, self.state == .playing else { return }

                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }

                if self.timeRemaining == 0 {
                    self.endGame()
                }
            }
    }
}
