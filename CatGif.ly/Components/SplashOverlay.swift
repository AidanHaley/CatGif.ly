/*
 * 2021 Aidan Haley
 */

import SwiftUI

struct SplashOverlay: View {
    
    @State var showGif = false
    @State var showSplash = true
    
    var body: some View {
        ZStack {
            Color("Primary").ignoresSafeArea()
            
            GifImageView(path: "splash", type: .local)
                .opacity(showGif ? 1 : 0)
                .frame(width: 300,
                       height: 200,
                       alignment: .center)
        }
        .animation(.easeIn(duration: 0.3), value: showGif)
        .opacity(showSplash ? 1 : 0)
        .onAppear {
            //Make sure the Gif isn't displayed before it's loaded
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                showGif.toggle()
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
                showGif.toggle()
            })
            
            //Fade out view after Gif is hidden
            DispatchQueue.main.asyncAfter(deadline: .now() + 9, execute: {
                showSplash.toggle()
            })
        }
        .animation(.easeIn(duration: 0.3), value: !showSplash)
    }
}

struct SplashOverlay_Previews: PreviewProvider {
    static var previews: some View {
        SplashOverlay()
    }
}
