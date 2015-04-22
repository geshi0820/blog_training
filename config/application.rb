# config.assets.paths << "#{Rails}/vender/assets/fonts"
require File.expand_path('../boot', __FILE__)
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
Bundler.require(*Rails.groups)

module Blogapp
	class Application < Rails::Application
		config.time_zone = 'Tokyo'
		config.active_record.default_timezone = :local
		config.active_record.time_zone_aware_attributes = false
		config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
		config.i18n.default_locale = :ja
		config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

		config.generators do |g|
			g.test_framework :rspec,
			fixtures: true,
			view_scecs: false,
			helper_specs: false,
			routing_specs: false,
			controller_specs: true,
			request_specs: false
			g.fixture_replacement :factory_girl, dir: "spec/factories"
		end

		def user_image
			user = User.find(self)
			if user.image.blank?
				if user.uid
					uid = user.uid.to_s
					"https://graph.facebook.com/"+uid+"/picture?type=square"
				else
					"http://www.oomoto.or.jp/japanese/_src/sc6732/90l95A883A83C83R8393.jpg"
				end
			else
				user.image_url(:thumb).to_s
			end
		end
	end
	
end
