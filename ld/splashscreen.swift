import SwiftUI

struct Splashscreen: View {
    @State var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .font(.system(size: 150)) // Adjust the size as needed
                            .foregroundColor(.white)
                        Spacer()
                        Text("LoveLink")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("By: Xavier Rogers")
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.841))
                            .font(.subheadline)
                        
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct Splashscreen_Previews: PreviewProvider {
    static var previews: some View {
        Splashscreen()
    }
}

