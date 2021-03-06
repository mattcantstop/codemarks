Given /^"([^"]*)" is a topic$/ do |topic_title|
  @topic = Fabricate(:topic, :title => topic_title)
end

When /^I search for that topic$/ do
  page.fill_in('_topic_autocomplete', :with => @topic.title)
  page.find('.ui-menu-item a').click()
end

When /^I search for a word from that codemark's title$/ do
  search_term = @codemark.title.split.first
  page.fill_in('site_search', :with => search_term)
  page.find('#site_search_submit').click()
end

Then /^I should be on that topic's page$/ do
  current_path.should == topic_path(@topic)
end
