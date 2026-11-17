import SwiftUI

/// The end-of-game screen showing the final score, best score and a restart button.
struct GameOverView: View {
    let score: Int
    let highScore: Int
    let restart: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer()

                Text("Time's up!")
                    .font(.system(size: 48, weight: .black, design: .rounded))
                    .foregroundStyle(.white)

                Text("Score \(score)")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(.cyan)

                HStack(spacing: 16) {
                    Label("Best", systemImage: "crown.fill")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.8))
                    Text("\(highScore)")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.8))
                }

                Button(action: restart) {
                    Text("Play Again")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(
                            LinearGradient(
                                colors: [Color.cyan, Color.blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(30)
                        .shadow(color: .cyan.opacity(0.5), radius: 14, x: 0, y: 7)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 80)

                Spacer()
            }
            .padding()
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(score: 42, highScore: 58, restart: {})
    }
}
