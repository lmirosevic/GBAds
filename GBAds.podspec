Pod::Spec.new do |s|
  s.name         = 'GBAds'
  s.version      = '1.1.0'
  s.summary      = 'Abstracts away different interstitial ad network implementations and implements simple mediation logic for maximising fill rates.'
  s.homepage     = 'https://github.com/lmirosevic/GBAds'
  s.license      = 'Apache License, Version 2.0'
  s.author       = { 'Luka Mirosevic' => 'luka@goonbee.com' }
  s.platform     = :ios, '6.0'
  s.source       = { git: 'https://github.com/lmirosevic/GBAds.git', tag: s.version.to_s }
  s.source_files  = 'GBAds/GBAds.{h,m}', 'GBAds/GBAdsNetworks.h'
  s.public_header_files = 'GBAds/GBAds.h', 'GBAds/GBAdsNetworks.h'
  s.requires_arc = true

  s.dependency 'ChartboostSDK', '~> 5.0'
  s.dependency 'TapjoySDK', '~> 10.1'
  s.dependency 'RevMob-Goonbee', '~> 8.0'

  s.dependency 'GBVersionTracking', '~> 1.2'
  s.dependency 'GBAnalytics', '~> 4.0'
  s.dependency 'GBToolbox'
end
