import SwiftUI

struct MainView: View {
    let appUser: AppUser
    let onSignOut: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Xin chào!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Spacer()
                Button(action: {
                    onSignOut()
                }, label: {
                    HStack(spacing: 6) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 14, weight: .medium))
                        Text("Sign Out")
                            .font(.system(size: 14, weight: .medium))
                    }
                })
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.red)
                        .shadow(color: Color.red.opacity(0.3), radius: 4, x: 0, y: 2)
                )
                .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    Image(systemName: "calendar")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("Lịch trình hôm nay")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.primary, .secondary],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            
            Spacer()
            
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("User ID")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                            
                            Text(appUser.uid)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.green)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Email")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                            
                            Text(appUser.email ?? "No email")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                    }
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                )
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .cyan],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Tạo lịch trình mới")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Text("Hãy thêm các hoạt động để nhận thông báo")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [Color(.systemGray6), Color(.systemGray5)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                        )
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(
            LinearGradient(
                colors: [
                    Color(.systemGroupedBackground),
                    Color(.systemGray6).opacity(0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

#Preview {
    MainView(appUser: AppUser(uid: "123", email: "123@example.com"), onSignOut: {
        print("Sign Out")
    })
}
