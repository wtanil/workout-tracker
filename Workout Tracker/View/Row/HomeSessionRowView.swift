//
//  HomeSessionRowView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 14/11/23.
//

import SwiftUI

struct HomeSessionRowView: View {
    var name: String
    var date: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(date)
            Text(name)
        }
    }
}

struct HomeSessionRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSessionRowView(name: "name", date: "date")
    }
}
