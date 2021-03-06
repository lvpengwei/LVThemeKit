@version = "1.0.0"
Pod::Spec.new do |s|
	s.name = "LVThemeKit"
	s.version = @version
	s.summary = "Theme kit."
	s.description = "Theme kit for UIKit."
	s.homepage = "https://github.com/lvpengwei/LVThemeKit"
	s.license = {:type => 'MIT', :file => 'LICENSE' }
	s.author = { "lvpengwei" => "pengwei.lv@gmail.com" }
	s.ios.deployment_target = '8.0'
	s.source = { :git => "https://github.com/lvpengwei/LVThemeKit.git", :tag => @version }
	s.swift_version = '5.0'
	s.default_subspec = 'ObjC'

	s.subspec 'ObjC' do |objc|
		objc.source_files = ['Source/ObjC/**/*.{h,m}']
		objc.prefix_header_contents = <<-EOS
		#ifdef __OBJC__
		#import <UIKit/UIKit.h>
		#import <Foundation/Foundation.h>
		#import "LVThemeColor.h"
		#import "LVThemeImage.h"
		#import "LVThemeKit.h"
		#import "LVThemeString.h"
		#import "UIButton+LVThemeKit.h"
		#import "UILabel+LVThemeKit.h"
		#import "UIView+LVThemeKit.h"
		#import "UISlider+LVThemeKit.h"
		#import "UIImageView+LVThemeKit.h"
		#import "CALayer+LVThemeKit.h"
		#import "CAShapeLayer+LVThemeKit.h"
		#endif
		EOS
	end

	s.subspec 'Swift' do |swift|
		swift.source_files = ['Source/Swift/**/*.swift']
	end

end
