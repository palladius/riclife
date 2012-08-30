
# copiato da: http://opensoul.org/2009/3/6/testing-facebook-with-cucumber
# suppongo voglia la gemma di Rails
#
When "I upload a video" do
  visit root_path

  without_canvas do
    fill_in 'Title', :with => 'A video'
    fill_in 'Description', :with => 'Caption for video'
    attach_file 'Video', "#{RAILS_ROOT}/features/support/sample.mpg", "video/mpeg"
    click_button 'Upload Video'
  end
  follow_redirect!
end


Given "I am logged in as a Facebook user" do
  @current_user = User.create! :facebook_id => 1
  @current_user.facebook_user.friends = [
    Facebooker::User.new(:id => 2, :name => 'Bob'),
    Facebooker::User.new(:id => 3, :name => 'Sam')
  ]
  @integration_session.default_request_params.merge!(
    :fb_sig_user => @current_user.facebook_id,
    :fb_sig_friends => @current_user.facebook_user.friends.map(&:id).join(',')
  )
end

