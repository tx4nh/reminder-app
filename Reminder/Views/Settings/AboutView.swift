import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.accentColor.opacity(0.1))
                                .frame(width: 100, height: 100)
                            
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 50))
                                .foregroundColor(.accentColor)
                        }
                        
                        VStack(spacing: 8) {
                            Text("app_name")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(" App")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("version_app")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("Ứng dụng quản lý lịch hẹn thông minh")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("about_app")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("overview_app")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Tính năng nổi bật")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 12) {
                            FeatureRow(
                                icon: "bell.badge",
                                title: "Thông báo thông minh",
                                description: "Nhắc nhở đúng thời điểm với âm thanh tùy chỉnh"
                            )
                            
                            FeatureRow(
                                icon: "icloud.and.arrow.up",
                                title: "Đồng bộ đám mây",
                                description: "Dữ liệu được bảo mật và đồng bộ trên mọi thiết bị"
                            )
                            
                            FeatureRow(
                                icon: "paintbrush",
                                title: "Giao diện đẹp mắt",
                                description: "Thiết kế hiện đại với chế độ sáng/tối"
                            )
                            
                            FeatureRow(
                                icon: "lock.shield",
                                title: "Bảo mật cao",
                                description: "Thông tin cá nhân được mã hóa và bảo vệ"
                            )
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Thông tin kỹ thuật")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 8) {
                            InfoRow(label: "Phiên bản", value: "1.0.0 (Build 1)")
                            InfoRow(label: "Hệ điều hành", value: "iOS 16.0+")
                            InfoRow(label: "Ngôn ngữ", value: "Swift, SwiftUI")
                            InfoRow(label: "Cơ sở dữ liệu", value: "Supabase")
                            InfoRow(label: "Kích thước", value: "12.5 MB")
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Nhà phát triển")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 8) {
                            InfoRow(label: "Công ty", value: "Your Company Name")
                            InfoRow(label: "Email", value: "support@yourcompany.com")
                            InfoRow(label: "Website", value: "www.yourcompany.com")
                        }
                    }

                    VStack(spacing: 12) {
                        Divider()
                        
                        HStack(spacing: 20) {
                            Button("terms_of_use") {
                                // TODO: Open terms of service
                                print("Terms tapped")
                            }
                            .font(.caption)
                            .foregroundColor(.accentColor)
                            
                            Button("privacy_policy") {
                                // TODO: Open privacy policy
                                print("Privacy tapped")
                            }
                            .font(.caption)
                            .foregroundColor(.accentColor)
                        }
                        
                        Text("© 2024 Your Company Name. All rights reserved.")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("about_app")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel_button") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.accentColor.opacity(0.1))
                    .frame(width: 32, height: 32)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.accentColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineSpacing(2)
            }
            
            Spacer()
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    AboutView()
}
