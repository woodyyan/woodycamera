import SwiftUI

struct UrgeWoodyView: View {
    private let urgeUrl = "https://urge-1256194296.cos.ap-shanghai.myqcloud.com/urge.json"
    @State private var showingSuccessAlert = false
    @State private var showingFailAlert = false
    @State private var urgeCount = 1

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
        }.onAppear {
            syncUrgeCount { count in
            }
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
        
        syncUrgeCount { count in
            updateUrgeCount(count: count)
        }
        return true
    }
    
    func updateUrgeCount(count: Int) {
        // Prepare URL
        let url = URL(string: urgeUrl)!

        // Prepare URL Request Object
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
         
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "{\"count\" : \(count + 1)}";

        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);

        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                }
            self.urgeCount = count + 1
        }
        task.resume()
    }
    
    func syncUrgeCount(action: @escaping (Int) -> Void) {
        let url = URL(string: urgeUrl)!

        let task = URLSession.shared.dataTask(with: url) { [self](data, response, error) in
            guard let data = data else {
                print(error ?? "网络错误")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let count = json["count"] as? Int {
                        print(count)
                        self.urgeCount = count
                        action(count)
                    }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        task.resume()
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
