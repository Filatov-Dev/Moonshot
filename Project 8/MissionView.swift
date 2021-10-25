//
//  MissionView.swift
//  Project 8
//
//  Created by Юрий Филатов on 25.10.2021.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMamber {
        let role: String
        let astronaut: Astronaut
    }
    
    
    let mission : Mission
    let astronauts: [CrewMamber]
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical){
                VStack{
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth:geometry.size.width * 0.7)
                        .padding(.top)
                    Text(self.mission.description)
                        .padding()
                    ForEach(self.astronauts, id: \.role){
                        crewMamber in
                        NavigationLink(destination: AstronautView(astronaut: crewMamber.astronaut)) {
                            HStack{
                                Image(crewMamber.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule()
                                                .stroke(Color.primary, lineWidth: 1))
                                VStack(alignment: .leading) {
                                    Text(crewMamber.astronaut.name)
                                        .font(.headline)
                                    
                                    Text(crewMamber.role)
                                        .foregroundColor(.secondary)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    init(mission: Mission, astronauts: [Astronaut]){
        self.mission = mission
        
        var macthes = [CrewMamber]()
        
        for member in mission.crew{
            if let match = astronauts.first(where: { $0.id == member.name}) {
                macthes.append(CrewMamber(role: member.role, astronaut: match))
            } else {
                fatalError("Mission \(member)")
            }
        }
        self.astronauts = macthes
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions : [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
