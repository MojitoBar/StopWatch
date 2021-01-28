//
//  ContentView.swift
//  Shared
//
//  Created by judongseok on 2021/01/25.
//

import SwiftUI

// Lab 부분을 따로 View로 빠서 반복 생성함
struct timeRow: View {
    var number: String
    var labcount: String
    var body: some View{
        VStack(alignment: .center){
            HStack{
                Text("Lab  \(labcount)")
                    .font(.system(size: 25))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("\(number)")
                    .font(.system(size: 25))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            .padding(.horizontal)
            .padding(.top, 5)
            .frame(width: 350)
            Divider()
        }
    }
}

struct ContentView: View {
    // current time, record time, s-> second, m-> minute
    @State private var cTime = 0
    @State private var cTime_s = 0
    @State private var cTime_m = 0
    @State private var rTime = 0
    @State private var rTime_s = 0
    @State private var rTime_m = 0
    
    // time start check
    @State var start = false;
    
    // record time array
    @State private var saveTimes : [String] = []
    // record front text array
    @State private var saveLabcount: [String] = []
    // record front text
    @State private var LabCount = 1
    
    // reset current time
    func reset_c() -> Void {
        cTime = 0;
        cTime_s = 0;
        cTime_m = 0;
    }
    
    // reset record time
    func reset_r() -> Void{
        rTime = 0;
        rTime_m = 0;
        rTime_s = 0;
    }
    
    // reset all arrays
    func reset_array() -> Void{
        saveTimes.removeAll()
        saveLabcount.removeAll()
        LabCount = 1
    }
    
    // init timer
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("StopWatch")
                .font(.system(size: 25))
                .fontWeight(.bold)
            Divider()
            VStack(alignment: .trailing){
                Text("\(String(format: "%02d", self.cTime_m)):\(String(format: "%02d", self.cTime_s)):\(String(format: "%02d", self.cTime))")
                    .font(.system(size: 35))
                    // 지정된 publisher가 이벤트를 생성할 때 수행할 작업
                    .onReceive(self.timer, perform: { _ in
                        if self.start{
                            cTime += 1
                            if cTime >= 100{
                                cTime = 0
                                cTime_s += 1
                            }
                            else if cTime_s >= 60{
                                cTime_s = 0
                                cTime_m += 1
                            }
                        }
                    })
                Text("\(String(format: "%02d", self.rTime_m)):\(String(format: "%02d", self.rTime_s)):\(String(format: "%02d", self.rTime))")
                    .font(.system(size: 65))
                    // 지정된 publisher가 이벤트를 생성할 때 수행할 작업
                    .onReceive(self.timer, perform: { _ in
                        if self.start{
                            rTime += 1
                            if rTime >= 100 {
                                rTime = 0
                                rTime_s += 1
                            }
                            else if rTime_s >= 60{
                                rTime_s = 0
                                rTime_m += 1
                            }
                        }
                    })
            }
            .padding(.top, 50)
            
            HStack{
                Button(action: {
                    // 리셋 & 랩
                    if !self.start{
                        reset_c()
                        reset_r()
                        reset_array()
                    }
                    else {
                        saveTimes.append("\(String(format: "%02d", self.rTime_m)):\(String(format: "%02d", self.rTime_s)):\(String(format: "%02d", self.rTime))")
                        saveLabcount.append(String(LabCount))
                        LabCount += 1;
                        reset_r()
                    }
                }, label: {
                    Text(self.start ? "Lap" : "Reset")
                        .font(.system(size: 20))
                        .frame(width: 150)
                })
                
                Button(action: {
                    // 스타트 & 스탑
                    self.start.toggle()
                }, label: {
                    Text(self.start ? "Stop" : "Start")
                        .font(.system(size: 20))
                        .frame(width: 150)
                })
            }
            .padding(.top, 120)
            .padding(.bottom, 30)
            // record scrollview
            ScrollView(){
                if saveTimes.count != 0{
                    ForEach((0...saveTimes.count - 1).reversed(), id: \.self){ index in
                        timeRow(number: saveTimes[index], labcount: saveLabcount[index])
                    }
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
