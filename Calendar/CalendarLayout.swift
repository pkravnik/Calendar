//
//  CalendarLayout.swift
//  Calendar
//
//  Created by Petr Kravnik on 08.12.2024.
//

import SwiftUI

struct CalendarLayout: Layout {
    let daysInWeek: Int
    let spacing: Int
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard let width = proposal.width else { return .zero }
        guard !subviews.isEmpty else { return .zero }
        let rows = subviews.count / daysInWeek
        let cellWidth = width / CGFloat(daysInWeek)
        let size = CGSize(width: width, height: cellWidth * CGFloat(rows))
        return size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard let width = proposal.width else { return }
        guard !subviews.isEmpty else { return }
        let totalSpacing = spacing * (daysInWeek-1)
        let cellWidth = (width - CGFloat(totalSpacing)) / CGFloat(daysInWeek)
        var row = 0
        var col = 0
        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0
        for subview in subviews {
            let origin = CGPoint(x: Double(col) * cellWidth + bounds.minX + offsetX, y: Double(row) * cellWidth + bounds.minY + offsetY)
            let size = CGSize(width: cellWidth, height: cellWidth)
            subview.place(at: origin, proposal: ProposedViewSize(size))
            col += 1
            offsetX += CGFloat(spacing)
            if col == daysInWeek {
                row += 1
                col = 0
                offsetX = 0
                offsetY += CGFloat(spacing)
            }
        }
    }
}

struct CalendarLayoutItem: Identifiable {
    let id: Int
    let color: Color
    
    static var sampleData: [CalendarLayoutItem] {
        [
            CalendarLayoutItem(id: 0, color: .red),
            CalendarLayoutItem(id: 1, color: .green),
            CalendarLayoutItem(id: 2, color: .blue),
            CalendarLayoutItem(id: 3, color: .mint),
            CalendarLayoutItem(id: 4, color: .yellow),
            CalendarLayoutItem(id: 5, color: .purple),
            CalendarLayoutItem(id: 6, color: .orange),
            CalendarLayoutItem(id: 7, color: .pink),
            CalendarLayoutItem(id: 8, color: .brown),
            CalendarLayoutItem(id: 9, color: .cyan),
            CalendarLayoutItem(id: 10, color: .gray),
            CalendarLayoutItem(id: 11, color: .teal)
        ]
    }
    
    static var sampleDataSmall: [CalendarLayoutItem] {
        [
            CalendarLayoutItem(id: 0, color: .red),
            CalendarLayoutItem(id: 1, color: .green),
            CalendarLayoutItem(id: 2, color: .blue),
            CalendarLayoutItem(id: 3, color: .mint),
            CalendarLayoutItem(id: 4, color: .yellow),
            CalendarLayoutItem(id: 5, color: .purple),
        ]
    }
}

struct PreviewView: View {
    var body: some View {
        CalendarLayout(daysInWeek: 3, spacing: 8) {
            ForEach(CalendarLayoutItem.sampleDataSmall) { item in
                Text(item.id, format: .number)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        item.color
                    }
            }
        }
        .padding(8)
    }
}

#Preview {
    PreviewView()
}
