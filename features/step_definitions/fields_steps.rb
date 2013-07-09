#	 Scenario: add game field data with valid data
When /^I enter valid game data$/ do
	@game_title = "Game1"
	@game = Game.find_by_title @game_title
	fill_in "game_title", :with => @game_title
	sleep(1)
end
 
When /^I enter valid data into the field "(.*?)"$/ do |fill|
	@day = "21"
	@month = "3"
	@year = "2012"
	@additionalDate = "@additionalDate"
	@allDateText = @day + "." + @month + "." + @year
	if fill == "Release Dates"
		within(".release_dates_div") do
			select(@day, :from => 'day_release_date1')
			select(@month, :from => 'month_release_date1')
			fill_in "year_release_date1", :with => @year
			fill_in "text_release_date1", :with => " - " + @additionalDate
		end
	end
	
	@data = Hash.new
		
	if fill == "Developer"
		@data[:devText] = "new developer 7yff1dzf"
		@data[:devRole] = "developer role 3son8c10dl5nh8mj"
		fill_in "developer_link", with: @data[:devText]
		fill_in 'developer_text', with: @data[:devRole]

	elsif fill == "Publisher"
		@textPublisher = "new publisher vudwfkua"
		@textPublisherRole = "publisher role pi0ugd3iui0lb5na"
		fill_in "publisher_link", with: @textPublisher
		fill_in 'publisher_text', with: @textPublisherRole

	elsif fill == "Distributor"
		@data[:distributorText] = "new distributor gx8096zr"
		@data[:distributorRole] = 'distributor role xljut5ocyswxsesd'
		fill_in "distributor_link", with: @data[:distributorText]
		fill_in 'distributor_text', with: @data[:distributorRole]

	elsif fill == "Credits"
		@data[:creditsText] = "new credits zeo9to35"
		@data[:creditsRole] = 'credits role gikktmkcc9mjgiun'
		fill_in "credits_link", with: @data[:creditsText]
		fill_in 'credits_text', with: @data[:creditsRole]

	elsif fill == "Series"
		@data[:SeriesText] = "new series xkj3z1my"
		@data[:SeriesDescription] = 'series description epjioovk97emttxs'
		fill_in "series_link", with: @data[:SeriesText]
		fill_in 'series_text', with: @data[:SeriesDescription]

	elsif fill == "Userdefined"
		@data[:userdefinedTitle] = "new name Userdefined z6euvtrj"
		@data[:userdefinedText] = "new contentUserdefined gwn9oc7e"
		click_link_or_button "Add Field"
		select(fill, :from => 'newFieldId')
		fill_in "name_userdefined1", with: @data[:userdefinedTitle]
		fill_in "content_userdefined1", with: @data[:userdefinedText]

	elsif fill == "External Links"
		@data[:externalLinks] = "new external links 4hy4itam"
		fill_in "new_external_links", with: @data[:externalLinks]

	elsif fill == "Aggregate Scores"
		@data[:aggregateScores] = "a new score gupcwuba"
		click_link_or_button "Add Field"
		select(fill, :from => 'newFieldId')
		fill_in "new_aggregate_scores", with: @data[:aggregateScores]

	elsif fill == "Review Scores"
		click_link_or_button "Add Field"
		@data[:reviewScores] = "new review score pijixqrl"
		select(fill, :from => 'newFieldId')
		fill_in "new_review_scores", with: @data[:reviewScores]
	end
end

And /^I create the game$/ do
	click_link_or_button "Create Game Article" 
end

Then /^I should see the saved (.*?) fields$/ do |pname|
	within(".fact-box") do
		if pname == "Game"
			page.should have_content(@allDateText)
			page.should have_content(@additionalDate)
			
			@data.each do |bit|
				page.should have_content(bit.last)
			end
		end
		if pname == "Developer"
			page.should have_content(@contentUserdefined)
			page.should have_content(@externalLinks)
		end
		if pname == "Company"
			page.should have_content(@contentUserdefined)
			page.should have_content("Founded")
			page.should have_content(@additionalDefunct)
			page.should have_content(@textLocation)
			page.should have_content(@textOfficialName)
			page.should have_content(@externalLinks)
		end
	end
end

#	 Scenario: add Release Dates without day
Then /^I enter field of Release Dates without day$/ do	
	within(".newFieldsDiv") do
		sleep(1)
		@day = "nil"
		@month = "3"
		@year = "2012"
		@additionalDate = "@additionalDate"
		@allDateText=@day +"." +@month+"." + @year
			within(".release_dates_div") do							 
				select(@month, :from => 'month_release_date1')
				fill_in "year_release_date1", :with => @year
				fill_in "text_release_date1", :with => @additionalDate
		end
	end
end

#		 Scenario: add Release Dates without month
Then /^I enter field of Release Dates without month$/ do 
	within(".newFieldsDiv") do
		sleep(1)
		@day = "12"
		@month = "nil"
		@year = "2012"
		@additionalDate = "@additionalDate"
		@allDateText=@day +"." +@month+"." + @year
			within(".release_dates_div") do							 
				select(@day, :from => 'day_release_date1')
				fill_in "year_release_date1", :with => @year
				fill_in "text_release_date1", :with => @additionalDate
		end	 
	end		 
end

Then /^I should see error for month$/ do
	within("#error_explanation") do
		page.should have_content("Release dates day needs Month to be specified")
	end
end

#		Scenario: add game field with token list 
When /^I enter tokens for "(.*?)"$/ do |fill|
	@data = Hash.new
	
	if fill == "Platform"
		@data[:platforms] = "new plattforms 2hv19n7p1xy0l32h"
		fill_in "new_platforms_input", with: @data[:platforms]
		
	elsif fill == "Genres" 
		@data[:genres] = "new genres ncubdtvememvemxk"
		fill_in "new_genres_input", with: @data[:genres]
		
	elsif fill == "Tags"
		@data[:tags] = "new tags 1fjtg8zfw27cyign"
		fill_in "new_tags_input", with: @data[:tags]
		
	elsif fill == "Mode"
		@data[:mode] = "new modes xcld9y0u2cz0x4kz"
		fill_in "new_modes_input", with: @data[:mode]
		
	elsif fill == "Media"
		@data[:media] = "new medias 8mv8xw10ryhlttah"
		fill_in "new_medias_input", with: @data[:media]
	end
end

Then /^I should see the saved tokens$/ do
	 @data.each do |bit|
		page.should have_content(bit.last)
	end
end


 