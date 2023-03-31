# coding: utf-8
Pod::Spec.new do |spec|
  spec.name         = "shared"
  spec.version      = "1.local"
  spec.summary      = 'The UnityMediationAdapter Framework provides definition for communication between ad network adapters and the UnityMediationSdk'
  spec.description  = 'This framework defines how communication in the UnityMediationSdk should occur with ad networks. To integrate with the UnityMediationSdk ad networks must implement the interfaces defined in this module.'
  spec.homepage     = "https://github.com/Unity-Technologies/mz-mediation-sdk-ios"
  spec.license        = { :type => 'Unity Monetization Services', :text => <<-LICENSE

Unity Monetization copyright © 2020 Unity Technologies SF
Your use of the Unity Technologies SF ("Unity') services known as "Unity Monetization" are subject to the Unity Monetization Services Terms of Service linked to and copied immediately below.
[Unity Monetization Services TOS](https://unity3d.com/legal/monetization-services-terms-of-service)
Your use of Unity Monetization constitutes your acceptance of such terms. Unless expressly provided otherwise, the software under this license is made available strictly on an "AS IS" BASIS WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED. Please review the license for details on these and other terms and conditions.

    LICENSE
  }
  spec.author             = { "Deck Mcp" => "dmcp@unity3d.com" }
  spec.platform     = :ios, "9.0"
  spec.source               = { :path => '.' }
  spec.static_framework = true
  spec.vendored_frameworks = 'shared.xcframework'
  spec.module_name = "shared"
end
