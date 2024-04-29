//
//  AvatarEditView.swift
//  Nameory
//
//  Created by Paul Festor on 20/03/2024.
//

import SwiftUI

struct AvatarEditView: View {
    @Binding var avatar: Avatar
    
    var body: some View {
        
            
        HStack {
            Spacer()
            AvatarView(avatar: avatar)
                .frame(width: 250, height: 250)
                .clipShape(.rect(cornerRadius: 20))
            Spacer()
        }
        .padding(.vertical)
        
        Form {
            Section {
                Picker("Icon style", selection: $avatar.gender) {
                    Text("Male")
                        .tag(Gender.male)
                    Text("Female")
                        .tag(Gender.female)
                }
            }
            Section("Skin Tone") {
                CirclesColorPicker(title: "Skin tone", selection: $avatar.skinTone)
            }
            Section("Hair Color") {
                CirclesColorPicker(title: "Hair Color", selection: $avatar.hairColor)
            }
        }
        .navigationTitle("Edit event")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AvatarView: View {
    @State var avatar: Avatar
    
    var body: some View {
        if avatar.gender == .female {
            FemaleAvatarView(avatar: avatar)
        } else {
            MaleAvatarView(avatar: avatar)
        }
    }
}

fileprivate struct CirclesColorPicker<T: ColorRepresentable>: View {
    var title: String
    @Binding var selection: T

    // Define columns for LazyVGrid
    private let columns = [GridItem(.adaptive(minimum: 40))]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline)
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(Array(T.allCases).indices, id: \.self) { index in
                    let item = Array(T.allCases)[index]
                    Circle()
                        .fill(item.color)
                        .frame(width: 30, height: 30)
                        .overlay(Circle().stroke(selection == item ? Color.black : Color.clear, lineWidth: 2))
                        .onTapGesture {
                            self.selection = item
                        }
                }
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return AvatarEditView(avatar: .constant(previewer.avatar))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to generate preview with error \(error.localizedDescription)")
    }
}

protocol ColorRepresentable: Identifiable, CaseIterable, Hashable {
    var color: Color { get }
    var id: Self { get }
}

// Section - Female icons

struct FemaleAvatarView: View {
    @State var avatar: Avatar
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                
                Rectangle()
                    .fill(.blue)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                LongHairBackIcon()
                    .fill(avatar.hairColor.color)
                    .frame(width: 0.4055*geometry.size.width, height: 0.7626*geometry.size.height)
                    .offset(x: 0.055*geometry.size.width)
                
                FemaleSkinIcon()
                    .fill(avatar.skinTone.color)
                    .frame(width: 0.579*geometry.size.width, height: 0.916*geometry.size.height)
                    .offset(x: 0.06*geometry.size.width, y: 0.005*geometry.size.height)
                
                LongHairFrontIcon()
                    .fill(avatar.hairColor.color)
                    .frame(width: 0.579*geometry.size.width, height: 0.63*geometry.size.height)
                    .offset(x: 0.013*geometry.size.width, y: -0.32*geometry.size.height)
                
                FemaleBodyIcon()
                    .fill(Color(red: 101/255, green: 27/255, blue: 52/255))
                    .frame(width: 1.002*geometry.size.width, height: 0.3449*geometry.size.height)
                    .offset(x: 0.001*geometry.size.width)
                
            }
        }
    }
}

fileprivate struct FemaleBodyIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.24797*width, y: 0.01679*height))
        path.addCurve(to: CGPoint(x: 0.34133*width, y: 0.04273*height), control1: CGPoint(x: 0.28601*width, y: 0.01413*height), control2: CGPoint(x: 0.34133*width, y: 0.04273*height))
        path.addCurve(to: CGPoint(x: 0.54737*width, y: 0.21566*height), control1: CGPoint(x: 0.39821*width, y: 0.10038*height), control2: CGPoint(x: 0.49586*width, y: 0.21566*height))
        path.addCurve(to: CGPoint(x: 0.73409*width, y: 0.04273*height), control1: CGPoint(x: 0.59888*width, y: 0.21566*height), control2: CGPoint(x: 0.70297*width, y: 0.10038*height))
        path.addCurve(to: CGPoint(x: 0.79526*width, y: 0.06867*height), control1: CGPoint(x: 0.73409*width, y: 0.04273*height), control2: CGPoint(x: 0.77163*width, y: 0.05491*height))
        path.addCurve(to: CGPoint(x: 0.86081*width, y: 0.11051*height), control1: CGPoint(x: 0.8214*width, y: 0.0839*height), control2: CGPoint(x: 0.83549*width, y: 0.09342*height))
        path.addLine(to: CGPoint(x: 0.86287*width, y: 0.11191*height))
        path.addCurve(to: CGPoint(x: 0.9015*width, y: 0.15514*height), control1: CGPoint(x: 0.87914*width, y: 0.12289*height), control2: CGPoint(x: 0.8867*width, y: 0.13394*height))
        path.addCurve(to: CGPoint(x: 0.9337*width, y: 0.21566*height), control1: CGPoint(x: 0.91486*width, y: 0.17427*height), control2: CGPoint(x: 0.92322*width, y: 0.18631*height))
        path.addCurve(to: CGPoint(x: 0.96589*width, y: 0.32806*height), control1: CGPoint(x: 0.94797*width, y: 0.25563*height), control2: CGPoint(x: 0.95614*width, y: 0.27927*height))
        path.addCurve(to: CGPoint(x: 0.98521*width, y: 0.53558*height), control1: CGPoint(x: 0.9806*width, y: 0.40167*height), control2: CGPoint(x: 0.97929*width, y: 0.45357*height))
        path.addCurve(to: CGPoint(x: 0.99808*width, y: 0.82955*height), control1: CGPoint(x: 0.99339*width, y: 0.64906*height), control2: CGPoint(x: 0.9954*width, y: 0.71418*height))
        path.addCurve(to: CGPoint(x: 0.99808*width, y: height), control1: CGPoint(x: 1.00114*width, y: 0.96098*height), control2: CGPoint(x: 0.99808*width, y: height))
        path.addLine(to: CGPoint(x: 0.84033*width, y: height))
        path.addLine(to: CGPoint(x: 0.15783*width, y: height))
        path.addLine(to: CGPoint(x: -0.00958*width, y: height))
        path.addLine(to: CGPoint(x: -0.00958*width, y: 0.96789*height))
        path.addCurve(to: CGPoint(x: 0.00329*width, y: 0.67392*height), control1: CGPoint(x: -0.00958*width, y: 0.96789*height), control2: CGPoint(x: -0.00425*width, y: 0.78773*height))
        path.addCurve(to: CGPoint(x: 0.02583*width, y: 0.41453*height), control1: CGPoint(x: 0.01008*width, y: 0.57151*height), control2: CGPoint(x: 0.01332*width, y: 0.51297*height))
        path.addCurve(to: CGPoint(x: 0.05802*width, y: 0.21566*height), control1: CGPoint(x: 0.03602*width, y: 0.33438*height), control2: CGPoint(x: 0.03895*width, y: 0.2831*height))
        path.addCurve(to: CGPoint(x: 0.10953*width, y: 0.09461*height), control1: CGPoint(x: 0.07419*width, y: 0.15849*height), control2: CGPoint(x: 0.08625*width, y: 0.12986*height))
        path.addCurve(to: CGPoint(x: 0.16426*width, y: 0.04273*height), control1: CGPoint(x: 0.12928*width, y: 0.06472*height), control2: CGPoint(x: 0.14239*width, y: 0.05863*height))
        path.addCurve(to: CGPoint(x: 0.2475*width, y: 0.01683*height), control1: CGPoint(x: 0.19484*width, y: 0.02052*height), control2: CGPoint(x: 0.21594*width, y: 0.01904*height))
        path.addLine(to: CGPoint(x: 0.24797*width, y: 0.01679*height))
        path.closeSubpath()
        return path
    }
}

fileprivate struct FemaleSkinIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.14071*width, y: 0.26934*height))
        path.addCurve(to: CGPoint(x: 0.15752*width, y: 0.34915*height), control1: CGPoint(x: 0.14071*width, y: 0.29716*height), control2: CGPoint(x: 0.14777*width, y: 0.32398*height))
        path.addCurve(to: CGPoint(x: 0.20796*width, y: 0.42231*height), control1: CGPoint(x: 0.17297*width, y: 0.38906*height), control2: CGPoint(x: 0.1887*width, y: 0.40024*height))
        path.addCurve(to: CGPoint(x: 0.29789*width, y: 0.48696*height), control1: CGPoint(x: 0.23947*width, y: 0.45037*height), control2: CGPoint(x: 0.24637*width, y: 0.46202*height))
        path.addCurve(to: CGPoint(x: 0.30883*width, y: 0.49215*height), control1: CGPoint(x: 0.30133*width, y: 0.48863*height), control2: CGPoint(x: 0.30497*width, y: 0.49035*height))
        path.addCurve(to: CGPoint(x: 0.46014*width, y: 0.53205*height), control1: CGPoint(x: 0.35518*width, y: 0.51369*height), control2: CGPoint(x: 0.40311*width, y: 0.53205*height))
        path.addCurve(to: CGPoint(x: 0.61145*width, y: 0.49215*height), control1: CGPoint(x: 0.51717*width, y: 0.53205*height), control2: CGPoint(x: 0.56511*width, y: 0.51369*height))
        path.addCurve(to: CGPoint(x: 0.61838*width, y: 0.48882*height), control1: CGPoint(x: 0.61381*width, y: 0.49105*height), control2: CGPoint(x: 0.61611*width, y: 0.48995*height))
        path.addCurve(to: CGPoint(x: 0.69551*width, y: 0.43229*height), control1: CGPoint(x: 0.64919*width, y: 0.47355*height), control2: CGPoint(x: 0.67229*width, y: 0.45546*height))
        path.addCurve(to: CGPoint(x: 0.76276*width, y: 0.3558*height), control1: CGPoint(x: 0.7184*width, y: 0.40946*height), control2: CGPoint(x: 0.75023*width, y: 0.38414*height))
        path.addCurve(to: CGPoint(x: 0.76808*width, y: 0.3425*height), control1: CGPoint(x: 0.76473*width, y: 0.35135*height), control2: CGPoint(x: 0.7665*width, y: 0.34692*height))
        path.addCurve(to: CGPoint(x: 0.77957*width, y: 0.26934*height), control1: CGPoint(x: 0.77644*width, y: 0.31911*height), control2: CGPoint(x: 0.77957*width, y: 0.29586*height))
        path.addCurve(to: CGPoint(x: 0.77867*width, y: 0.24939*height), control1: CGPoint(x: 0.77957*width, y: 0.26263*height), control2: CGPoint(x: 0.77927*width, y: 0.25597*height))
        path.addCurve(to: CGPoint(x: 0.46014*width, y: 0.00662*height), control1: CGPoint(x: 0.76627*width, y: 0.11361*height), control2: CGPoint(x: 0.6284*width, y: 0.00662*height))
        path.addCurve(to: CGPoint(x: 0.14071*width, y: 0.26934*height), control1: CGPoint(x: 0.28372*width, y: 0.00662*height), control2: CGPoint(x: 0.14071*width, y: 0.12425*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.46014*width, y: 0.53205*height))
        path.addCurve(to: CGPoint(x: 0.61145*width, y: 0.49215*height), control1: CGPoint(x: 0.51717*width, y: 0.53205*height), control2: CGPoint(x: 0.56511*width, y: 0.51369*height))
        path.addCurve(to: CGPoint(x: 0.61838*width, y: 0.48882*height), control1: CGPoint(x: 0.61381*width, y: 0.49105*height), control2: CGPoint(x: 0.61611*width, y: 0.48995*height))
        path.addCurve(to: CGPoint(x: 0.61838*width, y: 0.60189*height), control1: CGPoint(x: 0.61838*width, y: 0.48882*height), control2: CGPoint(x: 0.57954*width, y: 0.56423*height))
        path.addCurve(to: CGPoint(x: 0.65068*width, y: 0.62517*height), control1: CGPoint(x: 0.62874*width, y: 0.61193*height), control2: CGPoint(x: 0.65068*width, y: 0.62517*height))
        path.addLine(to: CGPoint(x: 0.76276*width, y: 0.63182*height))
        path.addLine(to: CGPoint(x: 0.99814*width, y: 0.6551*height))
        path.addLine(to: CGPoint(x: 0.85243*width, y: 0.84133*height))
        path.addLine(to: CGPoint(x: 0.57783*width, y: 0.98432*height))
        path.addLine(to: CGPoint(x: 0.38889*width, y: height))
        path.addLine(to: CGPoint(x: 0.24718*width, y: 0.93444*height))
        path.addLine(to: CGPoint(x: 0.02302*width, y: 0.72161*height))
        path.addLine(to: CGPoint(x: 0.01181*width, y: 0.63515*height))
        path.addLine(to: CGPoint(x: 0.1295*width, y: 0.63182*height))
        path.addLine(to: CGPoint(x: 0.23598*width, y: 0.62517*height))
        path.addCurve(to: CGPoint(x: 0.28641*width, y: 0.60189*height), control1: CGPoint(x: 0.23598*width, y: 0.62517*height), control2: CGPoint(x: 0.27163*width, y: 0.61382*height))
        path.addCurve(to: CGPoint(x: 0.30323*width, y: 0.53871*height), control1: CGPoint(x: 0.31135*width, y: 0.58176*height), control2: CGPoint(x: 0.30323*width, y: 0.53871*height))
        path.addLine(to: CGPoint(x: 0.29789*width, y: 0.48696*height))
        path.addCurve(to: CGPoint(x: 0.30883*width, y: 0.49215*height), control1: CGPoint(x: 0.30133*width, y: 0.48863*height), control2: CGPoint(x: 0.30497*width, y: 0.49035*height))
        path.addCurve(to: CGPoint(x: 0.46014*width, y: 0.53205*height), control1: CGPoint(x: 0.35518*width, y: 0.51369*height), control2: CGPoint(x: 0.40311*width, y: 0.53205*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.77957*width, y: 0.26934*height))
        path.addCurve(to: CGPoint(x: 0.77867*width, y: 0.24939*height), control1: CGPoint(x: 0.77957*width, y: 0.26263*height), control2: CGPoint(x: 0.77927*width, y: 0.25597*height))
        path.addCurve(to: CGPoint(x: 0.80199*width, y: 0.24273*height), control1: CGPoint(x: 0.77867*width, y: 0.24939*height), control2: CGPoint(x: 0.79189*width, y: 0.24264*height))
        path.addCurve(to: CGPoint(x: 0.82441*width, y: 0.24939*height), control1: CGPoint(x: 0.81178*width, y: 0.24283*height), control2: CGPoint(x: 0.8188*width, y: 0.24409*height))
        path.addCurve(to: CGPoint(x: 0.83001*width, y: 0.27266*height), control1: CGPoint(x: 0.83001*width, y: 0.25468*height), control2: CGPoint(x: 0.83187*width, y: 0.26355*height))
        path.addCurve(to: CGPoint(x: 0.80199*width, y: 0.30259*height), control1: CGPoint(x: 0.82731*width, y: 0.28594*height), control2: CGPoint(x: 0.81169*width, y: 0.29053*height))
        path.addCurve(to: CGPoint(x: 0.77957*width, y: 0.33585*height), control1: CGPoint(x: 0.79184*width, y: 0.31522*height), control2: CGPoint(x: 0.79496*width, y: 0.32525*height))
        path.addCurve(to: CGPoint(x: 0.76808*width, y: 0.3425*height), control1: CGPoint(x: 0.77548*width, y: 0.33867*height), control2: CGPoint(x: 0.76808*width, y: 0.3425*height))
        path.addCurve(to: CGPoint(x: 0.77957*width, y: 0.26934*height), control1: CGPoint(x: 0.77644*width, y: 0.31911*height), control2: CGPoint(x: 0.77957*width, y: 0.29586*height))
        path.closeSubpath()
        return path
    }
}

fileprivate struct LongHairFrontIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.62186*width, y: 0.17938*height))
        path.addCurve(to: CGPoint(x: 0.63212*width, y: 0.1427*height), control1: CGPoint(x: 0.62186*width, y: 0.16462*height), control2: CGPoint(x: 0.63212*width, y: 0.1427*height))
        path.addLine(to: CGPoint(x: 0.59108*width, y: 0.1748*height))
        path.addCurve(to: CGPoint(x: 0.56031*width, y: 0.18855*height), control1: CGPoint(x: 0.59108*width, y: 0.1748*height), control2: CGPoint(x: 0.57332*width, y: 0.18555*height))
        path.addCurve(to: CGPoint(x: 0.51927*width, y: 0.18855*height), control1: CGPoint(x: 0.54479*width, y: 0.19213*height), control2: CGPoint(x: 0.51927*width, y: 0.18855*height))
        path.addCurve(to: CGPoint(x: 0.47824*width, y: 0.17938*height), control1: CGPoint(x: 0.51927*width, y: 0.18855*height), control2: CGPoint(x: 0.49461*width, y: 0.17739*height))
        path.addCurve(to: CGPoint(x: 0.45259*width, y: 0.18397*height), control1: CGPoint(x: 0.46755*width, y: 0.18069*height), control2: CGPoint(x: 0.45259*width, y: 0.18397*height))
        path.addCurve(to: CGPoint(x: 0.41669*width, y: 0.20231*height), control1: CGPoint(x: 0.45259*width, y: 0.18397*height), control2: CGPoint(x: 0.42864*width, y: 0.19329*height))
        path.addCurve(to: CGPoint(x: 0.39104*width, y: 0.25275*height), control1: CGPoint(x: 0.40258*width, y: 0.21296*height), control2: CGPoint(x: 0.40373*width, y: 0.24075*height))
        path.addCurve(to: CGPoint(x: 0.35001*width, y: 0.28026*height), control1: CGPoint(x: 0.37728*width, y: 0.26576*height), control2: CGPoint(x: 0.36179*width, y: 0.26578*height))
        path.addCurve(to: CGPoint(x: 0.33462*width, y: 0.32611*height), control1: CGPoint(x: 0.33563*width, y: 0.29794*height), control2: CGPoint(x: 0.34567*width, y: 0.30661*height))
        path.addCurve(to: CGPoint(x: 0.30385*width, y: 0.37196*height), control1: CGPoint(x: 0.32317*width, y: 0.34632*height), control2: CGPoint(x: 0.30796*width, y: 0.34961*height))
        path.addCurve(to: CGPoint(x: 0.29872*width, y: 0.43615*height), control1: CGPoint(x: 0.29962*width, y: 0.39493*height), control2: CGPoint(x: 0.30487*width, y: 0.41353*height))
        path.addCurve(to: CGPoint(x: 0.2782*width, y: 0.47742*height), control1: CGPoint(x: 0.29406*width, y: 0.45329*height), control2: CGPoint(x: 0.28532*width, y: 0.46097*height))
        path.addCurve(to: CGPoint(x: 0.26281*width, y: 0.51869*height), control1: CGPoint(x: 0.27135*width, y: 0.49327*height), control2: CGPoint(x: 0.26644*width, y: 0.50201*height))
        path.addCurve(to: CGPoint(x: 0.2782*width, y: 0.58288*height), control1: CGPoint(x: 0.25746*width, y: 0.5433*height), control2: CGPoint(x: 0.27575*width, y: 0.55791*height))
        path.addCurve(to: CGPoint(x: 0.31924*width, y: 0.73878*height), control1: CGPoint(x: 0.28447*width, y: 0.64662*height), control2: CGPoint(x: 0.31924*width, y: 0.73878*height))
        path.addLine(to: CGPoint(x: 0.2423*width, y: 0.97721*height))
        path.addLine(to: CGPoint(x: 0.12945*width, y: 0.98179*height))
        path.addCurve(to: CGPoint(x: 0.05252*width, y: 0.96804*height), control1: CGPoint(x: 0.12945*width, y: 0.98179*height), control2: CGPoint(x: 0.07888*width, y: 0.982*height))
        path.addCurve(to: CGPoint(x: 0.032*width, y: 0.95428*height), control1: CGPoint(x: 0.0439*width, y: 0.96347*height), control2: CGPoint(x: 0.03908*width, y: 0.96061*height))
        path.addCurve(to: CGPoint(x: 0.01661*width, y: 0.93594*height), control1: CGPoint(x: 0.02492*width, y: 0.94795*height), control2: CGPoint(x: 0.0205*width, y: 0.94419*height))
        path.addCurve(to: CGPoint(x: 0.01661*width, y: 0.89926*height), control1: CGPoint(x: 0.01039*width, y: 0.92274*height), control2: CGPoint(x: 0.01661*width, y: 0.91358*height))
        path.addCurve(to: CGPoint(x: 0.01661*width, y: 0.86716*height), control1: CGPoint(x: 0.01661*width, y: 0.88672*height), control2: CGPoint(x: 0.01436*width, y: 0.87953*height))
        path.addCurve(to: CGPoint(x: 0.032*width, y: 0.83048*height), control1: CGPoint(x: 0.01936*width, y: 0.85206*height), control2: CGPoint(x: 0.02948*width, y: 0.84561*height))
        path.addCurve(to: CGPoint(x: 0.032*width, y: 0.80297*height), control1: CGPoint(x: 0.03377*width, y: 0.81985*height), control2: CGPoint(x: 0.032*width, y: 0.81371*height))
        path.addLine(to: CGPoint(x: 0.032*width, y: 0.77087*height))
        path.addCurve(to: CGPoint(x: 0.032*width, y: 0.73878*height), control1: CGPoint(x: 0.032*width, y: 0.77087*height), control2: CGPoint(x: 0.02866*width, y: 0.75095*height))
        path.addCurve(to: CGPoint(x: 0.05252*width, y: 0.70668*height), control1: CGPoint(x: 0.03585*width, y: 0.72476*height), control2: CGPoint(x: 0.05252*width, y: 0.70668*height))
        path.addCurve(to: CGPoint(x: 0.09355*width, y: 0.67458*height), control1: CGPoint(x: 0.05252*width, y: 0.70668*height), control2: CGPoint(x: 0.08381*width, y: 0.69023*height))
        path.addCurve(to: CGPoint(x: 0.10381*width, y: 0.61956*height), control1: CGPoint(x: 0.10495*width, y: 0.65627*height), control2: CGPoint(x: 0.10381*width, y: 0.61956*height))
        path.addLine(to: CGPoint(x: 0.12433*width, y: 0.57371*height))
        path.addLine(to: CGPoint(x: 0.12433*width, y: 0.50952*height))
        path.addCurve(to: CGPoint(x: 0.13971*width, y: 0.4545*height), control1: CGPoint(x: 0.12433*width, y: 0.50952*height), control2: CGPoint(x: 0.13749*width, y: 0.47769*height))
        path.addCurve(to: CGPoint(x: 0.13971*width, y: 0.39489*height), control1: CGPoint(x: 0.14179*width, y: 0.43279*height), control2: CGPoint(x: 0.13372*width, y: 0.416*height))
        path.addCurve(to: CGPoint(x: 0.18588*width, y: 0.30777*height), control1: CGPoint(x: 0.15096*width, y: 0.35523*height), control2: CGPoint(x: 0.18588*width, y: 0.30777*height))
        path.addCurve(to: CGPoint(x: 0.21665*width, y: 0.21607*height), control1: CGPoint(x: 0.18588*width, y: 0.30777*height), control2: CGPoint(x: 0.19684*width, y: 0.24657*height))
        path.addCurve(to: CGPoint(x: 0.28846*width, y: 0.15646*height), control1: CGPoint(x: 0.23396*width, y: 0.18942*height), control2: CGPoint(x: 0.28846*width, y: 0.15646*height))
        path.addCurve(to: CGPoint(x: 0.35514*width, y: 0.07393*height), control1: CGPoint(x: 0.28846*width, y: 0.15646*height), control2: CGPoint(x: 0.32006*width, y: 0.09971*height))
        path.addCurve(to: CGPoint(x: 0.42695*width, y: 0.03266*height), control1: CGPoint(x: 0.38089*width, y: 0.055*height), control2: CGPoint(x: 0.39701*width, y: 0.04577*height))
        path.addCurve(to: CGPoint(x: 0.47824*width, y: 0.01432*height), control1: CGPoint(x: 0.44632*width, y: 0.02418*height), control2: CGPoint(x: 0.45695*width, y: 0.01743*height))
        path.addCurve(to: CGPoint(x: 0.51927*width, y: 0.01432*height), control1: CGPoint(x: 0.49405*width, y: 0.01201*height), control2: CGPoint(x: 0.50363*width, y: 0.01121*height))
        path.addCurve(to: CGPoint(x: 0.56031*width, y: 0.03266*height), control1: CGPoint(x: 0.53676*width, y: 0.01779*height), control2: CGPoint(x: 0.56031*width, y: 0.03266*height))
        path.addCurve(to: CGPoint(x: 0.57056*width, y: 0.02349*height), control1: CGPoint(x: 0.56031*width, y: 0.03266*height), control2: CGPoint(x: 0.56578*width, y: 0.02621*height))
        path.addCurve(to: CGPoint(x: 0.60647*width, y: 0.02349*height), control1: CGPoint(x: 0.58239*width, y: 0.01676*height), control2: CGPoint(x: 0.59248*width, y: 0.02262*height))
        path.addCurve(to: CGPoint(x: 0.66289*width, y: 0.03266*height), control1: CGPoint(x: 0.62881*width, y: 0.02487*height), control2: CGPoint(x: 0.64162*width, y: 0.0264*height))
        path.addCurve(to: CGPoint(x: 0.75522*width, y: 0.08768*height), control1: CGPoint(x: 0.70405*width, y: 0.04477*height), control2: CGPoint(x: 0.72263*width, y: 0.06215*height))
        path.addCurve(to: CGPoint(x: 0.82702*width, y: 0.1748*height), control1: CGPoint(x: 0.79263*width, y: 0.117*height), control2: CGPoint(x: 0.79893*width, y: 0.13809*height))
        path.addCurve(to: CGPoint(x: 0.89883*width, y: 0.27567*height), control1: CGPoint(x: 0.85537*width, y: 0.21183*height), control2: CGPoint(x: 0.88143*width, y: 0.23358*height))
        path.addCurve(to: CGPoint(x: 0.91422*width, y: 0.38572*height), control1: CGPoint(x: 0.9145*width, y: 0.31357*height), control2: CGPoint(x: 0.90718*width, y: 0.34581*height))
        path.addCurve(to: CGPoint(x: 0.93474*width, y: 0.47742*height), control1: CGPoint(x: 0.92111*width, y: 0.42479*height), control2: CGPoint(x: 0.93257*width, y: 0.43791*height))
        path.addCurve(to: CGPoint(x: 0.91422*width, y: 0.60122*height), control1: CGPoint(x: 0.93729*width, y: 0.52392*height), control2: CGPoint(x: 0.91795*width, y: 0.55478*height))
        path.addCurve(to: CGPoint(x: 0.91422*width, y: 0.72044*height), control1: CGPoint(x: 0.9103*width, y: 0.64997*height), control2: CGPoint(x: 0.92158*width, y: 0.67201*height))
        path.addCurve(to: CGPoint(x: 0.88345*width, y: 0.83048*height), control1: CGPoint(x: 0.9077*width, y: 0.76335*height), control2: CGPoint(x: 0.88319*width, y: 0.78717*height))
        path.addCurve(to: CGPoint(x: 0.91422*width, y: 0.93594*height), control1: CGPoint(x: 0.88369*width, y: 0.87201*height), control2: CGPoint(x: 0.89258*width, y: 0.89918*height))
        path.addCurve(to: CGPoint(x: 0.98603*width, y: 1.00013*height), control1: CGPoint(x: 0.93269*width, y: 0.96731*height), control2: CGPoint(x: 0.98603*width, y: 1.00013*height))
        path.addLine(to: CGPoint(x: 0.71931*width, y: 0.96804*height))
        path.addLine(to: CGPoint(x: 0.70905*width, y: 0.7938*height))
        path.addLine(to: CGPoint(x: 0.89883*width, y: 0.47742*height))
        path.addLine(to: CGPoint(x: 0.87319*width, y: 0.41323*height))
        path.addCurve(to: CGPoint(x: 0.84241*width, y: 0.43615*height), control1: CGPoint(x: 0.87319*width, y: 0.41323*height), control2: CGPoint(x: 0.85348*width, y: 0.42627*height))
        path.addCurve(to: CGPoint(x: 0.80138*width, y: 0.48659*height), control1: CGPoint(x: 0.82314*width, y: 0.45337*height), control2: CGPoint(x: 0.80138*width, y: 0.48659*height))
        path.addLine(to: CGPoint(x: 0.80138*width, y: 0.40406*height))
        path.addCurve(to: CGPoint(x: 0.80138*width, y: 0.36279*height), control1: CGPoint(x: 0.80138*width, y: 0.38794*height), control2: CGPoint(x: 0.80612*width, y: 0.37834*height))
        path.addCurve(to: CGPoint(x: 0.7706*width, y: 0.32153*height), control1: CGPoint(x: 0.79568*width, y: 0.34411*height), control2: CGPoint(x: 0.786*width, y: 0.33516*height))
        path.addCurve(to: CGPoint(x: 0.7347*width, y: 0.2986*height), control1: CGPoint(x: 0.75836*width, y: 0.31069*height), control2: CGPoint(x: 0.7347*width, y: 0.2986*height))
        path.addCurve(to: CGPoint(x: 0.67828*width, y: 0.23899*height), control1: CGPoint(x: 0.7347*width, y: 0.2986*height), control2: CGPoint(x: 0.70123*width, y: 0.258*height))
        path.addCurve(to: CGPoint(x: 0.63212*width, y: 0.21607*height), control1: CGPoint(x: 0.66165*width, y: 0.22522*height), control2: CGPoint(x: 0.64242*width, y: 0.23411*height))
        path.addCurve(to: CGPoint(x: 0.62186*width, y: 0.17938*height), control1: CGPoint(x: 0.62461*width, y: 0.20291*height), control2: CGPoint(x: 0.62186*width, y: 0.19415*height))
        path.closeSubpath()
        return path
    }
}

fileprivate struct LongHairBackIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addEllipse(in: CGRect(x: 0, y: 0, width: 0.96551*width, height: 0.9904*height))
        return path
    }
}

// Section - Male icons

struct MaleAvatarView: View {
    @State var avatar: Avatar

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                
                Rectangle()
                    .fill(.blue)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                MaleSkinIcon()
                    .fill(avatar.skinTone.color)
                    .frame(width: 0.44*geometry.size.width, height: 0.7029*geometry.size.height)
                    .offset(x: 0.007*geometry.size.width, y: -0.14*geometry.size.height)
                
                SidePartHairIcon()
                    .fill(avatar.hairColor.color)
                    .frame(width: 0.465*geometry.size.width, height: 0.3559*geometry.size.height)
                    .offset(x: 0.014*geometry.size.width, y: -0.54*geometry.size.height)
                
                MaleBodyIcon()
                    .fill(Color(red: 101/255, green: 27/255, blue: 52/255))
                    .frame(width: 1.006*geometry.size.width, height: 0.3618*geometry.size.height)
                    .offset(x: 0.001*geometry.size.width)
                
                
            }
        }
    }
}


fileprivate struct MaleBodyIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.45918*width, y: 0.40359*height))
        path.addCurve(to: CGPoint(x: 0.4922*width, y: 0.46078*height), control1: CGPoint(x: 0.47213*width, y: 0.42568*height), control2: CGPoint(x: 0.48108*width, y: 0.43223*height))
        path.addCurve(to: CGPoint(x: 0.51921*width, y: 0.57516*height), control1: CGPoint(x: 0.50638*width, y: 0.49723*height), control2: CGPoint(x: 0.51921*width, y: 0.57516*height))
        path.addCurve(to: CGPoint(x: 0.54322*width, y: 0.49346*height), control1: CGPoint(x: 0.51921*width, y: 0.57516*height), control2: CGPoint(x: 0.53308*width, y: 0.5236*height))
        path.addCurve(to: CGPoint(x: 0.61525*width, y: 0.33823*height), control1: CGPoint(x: 0.56744*width, y: 0.42143*height), control2: CGPoint(x: 0.59416*width, y: 0.41724*height))
        path.addCurve(to: CGPoint(x: 0.63625*width, y: 0.18301*height), control1: CGPoint(x: 0.62973*width, y: 0.28397*height), control2: CGPoint(x: 0.63625*width, y: 0.18301*height))
        path.addLine(to: CGPoint(x: 0.64226*width, y: 0.01144*height))
        path.addLine(to: CGPoint(x: 0.64526*width, y: 0.01144*height))
        path.addLine(to: CGPoint(x: 0.66026*width, y: 0.10948*height))
        path.addLine(to: CGPoint(x: 0.93337*width, y: 0.49346*height))
        path.addCurve(to: CGPoint(x: 0.97539*width, y: 0.54248*height), control1: CGPoint(x: 0.93337*width, y: 0.49346*height), control2: CGPoint(x: 0.96163*width, y: 0.51152*height))
        path.addCurve(to: CGPoint(x: 0.9934*width, y: 0.59967*height), control1: CGPoint(x: 0.98372*width, y: 0.56122*height), control2: CGPoint(x: 0.9934*width, y: 0.59967*height))
        path.addLine(to: CGPoint(x: 0.9934*width, y: 1.01634*height))
        path.addLine(to: CGPoint(x: -0.02101*width, y: 1.01634*height))
        path.addLine(to: CGPoint(x: -0.02101*width, y: 0.86111*height))
        path.addCurve(to: CGPoint(x: 0.01801*width, y: 0.58333*height), control1: CGPoint(x: -0.02101*width, y: 0.74497*height), control2: CGPoint(x: -0.00947*width, y: 0.67217*height))
        path.addCurve(to: CGPoint(x: 0.07803*width, y: 0.46078*height), control1: CGPoint(x: 0.03688*width, y: 0.52232*height), control2: CGPoint(x: 0.05346*width, y: 0.50426*height))
        path.addCurve(to: CGPoint(x: 0.21008*width, y: 0.28921*height), control1: CGPoint(x: 0.12594*width, y: 0.376*height), control2: CGPoint(x: 0.21008*width, y: 0.28921*height))
        path.addLine(to: CGPoint(x: 0.34514*width, y: 0.10131*height))
        path.addLine(to: CGPoint(x: 0.37215*width, y: 0.01144*height))
        path.addCurve(to: CGPoint(x: 0.37215*width, y: 0.10131*height), control1: CGPoint(x: 0.37215*width, y: 0.01144*height), control2: CGPoint(x: 0.37189*width, y: 0.06878*height))
        path.addCurve(to: CGPoint(x: 0.38115*width, y: 0.20752*height), control1: CGPoint(x: 0.37252*width, y: 0.14873*height), control2: CGPoint(x: 0.37364*width, y: 0.16472*height))
        path.addCurve(to: CGPoint(x: 0.40516*width, y: 0.31373*height), control1: CGPoint(x: 0.38887*width, y: 0.25145*height), control2: CGPoint(x: 0.39299*width, y: 0.27804*height))
        path.addCurve(to: CGPoint(x: 0.45918*width, y: 0.40359*height), control1: CGPoint(x: 0.42199*width, y: 0.36304*height), control2: CGPoint(x: 0.43823*width, y: 0.36786*height))
        path.closeSubpath()
        return path
    }
}

fileprivate struct MaleSkinIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.93417*width, y: 0.31649*height))
        path.addCurve(to: CGPoint(x: 0.93043*width, y: 0.35791*height), control1: CGPoint(x: 0.93417*width, y: 0.33054*height), control2: CGPoint(x: 0.9329*width, y: 0.34436*height))
        path.addCurve(to: CGPoint(x: 0.96219*width, y: 0.3372*height), control1: CGPoint(x: 0.93043*width, y: 0.35791*height), control2: CGPoint(x: 0.94584*width, y: 0.34227*height))
        path.addCurve(to: CGPoint(x: 0.9667*width, y: 0.33569*height), control1: CGPoint(x: 0.96379*width, y: 0.3367*height), control2: CGPoint(x: 0.96528*width, y: 0.33619*height))
        path.addCurve(to: CGPoint(x: 0.98319*width, y: 0.33306*height), control1: CGPoint(x: 0.97204*width, y: 0.33384*height), control2: CGPoint(x: 0.97648*width, y: 0.3323*height))
        path.addCurve(to: CGPoint(x: 0.99124*width, y: 0.3479*height), control1: CGPoint(x: 0.99428*width, y: 0.3343*height), control2: CGPoint(x: 0.99283*width, y: 0.34079*height))
        path.addCurve(to: CGPoint(x: 0.9902*width, y: 0.35791*height), control1: CGPoint(x: 0.99048*width, y: 0.35126*height), control2: CGPoint(x: 0.9897*width, y: 0.35476*height))
        path.addCurve(to: CGPoint(x: 0.98319*width, y: 0.41591*height), control1: CGPoint(x: 0.9902*width, y: 0.35791*height), control2: CGPoint(x: 0.99002*width, y: 0.39356*height))
        path.addCurve(to: CGPoint(x: 0.96219*width, y: 0.46147*height), control1: CGPoint(x: 0.97765*width, y: 0.43406*height), control2: CGPoint(x: 0.97366*width, y: 0.44432*height))
        path.addCurve(to: CGPoint(x: 0.93417*width, y: 0.49461*height), control1: CGPoint(x: 0.95318*width, y: 0.47493*height), control2: CGPoint(x: 0.93417*width, y: 0.49461*height))
        path.addLine(to: CGPoint(x: 0.92965*width, y: 0.49457*height))
        path.addCurve(to: CGPoint(x: 0.80812*width, y: 0.66948*height), control1: CGPoint(x: 0.91596*width, y: 0.56281*height), control2: CGPoint(x: 0.87195*width, y: 0.62371*height))
        path.addLine(to: CGPoint(x: 0.80812*width, y: 0.77216*height))
        path.addLine(to: CGPoint(x: 0.85014*width, y: 0.81359*height))
        path.addLine(to: CGPoint(x: 0.7591*width, y: height))
        path.addLine(to: CGPoint(x: 0.2479*width, y: height))
        path.addLine(to: CGPoint(x: 0.18079*width, y: 0.77216*height))
        path.addLine(to: CGPoint(x: 0.18079*width, y: 0.62303*height))
        path.addCurve(to: CGPoint(x: 0.11087*width, y: 0.48634*height), control1: CGPoint(x: 0.14377*width, y: 0.58326*height), control2: CGPoint(x: 0.1191*width, y: 0.53668*height))
        path.addLine(to: CGPoint(x: 0.11023*width, y: 0.48633*height))
        path.addCurve(to: CGPoint(x: 0.08683*width, y: 0.48633*height), control1: CGPoint(x: 0.11023*width, y: 0.48633*height), control2: CGPoint(x: 0.09511*width, y: 0.48862*height))
        path.addCurve(to: CGPoint(x: 0.07676*width, y: 0.47493*height), control1: CGPoint(x: 0.07868*width, y: 0.48407*height), control2: CGPoint(x: 0.07777*width, y: 0.47973*height))
        path.addCurve(to: CGPoint(x: 0.07283*width, y: 0.46562*height), control1: CGPoint(x: 0.07612*width, y: 0.47187*height), control2: CGPoint(x: 0.07543*width, y: 0.46863*height))
        path.addCurve(to: CGPoint(x: 0.05567*width, y: 0.45165*height), control1: CGPoint(x: 0.06767*width, y: 0.45965*height), control2: CGPoint(x: 0.06164*width, y: 0.45563*height))
        path.addCurve(to: CGPoint(x: 0.03782*width, y: 0.43662*height), control1: CGPoint(x: 0.04926*width, y: 0.44738*height), control2: CGPoint(x: 0.04292*width, y: 0.44316*height))
        path.addCurve(to: CGPoint(x: 0.02484*width, y: 0.39808*height), control1: CGPoint(x: 0.02671*width, y: 0.42239*height), control2: CGPoint(x: 0.02589*width, y: 0.41175*height))
        path.addCurve(to: CGPoint(x: 0.02381*width, y: 0.38691*height), control1: CGPoint(x: 0.02457*width, y: 0.39459*height), control2: CGPoint(x: 0.02428*width, y: 0.39091*height))
        path.addCurve(to: CGPoint(x: 0.02306*width, y: 0.38094*height), control1: CGPoint(x: 0.02356*width, y: 0.3848*height), control2: CGPoint(x: 0.0233*width, y: 0.38282*height))
        path.addLine(to: CGPoint(x: 0.02306*width, y: 0.38094*height))
        path.addCurve(to: CGPoint(x: 0.02381*width, y: 0.34963*height), control1: CGPoint(x: 0.02161*width, y: 0.36983*height), control2: CGPoint(x: 0.02058*width, y: 0.36193*height))
        path.addCurve(to: CGPoint(x: 0.02464*width, y: 0.33931*height), control1: CGPoint(x: 0.0247*width, y: 0.34625*height), control2: CGPoint(x: 0.02467*width, y: 0.34272*height))
        path.addCurve(to: CGPoint(x: 0.03782*width, y: 0.32063*height), control1: CGPoint(x: 0.02457*width, y: 0.331*height), control2: CGPoint(x: 0.02451*width, y: 0.32343*height))
        path.addCurve(to: CGPoint(x: 0.05636*width, y: 0.32038*height), control1: CGPoint(x: 0.04473*width, y: 0.31917*height), control2: CGPoint(x: 0.04961*width, y: 0.31968*height))
        path.addLine(to: CGPoint(x: 0.05637*width, y: 0.32038*height))
        path.addLine(to: CGPoint(x: 0.0564*width, y: 0.32038*height))
        path.addCurve(to: CGPoint(x: 0.05882*width, y: 0.32063*height), control1: CGPoint(x: 0.05718*width, y: 0.32046*height), control2: CGPoint(x: 0.05799*width, y: 0.32055*height))
        path.addCurve(to: CGPoint(x: 0.11023*width, y: 0.34963*height), control1: CGPoint(x: 0.08618*width, y: 0.32335*height), control2: CGPoint(x: 0.11023*width, y: 0.34963*height))
        path.addCurve(to: CGPoint(x: 0.10784*width, y: 0.31649*height), control1: CGPoint(x: 0.10865*width, y: 0.33874*height), control2: CGPoint(x: 0.10784*width, y: 0.32768*height))
        path.addCurve(to: CGPoint(x: 0.52101*width, y: 0.00994*height), control1: CGPoint(x: 0.10784*width, y: 0.14719*height), control2: CGPoint(x: 0.29282*width, y: 0.00994*height))
        path.addCurve(to: CGPoint(x: 0.93417*width, y: 0.31649*height), control1: CGPoint(x: 0.74919*width, y: 0.00994*height), control2: CGPoint(x: 0.93417*width, y: 0.14719*height))
        path.closeSubpath()
        return path
    }
}

fileprivate struct SidePartHairIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.68449*width, y: 0.33545*height))
        path.addCurve(to: CGPoint(x: 0.50401*width, y: 0.33545*height), control1: CGPoint(x: 0.61893*width, y: 0.30468*height), control2: CGPoint(x: 0.5725*width, y: 0.35526*height))
        path.addCurve(to: CGPoint(x: 0.40374*width, y: 0.28776*height), control1: CGPoint(x: 0.46303*width, y: 0.3236*height), control2: CGPoint(x: 0.44587*width, y: 0.2901*height))
        path.addCurve(to: CGPoint(x: 0.26337*width, y: 0.36725*height), control1: CGPoint(x: 0.34309*width, y: 0.28438*height), control2: CGPoint(x: 0.31021*width, y: 0.3213*height))
        path.addCurve(to: CGPoint(x: 0.18984*width, y: 0.47059*height), control1: CGPoint(x: 0.22908*width, y: 0.40089*height), control2: CGPoint(x: 0.20512*width, y: 0.42094*height))
        path.addCurve(to: CGPoint(x: 0.18984*width, y: 0.60572*height), control1: CGPoint(x: 0.17459*width, y: 0.52015*height), control2: CGPoint(x: 0.20509*width, y: 0.55616*height))
        path.addCurve(to: CGPoint(x: 0.11631*width, y: 0.70906*height), control1: CGPoint(x: 0.17456*width, y: 0.65537*height), control2: CGPoint(x: 0.1301*width, y: 0.65881*height))
        path.addCurve(to: CGPoint(x: 0.11631*width, y: 0.82035*height), control1: CGPoint(x: 0.10497*width, y: 0.75038*height), control2: CGPoint(x: 0.11631*width, y: 0.82035*height))
        path.addLine(to: CGPoint(x: 0.11631*width, y: 0.96344*height))
        path.addCurve(to: CGPoint(x: 0.05615*width, y: 0.7965*height), control1: CGPoint(x: 0.11631*width, y: 0.96344*height), control2: CGPoint(x: 0.07427*width, y: 0.86408*height))
        path.addCurve(to: CGPoint(x: 0.02273*width, y: 0.60572*height), control1: CGPoint(x: 0.03671*width, y: 0.72399*height), control2: CGPoint(x: 0.0281*width, y: 0.68156*height))
        path.addCurve(to: CGPoint(x: 0.02273*width, y: 0.47059*height), control1: CGPoint(x: 0.019*width, y: 0.55314*height), control2: CGPoint(x: 0.01126*width, y: 0.52157*height))
        path.addCurve(to: CGPoint(x: 0.09626*width, y: 0.33545*height), control1: CGPoint(x: 0.03639*width, y: 0.40986*height), control2: CGPoint(x: 0.0541*width, y: 0.37338*height))
        path.addCurve(to: CGPoint(x: 0.21658*width, y: 0.28776*height), control1: CGPoint(x: 0.13575*width, y: 0.29991*height), control2: CGPoint(x: 0.16723*width, y: 0.29283*height))
        path.addLine(to: CGPoint(x: 0.26337*width, y: 0.28776*height))
        path.addLine(to: CGPoint(x: 0.24332*width, y: 0.26391*height))
        path.addCurve(to: CGPoint(x: 0.24332*width, y: 0.17647*height), control1: CGPoint(x: 0.24332*width, y: 0.26391*height), control2: CGPoint(x: 0.23498*width, y: 0.20915*height))
        path.addCurve(to: CGPoint(x: 0.3369*width, y: 0.07313*height), control1: CGPoint(x: 0.25778*width, y: 0.11971*height), control2: CGPoint(x: 0.3369*width, y: 0.07313*height))
        path.addCurve(to: CGPoint(x: 0.50401*width, y: 0.02544*height), control1: CGPoint(x: 0.3369*width, y: 0.07313*height), control2: CGPoint(x: 0.4369*width, y: 0.02468*height))
        path.addCurve(to: CGPoint(x: 0.66444*width, y: 0.07313*height), control1: CGPoint(x: 0.56859*width, y: 0.02616*height), control2: CGPoint(x: 0.66444*width, y: 0.07313*height))
        path.addCurve(to: CGPoint(x: 0.83824*width, y: 0.22417*height), control1: CGPoint(x: 0.66444*width, y: 0.07313*height), control2: CGPoint(x: 0.77765*width, y: 0.15486*height))
        path.addCurve(to: CGPoint(x: 0.95856*width, y: 0.39905*height), control1: CGPoint(x: 0.89171*width, y: 0.28534*height), control2: CGPoint(x: 0.93047*width, y: 0.31737*height))
        path.addCurve(to: CGPoint(x: 0.97861*width, y: 0.60572*height), control1: CGPoint(x: 0.98442*width, y: 0.47425*height), control2: CGPoint(x: 0.98184*width, y: 0.52456*height))
        path.addCurve(to: CGPoint(x: 0.94519*width, y: 0.83625*height), control1: CGPoint(x: 0.9752*width, y: 0.69149*height), control2: CGPoint(x: 0.94519*width, y: 0.83625*height))
        path.addCurve(to: CGPoint(x: 0.91177*width, y: 0.8442*height), control1: CGPoint(x: 0.94519*width, y: 0.83625*height), control2: CGPoint(x: 0.93182*width, y: 0.8124*height))
        path.addCurve(to: CGPoint(x: 0.87834*width, y: 0.98728*height), control1: CGPoint(x: 0.89171*width, y: 0.87599*height), control2: CGPoint(x: 0.87834*width, y: 0.98728*height))
        path.addLine(to: CGPoint(x: 0.87834*width, y: 0.87599*height))
        path.addCurve(to: CGPoint(x: 0.87834*width, y: 0.74086*height), control1: CGPoint(x: 0.87834*width, y: 0.87599*height), control2: CGPoint(x: 0.88914*width, y: 0.79205*height))
        path.addCurve(to: CGPoint(x: 0.8115*width, y: 0.60572*height), control1: CGPoint(x: 0.86582*width, y: 0.68147*height), control2: CGPoint(x: 0.82402*width, y: 0.66511*height))
        path.addCurve(to: CGPoint(x: 0.8115*width, y: 0.47059*height), control1: CGPoint(x: 0.8007*width, y: 0.55454*height), control2: CGPoint(x: 0.82593*width, y: 0.52049*height))
        path.addCurve(to: CGPoint(x: 0.68449*width, y: 0.33545*height), control1: CGPoint(x: 0.78985*width, y: 0.39575*height), control2: CGPoint(x: 0.7464*width, y: 0.36451*height))
        path.closeSubpath()
        return path
    }
}
