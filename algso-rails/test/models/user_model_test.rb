require 'test_helper'

class UserTest < ActiveSupport::TestCase
	userData = {"name" => "my_name",
		  "email" => "myemail@email.com",
		  "password" => "my_password",
		}

	# email
	test "should not save User without email" do 
		user = User.new(:name => userData['name'],
										:email => "",
										:password => userData['password'],
										:password_confirmation => userData['password'])
		assert_not user.save, "save should with a email"
	end

	test "should not save User with an existent email" do 
		user = User.new(:name => userData['name'],
										:email => "existent_email@email.com",
										:password => userData['password'],
										:password_confirmation => userData['password'])
		assert_not user.save, "save should with a email"
	end

	test "should not save User with an invalid email" do 
		user = User.new(:name => userData['name'],
										:email => "testEmail.com",
										:password => userData['password'],
										:password_confirmation => userData['password'])
		assert_not user.save, "save should with a email"
	end

	# name
	test "should not save User without name" do 
		user = User.new(:name => "",
										:email => userData['email'],
										:password => userData['password'],
										:password_confirmation => userData['password'])
		assert_not user.save, "save should with a name"
	end

	test "should not save User when name's length less than 2" do 
		user = User.new(:name => "1",
										:email => userData['email'],
										:password => userData['password'],
										:password_confirmation => userData['password'])
		assert_not user.save, "name's length shouldn't be less than 2"
	end

	test "should not save User when name's length more than 10" do 
		user = User.new(:name => "12345678901",
										:email => userData['email'],
										:password => userData['password'],
										:password_confirmation => userData['password'])
		assert_not user.save, "name's length shouldn't be more than 10"
	end

	# password
	test "should not save User without password" do 
		user = User.new(:name => userData['name'],
										:email => userData['email'],
										:password => '',
										:password_confirmation => userData['password'])
		assert_not user.save, "save should with a password"
	end

	test "should not save User when password's length less than 6" do 
		user = User.new(:name => userData['name'],
										:email => userData['email'],
										:password => '12345',
										:password_confirmation => '12345')
		assert_not user.save, "password's length shouldn't be less than 6"
	end

	# password_confirmation
	test "should not save User without password_confirmation" do 
		user = User.new(:name => userData['name'],
										:email => userData['email'],
										:password => userData['password'],
										:password_confirmation => '')
		assert_not user.save, "save should with a password_confirmation"
	end

	test "should not save User if password and password_confirmation are not the same" do 
		user = User.new(:name => userData['name'],
										:email => userData['email'],
										:password => userData['password'],
										:password_confirmation => userData['password'] + "xxx")
		assert_not user.save, "password and password_confirmation should be the same"
	end

	# test "should report error" do
	#   flunk "not finish"
	# end
end

