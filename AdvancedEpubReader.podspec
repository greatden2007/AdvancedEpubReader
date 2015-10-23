Pod::Spec.new do |spec|
  spec.name             = 'AdvancedEpubReader'
  spec.license          = { :type => 'BSD' }
  spec.homepage         = 'https://github.com/greatden2007/AdvancedEpubReader'
  spec.authors          = { 'Denis Kudinov' => 'kudinov.dw@gmail.com' }
  spec.summary          = 'Epub reader for iOS'
  spec.source           = { :git => 'https://github.com/greatden2007/AdvancedEpubReader.git', :branch => 'master' }
  spec.requires_arc     = true
  s.resources = ["AdvancedEpubReader/Base.lproj/*.storyboard"]
  s.source_files  = 'AdvancedEpubReader/Classes/**/*.{h,m}'
end