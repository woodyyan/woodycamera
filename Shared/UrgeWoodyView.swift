import SwiftUI

struct UrgeWoodyView: View {
    @State private var showingSuccessAlert = false
    @State private var showingFailAlert = false
    let urgeCount = 1

    @ViewBuilder
    var body: some View {
        VStack {
            Image("logo")
            if urgeCount > 0 {
                Text("😭 Woody已被催更\(urgeCount)次了，Woody最近可能比较忙。").padding()
            } else {
                Text("😊 还没有人催Woody，Woody可以继续偷懒一阵。").padding()
            }
            
            Button {
                let success = urge()
                if success {
                    showingSuccessAlert = true
                } else {
                    showingFailAlert = true
                }
            } label: {
                Label("Woody快更新！", systemImage: "camera")
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.themeColor, lineWidth: 1)
            )
            .alert("催更成功", isPresented: $showingSuccessAlert) {
                Button("好的", role: .cancel) { }
            } message: {
                Text("Woody已经收到你的催更")
            }
            .alert("催更失败", isPresented: $showingFailAlert) {
                Button("好的", role: .cancel) { }
            } message: {
                Text("你今天已经催过了哦，明天再来催吧。")
            }
            Label("点它催Woody更新", systemImage: "hand.point.up")
                .font(.system(size: 14)).padding()
        }
    }
    
    func urge() -> Bool {
        let today = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let urgeDate = formatter.string(from: today)
        let file = "urge.json"

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(file)
            
            //reading
            do {
                let date = try String(contentsOf: fileURL, encoding: .utf8)
                print(date)
                if let savedDate = formatter.date(from:date) {
                    let success = !isSameDay(date1: savedDate, date2: today)
                    return success
                }
            }
            catch {
                print(error.localizedDescription)
            }

            //writing
            do {
                try urgeDate.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        updateUrgeCount()
        return true
    }
    
    func updateUrgeCount() {
        
    }
    
    func getUrgeCount() -> Int {
    
        return 0
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
}

struct UrgeWoodyView_Previews: PreviewProvider {
    static var previews: some View {
        UrgeWoodyView()
    }
}
