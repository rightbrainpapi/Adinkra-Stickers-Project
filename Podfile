# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target '50 Emoji Stickers' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for 50 Emoji Stickers

end

target '50 Emoji Stickers MessagesExtension' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for 50 Emoji Stickers MessagesExtension
	pod 'SwiftyStoreKit'

end

post_install do |installer|

    installer.pods_project.targets.each do |target|

        plist_buddy = "/usr/libexec/PlistBuddy"
        plist = "Pods/Target Support Files/#{target}/Info.plist"
        puts "Add arm64 to #{target} to make it pass iTC verification."
        `#{plist_buddy} -c "Add UIRequiredDeviceCapabilities array" "#{plist}"`

        `#{plist_buddy} -c "Add UIRequiredDeviceCapabilities:0 string arm64" "#{plist}"`

    end

end
