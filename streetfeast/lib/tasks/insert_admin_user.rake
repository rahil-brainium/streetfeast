namespace :insert_admin_user do
  desc "TODO"
  task insert_admin: :environment do
  	#User.create(:email => "admin@test.com",:password => "test1234",:is_admin => true)
  	u= User.find_by_email("ghabhradip@gmail.com")
  	u.update(:is_admin => true)
  	puts "-----done-----"
  end

end
