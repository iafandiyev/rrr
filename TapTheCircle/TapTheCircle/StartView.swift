import SwiftUI

/// The welcome / start screen shown before the first game begins.
struct StartView: View {
    let startGame: () -> Void

    var body: some View {
        ZStack {
            // Dark background.
            Color.black.ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                Text("TAP THE CIRCLE")
                    .font(.system(size: 52, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .cyan.opacity(0.6), radius: 16, x: 0, y: 0)

                Text("Reaction game \u2022 30 seconds")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.white.opacity(0.55))

                // Large preview of the target circle.
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.cyan, Color.blue, Color.purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                    .shadow(color: .white.opacity(0.35), radius: 14, x: 0, y: 8)
                    .scaleEffect(1.0)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: UUID())

                Button(action: startGame) {
                    Text("Start Game")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .background(
                            LinearGradient(
                                colors: [Color.cyan, Color.blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(32)
                        .shadow(color: .cyan.opacity(0.5), radius: 16, x: 0, y: 8)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 80)

                Spacer()
            }
            .padding()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(startGame: {})
    }
}
