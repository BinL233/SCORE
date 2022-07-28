//
//  ContentView.swift
//  Score
//
//  Created by Kaile Ying on 7/23/22.
//

import SwiftUI


struct ContentView: View {
    @State private var showingConfirmation = false
    @State private var RedS = 0
    @State private var BlueS = 0
    @State private var RedP: CGFloat = 0
    @State private var BlueP: CGFloat = 0
    
    let red = UIColor(displayP3Red: 0.8, green: 0.35, blue: 0.35, alpha: 0.94)
    let blue = UIColor(displayP3Red: 0.35, green: 0.35, blue: 0.75, alpha: 0.94)
    
    var body: some View {
        ZStack {
            HStack{
                //Background
                Color(red).ignoresSafeArea()
                Color(blue).ignoresSafeArea()
            }
            
            //Score
            RedScoreView(redS: self.RedS)
                .padding()
                .offset(x: -300)
            
            BlueScoreView(blueS: self.BlueS)
                .padding()
                .offset(x: 300)
            
            //Roll Point
            Rectangle()
                .foregroundColor(Color.black.opacity(0))
                .frame(width: 200, height: 200)
                .modifier(RollingPointsAnimation(number: RedP))
                .offset(x: -300, y: -200)
                .padding()
            
            Rectangle()
                .foregroundColor(Color.black.opacity(0))
                .frame(width: 200, height: 200)
                .modifier(RollingPointsAnimation(number: BlueP))
                .offset(x: 300, y: -200)
                .padding()
            
            VStack{
                Spacer()
                //Buttons
                HStack(spacing:88) {
                    //Roll
                    Button("Roll") {
                        withAnimation(Animation.easeInOut(duration: 3)){
                            RedP = CGFloat(Int.random(in: 0..<100))
                        }
                        
                    }
                        .font(.system(size: 28))
                        .padding(.horizontal,20)
                        .padding(.vertical,10)
                        .foregroundColor(.black)
                        .background(Color(.white))
                        .cornerRadius(20)
                    VStack{
                            VStack{ //Red Buttons
                                HStack{
                                    Button("+1") {self.RedS+=1}
                                        .font(.system(size: 28))
                                        .padding(.horizontal,20)
                                        .padding(.vertical,10)
                                        .foregroundColor(.black)
                                        .background(Color(.white))
                                        .cornerRadius(20)
                                    
                                    Button("-1") {self.RedS-=1}
                                        .font(.system(size: 28))
                                        .padding(.horizontal,21)
                                        .padding(.vertical,10)
                                        .foregroundColor(.black)
                                        .background(Color(.white))
                                        .cornerRadius(20)
                                }
                                
                                HStack{
                                    
                                    Button("+10") {self.RedS+=10}
                                        .font(.system(size: 28))
                                        .padding(.horizontal,11.5)
                                        .padding(.vertical,10)
                                        .foregroundColor(.black)
                                        .background(Color(.white))
                                        .cornerRadius(20)
                                    
                                    Button("-10") {self.RedS-=10}
                                        .font(.system(size: 28))
                                        .padding(.horizontal,12)
                                        .padding(.vertical,10)
                                        .foregroundColor(.black)
                                        .background(Color(.white))
                                        .cornerRadius(20)
                                    
                                }
                            
                        }
                    }
                    .padding()
                    
                    // Reset Button
                    Button("Reset") {showingConfirmation = true}
                        .font(.system(size: 30))
                        .padding(.horizontal,15)
                        .padding(.vertical,13)
                        .foregroundColor(.black)
                        .background(Color(.white))
                        .cornerRadius(20)
                        .confirmationDialog("Reset Score", isPresented: $showingConfirmation) {
                                Button("Yes") {
                                    self.BlueS = 0
                                    self.RedS = 0
                                    self.BlueP = 0
                                    self.RedP = 0
                                }
                                Button("No", role: .cancel) {}
                            }
                        message: {
                                Text("Are you sure?")
                            }
                    
                    VStack{
                        //Blue buttons
                            VStack{
                                HStack{
                                    Button("+1") {self.BlueS+=1}
                                        .font(.system(size: 28))
                                        .padding(.horizontal,20)
                                        .padding(.vertical,10)
                                        .foregroundColor(.black)
                                        .background(Color(.white))
                                        .cornerRadius(20)
                                    
                                    Button("-1") {self.BlueS-=1}
                                        .font(.system(size: 28))
                                        .padding(.horizontal,21)
                                        .padding(.vertical,10)
                                        .foregroundColor(.black)
                                        .background(Color(.white))
                                        .cornerRadius(20)
                                }
                                HStack{
                                    Button("+10") {self.BlueS+=10}
                                        .font(.system(size: 28))
                                        .padding(.horizontal,11.5)
                                        .padding(.vertical,10)
                                        .foregroundColor(.black)
                                        .background(Color(.white))
                                        .cornerRadius(20)
                                    
                                    Button("-10") {self.BlueS-=10}
                                        .font(.system(size: 28))
                                        .padding(.horizontal,12)
                                        .padding(.vertical,10)
                                        .foregroundColor(.black)
                                        .background(Color(.white))
                                        .cornerRadius(20)
                                    }
                                
                        }
                    
                    }
                    .padding()
                    //Roll
                    Button("Roll") {
                        withAnimation(Animation.easeInOut(duration: 3)){
                            BlueP = CGFloat(Int.random(in: 0..<100))
                        }
                    }
                        .font(.system(size: 28))
                        .padding(.horizontal,20)
                        .padding(.vertical,10)
                        .foregroundColor(.black)
                        .background(Color(.white))
                        .cornerRadius(20)
                }
                .padding()
            }
            
            
        }
    }
}

struct RedScoreView: View {
    var redS: Int
    
    var body: some View{
        Text("\(redS)")
            .font(.system(size: 150))
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .padding()
    }
}

struct BlueScoreView: View {
    var blueS: Int
    
    var body: some View{
        Text("\(blueS)")
            .font(.system(size: 150))
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .padding()
    }
}


//Rolling Animation
struct RollingPointsAnimation: AnimatableModifier {
    var number : CGFloat
    var animatableData: CGFloat{
        get {
            number
        }
        
        set {
            number = newValue
        }
    }
    func body(content: Content) -> some View {
        return content.overlay(
            Text("\(Int(number))")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
        )
    }
}



struct MenuView: View {
    var body: some View {
        Menu("Menu") {
            Button("1v1", action: {})
            Button("Roll", action: {})
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
