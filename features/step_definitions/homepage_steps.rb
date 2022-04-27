Then(/^I should see the organization name$/) do
  expect(page).to have_content("BAY TRAIL BIRD MAPPING")
end

Then(/^I should see the sidebar cards$/) do
  expect(page).to have_content("sidebar")
end

Then(/^I should see the side navigation bar$/) do
  expect(page).to have_css("nav")
end

Then(/^I should see the map items$/) do
  expect(page).to have_selector("div#leaflet-map")
end

Then(/^I should see location cards$/) do
  expect(page).to have_content("BIRDING THE BAY TRAIL")
end
