##################################
#
# visiting
#
##################################

def visit_home_page
  visit "/"
end

## companies
def visit_company_creation_page
  visit new_company_path
end

def visit_companies_overview_page
  visit companies_path
end

def visit_company_detail_page(company)
  visit company_path(company)
end

def visit_company_edit_page(company)
  visit edit_company_path(company)
end

## games
def visit_games_overview_page
  visit games_path
end

def visit_game_creation_page
  visit new_game_path
end

def visit_game_edit_page(game)
  visit edit_game_path(game)
end

def visit_game_page(game)
  visit game_path(game)
end

## developers
def visit_developers_overview_page
  visit developers_path
end

def visit_developer_creation_page
  visit new_developer_path
end

def visit_developer_page(developer)
  visit developer_path(developer)
end

def visit_developer_edit_page(developer)
  visit edit_developer_path(developer)
end

## genre
def visit_genre_creation_page
  visit new_genre_path
end

def visit_genres_overview_page
  visit genres_path
end

def visit_genre_edit_page(genre)
  visit edit_genre_path(genre)
end

def visit_genre_join_page(genre)
  visit join_genre_path(genre)
end
## media
def visit_media_creation_page
  visit new_medium_path
end

def visit_media_overview_page
  visit media_path
end

def visit_media_edit_page(medium)
  visit edit_medium_path(medium)
end

def visit_media_join_page(medium)
  visit join_medium_path(medium)
end
## modes
def visit_mode_creation_page
  visit new_mode_path
end

def visit_modes_overview_page
  visit modes_path
end

def visit_mode_edit_page(mode)
  visit edit_mode_path(mode)
end

def visit_mode_join_page(mode)
  visit join_mode_path(mode)
end
## platforms
def visit_platform_creation_page
  visit new_platform_path
end

def visit_platforms_overview_page
  visit platforms_path
end

def visit_platform_edit_page(platform)
  visit edit_platform_path(platform)
end

def visit_platform_join_page(platform)
  visit join_platform_path(platform)
end
## tags
def visit_tag_creation_page
  visit new_tag_path
end

def visit_tags_overview_page
  visit tags_path
end

def visit_tag_edit_page(tag)
  visit edit_tag_path(tag)
end

def visit_tag_join_page(tag)
  visit join_tag_path(tag)
end
## users
def visit_user_edit_page
  visit edit_user_registration_path
end

def visit_reset_password_page
  visit new_user_password_path
end

def visit_reset_link(user)
  link = ("/users/password/edit?reset_password_token=" + user.reset_password_token)
  visit link
end

def visit_sign_up_form(user)
  visit accept_user_invitation_path(:invitation_token => user.invitation_token)
end

def visit_login_page
  visit new_user_session_path
end

def visit_user_invitation_page
  visit new_user_invitation_path
end

def visit_manage_admin_page
  visit users_manage_path
end

##################################
#
# checking if on a special site
#
##################################

## companies
def on_company_detail_page(company)
  new = CompanyVersioner.instance.current_version company
  current_path.should == company_path(new)
end

## developers
def on_developer_detail_page(developer)
  new = DeveloperVersioner.instance.current_version developer
  current_path.should == developer_path(new)
end

## game
def on_game_detail_page(game)
  new = GameVersioner.instance.current_version game
  current_path.should == game_path(new)
end

## users
def on_login_page
  current_path.should == new_user_session_path
end

def on_user_edit_page
  page.should have_content("Edit User")
end

def on_reset_password_page
  page.should have_content("Change your password")
  current_path.should == edit_user_password_path
  #URI.parse(current_url).path.should == "/users/password/edit"
end

def on_sign_up_page
  current_path.should == accept_user_invitation_path
end
def on_sign_in_page
  current_path.should == "/users/sign_in"
end

def on_invite_page
  current_path.should == "/users/invitation"
  #URI.parse(current_url).path.should == "/users/invitation"
end

def on_password_page
  current_path.should == "/users/password"
  #URI.parse(current_url).path.should == "/users/password"
end

def on_manage_admin_page
  current_path.should == users_manage_path
  #URI.parse(current_url).path.should == "/users/manage"
end