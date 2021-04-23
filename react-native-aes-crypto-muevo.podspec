
Pod::Spec.new do |s|
  s.name          = 'react-native-aes-crypto-muevo'
  s.version       = '1.3.25'
  s.summary       = 'Native module for AES encryption'
  s.author        = "tectiv3"
  s.license       = 'MIT'
  s.requires_arc  = true
  s.homepage      = "https://github.com/MuevoApp/react-native-aes-crypto-muevo"
  s.source        = { :git => 'https://github.com/MuevoApp/react-native-aes-crypto-muevo' }
  s.platform      = :ios, '9.0'
  s.source_files  = "ios/**/*.{h,m}"

  s.dependency "React-Core"
end
