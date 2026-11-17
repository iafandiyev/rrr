import SwiftUI

/// The main gameplay screen. A bright circle appears at a random position;
/// the player taps it as quickly as possible to score points.
struct GameView: View {
    @ObservedObject var game: GameManager

    @State private var bounds: CGSize = .zero

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            // Score and timer HUD at the top.
            VStack {
                HStack {
                    Text("Score \(game.score)")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Spacer()

                    Text("\(game.timeRemaining)")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 32)
                .padding(.top, 52)

                Spacer()
            }

            // The target circle.
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color.cyan, Color.blue, Color.purple, Color.pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 64, height: 64)
                .shadow(color: .white.opacity(0.35), radius: 12, x: 0, y: 6)
                // Animate appearance and movement between positions.
                .scaleEffect(game.state == .playing ? 1.0 : 0.0)
                .animation(.spring(response: 0.4, dampingFraction: 0.75), value: game.state == .playing)
                .animation(.spring(response: 0.35, dampingFraction: 0.8), value: game.targetPosition)
                .position(game.targetPosition)
                .contentShape(Circle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { _ in
                            game.handleTargetTap()
                            game.placeTarget(in: bounds)
                        }
                )
                .onAppear {
                    game.placeTarget(in: bounds)
                }
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    .onAppear { bounds = geo.size }
                    .onChange(of: geo.size, perform: { _, newSize in
                        bounds = newSize
                        game.placeTarget(in: newSize)
                    })
            }
        )
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: GameManager())
    }
}
