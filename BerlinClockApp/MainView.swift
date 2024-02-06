//
//  MainView.swift
//  BerlinClockApp
//
//  Created by Aisha Nurgaliyeva on 30.01.2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var date = Date()
    @State private var timePicker = Date()
    @State private var titleDate = ""
    @State private var berlinDate: [String] = []
    
    let rowShape =  RoundedRectangle(cornerRadius: 4, style: .circular)
    
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                
                Text("Time is \(titleDate)")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.top, 12)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .foregroundColor(.white)
                        .frame(height: 312)
                    
                    VStack(spacing: 16) {
                        
                        if(berlinDate.count > 0) {
                            secondsBlock
                            fiveHoursBlock
                            singleHoursBlock
                            fiveMinutesBlock
                            singleMinutesBlock
                        }
                       
                    }
                }
                                
                timePickerBlock
                
                Spacer()
            
            }
            .padding()
            .onAppear {
                parseTime()
            }
        }
    }
    
    private func parseTime() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let calendar = Calendar.current
            var hours = calendar.component(.hour, from: timePicker)
            var minutes = calendar.component(.minute, from: timePicker)
            var seconds = calendar.component(.second, from: .now)
            
            seconds += 1
            
            if seconds == 60 {
                minutes += 1
                seconds = 0
                if minutes == 60 {
                    hours += 1
                    minutes = 0
                    if hours == 24 {
                        hours = 0
                        if let newTime = Calendar.current.date(bySettingHour: hours, minute: minutes, second: seconds, of: date) {
                            date = newTime
                        }
                    }
                }
            }
            
            let berlinClock = MainLogic()
            titleDate = String(format: "%02d:%02d:%02d", 
                               hours, minutes, seconds)
            
            berlinDate = berlinClock.parseToBerlinClockTime(hours: hours, minutes: minutes, seconds: seconds).map {
                String($0)
            }
        }
    }
    
    
    //MARK: - UI Components
    
    private var secondsBlock: some View {
        Circle()
            .fill(berlinDate[0] == "Y" ? Color.yellowOn : Color.yellowOff)
            .frame(width: 56)
    }
    
    private var fiveHoursBlock: some View {
        HStack(spacing: 8) {
            ForEach(1..<5) { i in
                rowShape
                    .fill(berlinDate[i] == "R" ? Color.redOn : Color.redOff)
                    .frame(width: K.wideWidth, height: K.height)
            }
        }
    }
    
    private var singleHoursBlock: some View {
        HStack(spacing: 8) {
            ForEach(5..<9) { i in
                rowShape
                    .fill(berlinDate[i] == "R" ? Color.redOn : Color.redOff)
                    .frame(width: K.wideWidth, height: K.height)
            }
        }
    }
    
    private var fiveMinutesBlock: some View {
        HStack(spacing: 10) {
            ForEach(9..<20) { i in
                rowShape
                    .fill(
                        decideColorFor(i: i, letter: berlinDate[i])
                    )
                    .frame(width: K.fiveMinWidth, height: K.height)
            }
        }
    }
    
    // Function for Five Minutes Block, so every 3rd rowShape is colored to red (on or off)
    private func decideColorFor(i: Int, letter: String) -> Color {
        var color = Color.clear
        if letter == "Y" {
            color = Color.yellowOn
        } else if letter == "R" {
            color = Color.redOn
        } else if (i + 1) % 3 == 0 {
            color = Color.redOff
        } else {
            color = Color.yellowOff
        }
        return color
    }
    
    private var singleMinutesBlock: some View {
        HStack(spacing: 8) {
            ForEach(20..<24) { i in
                rowShape
                    .fill(berlinDate[i] == "Y" ? Color.yellowOn : Color.yellowOff)
                    .frame(width: K.wideWidth, height: K.height)
            }
        }
    }

    private var timePickerBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .foregroundColor(.white)
            
            HStack {
                Text("Insert time")
                    .font(.system(size: 18, weight: .medium))

                DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    .onChange(of: date, perform: {
                        newTime in
                        timePicker = newTime
                    })
            }
            .padding([.leading, .trailing], 16)
        }
        .frame(height: 54)
        
    }

}

#Preview {
    MainView()
}
