import SwiftUI

struct BeltCardView: View {
    let belt: Belt

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(belt.theme.opacity(belt == .white ? 0.16 : 0.22))
                    .frame(width: 58, height: 58)
                Image(systemName: "figure.martial.arts")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(belt == .black ? .primary : belt.theme)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(belt.rawValue)
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.82)
                Text(belt.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.78)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption.bold())
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: 1)
        )
        .contentShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}
