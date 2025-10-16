import Foundation
import AVFAudio

let soundOptions: [Sound] = [
    Sound(name: "Mặc định", file: "default"),
    Sound(name: "Tỏa Sáng", file: "sound1"),
    Sound(name: "Nhẹ nhàng", file: "sound2"),
    Sound(name: "Dịu dàng", file: "sound3"),
    Sound(name: "Thắc mắc", file: "sound4"),
    Sound(name: "Tick", file: "sound5"),
    Sound(name: "Thông báo", file: "sound6"),
    Sound(name: "Âm báo", file: "sound7"),
    Sound(name: "Chuông", file: "sound8")
]

class SoundManeger{
    static let shared = SoundManeger()
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(named fileName: String, withExtension ext: String = "caf") {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: ext) else{
            print("Sound file not found: \(fileName).\(ext)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    func stopSound() { }
}
