import SwiftUI

struct ContentView: View {
    // Constants for reused colors
    let buttonTextColor = Color(UIColor.systemGray6)
    let buttonBackgroundBlue = Color(UIColor.systemBlue)
    let buttonBackgroundGreen = Color(UIColor.systemGreen)
    let iconAndTextColor = Color(UIColor.systemGray2)
    let opaqueGray = Color(UIColor.systemGray).opacity(0.3)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea() // Full-screen black background
                
                VStack {
                    // Top Bar
                    topMenuBar()
                    
                    Spacer()
                    
                    // Main Text Bubble
                    mainTextBubble()
                    
                    Spacer()
                    
                    // Bottom Bar with Buttons
                    bottomBar()
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("") // Ensure navigation title isn't overridden
        }
    }
    
    // MARK: - Top Menu Bar
    @ViewBuilder
    private func topMenuBar() -> some View {
        ZStack {
            Rectangle()
                .fill(opaqueGray)
                .frame(height: 70)
            
            HStack {
                IconButton(imageName: "line.horizontal.3", action: {
                    // Handle hamburger menu action
                })
                
                Spacer()
                
                accountButton()
            }
            .padding(.horizontal)
        }
    }
    
    private func accountButton() -> some View {
        Button(action: {
            // Handle account button action
        }) {
            HStack {
                Text("Account")
                    .foregroundColor(iconAndTextColor)
                    .font(.system(size: 22))
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(iconAndTextColor)
            }
        }
        .padding()
    }
    
    // MARK: - Main Text Bubble
    @ViewBuilder
    private func mainTextBubble() -> some View {
        ZStack {
            BubbleShape()
                .fill(Color.yellow)
                .frame(width: 270, height: 160)  // Shrink the width and expand the height slightly
            
            Text("Hey there\nYellow Jacket!")
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .font(.system(size: 32))
                .padding()
        }
    }
    
    // MARK: - Bottom Bar with Buttons
    @ViewBuilder
    private func bottomBar() -> some View {
        ZStack {
            Rectangle()
                .fill(opaqueGray)
                .frame(height: 100) // Opaque bar behind buttons

            HStack(spacing: 40) {
                // On Campus Events Button (House Icon)
                NavigationLink(destination: EventListView()) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(buttonBackgroundBlue)
                }
                
                // Off Campus Events Button (Car Icon)
                NavigationLink(destination: OffCampusEventListView()) {
                    Image(systemName: "car.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(buttonBackgroundGreen)
                }
            }
        }
        .padding(.horizontal, 40)
    }
}




// Reusable icon button
struct IconButton: View {
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color(UIColor.systemGray2))
                .padding()
        }
    }
}

// Custom speech bubble shape
struct BubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bubbleCornerRadius: CGFloat = 20 // Reduced corner radius for a more square look
        let bubbleTailSize: CGFloat = 20
        
        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: rect.width, height: rect.height - bubbleTailSize),
                            cornerSize: CGSize(width: bubbleCornerRadius, height: bubbleCornerRadius))
        
        path.move(to: CGPoint(x: bubbleTailSize, y: rect.height - bubbleTailSize))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: bubbleTailSize * 2, y: rect.height - bubbleTailSize))
        
        return path
    }
}

#Preview {
    ContentView()
}
