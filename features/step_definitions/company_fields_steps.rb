When /^I enter valid company data$/ do
	@fieldCompany=FactoryGirl.create :company , name:"field Company"
	fill_in "company_name", :with => @fieldCompany.name
end

When /^I enter company field with "(.*?)"$/ do |fill|
	@day = "21"
	@month = "3"
	@year = "2012"
	@additionalDefunct = "additionalDefunct akxdyo6e9l8croic"

	if fill == "Founded"
		select(@day, :from => 'day_founded')
		select(@month, :from => 'month_founded')
		fill_in "year_founded", :with => @year

	elsif fill == "Defunct"
		click_link_or_button "Add Field"
		select(fill, :from => 'newFieldId')
		select(@day, :from => 'day_defunct')
		select(@month, :from => 'month_defunct')
		fill_in "year_defunct", :with => @year
		fill_in "text_defunct", :with => @additionalDefunct

	elsif fill == "External Links"
		@externalLinks = "new external links fx2yhvrleuj2jfz6"
		fill_in "new_external_links", :with => @externalLinks

	elsif fill == "Userdefined"
		@nameUserdefined = "new name Userdefined wqaysjm4umneuf7u"
		@contentUserdefined = "new contentUserdefined usa1t8afh2cr6rl4"
		click_link_or_button "Add Field"
		select(fill, :from => 'newFieldId')
		fill_in "name_userdefined2", :with => @nameUserdefined
		fill_in "content_userdefined2", :with => @contentUserdefined

	elsif fill == "Official Name"
		@textOfficialName = "new o name qpu1avn25r40haou"
		fill_in "official_name", :with => @textOfficialName

	elsif fill == "Location"
		@textLocation = "new Location r2ce2h4p6yp7g59o"
		fill_in "new_locations", :with => @textLocation
	end
end

Then /^I create the company$/ do
	click_link_or_button "Create Studio/Organisation Article"
end
 
