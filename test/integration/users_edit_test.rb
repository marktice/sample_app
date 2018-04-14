require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'Unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", 
                                              email: "foo@invalid", 
                                              password: 'foo', 
                                              password_confirmation: 'bar' } }
    assert_template 'users/edit'
    assert_select 'div.alert', "The form contains 4 errors."
  end

  test 'Successful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    valid_name = "Valid Name"
    valid_email = "valid@email.com"
    patch user_path(@user), params: { user: { name: valid_name, 
                                              email: valid_email, 
                                              password: 'foobar', 
                                              password_confirmation: 'foobar' } }
    assert_not flash.empty?
    assert_redirected_to @user
    follow_redirect!
    @user.reload
    assert_equal valid_name,  @user.name
    assert_equal valid_email, @user.email
  end
end