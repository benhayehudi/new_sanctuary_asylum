require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe 'Friend edit', type: :feature, js: true do

  let!(:admin) { create(:user, :admin) }
  let!(:friend) { create(:friend) }
  let!(:location) { create(:location) }

  before do
    3.times { create(:friend) }
    login_as(admin)
    visit edit_admin_friend_path(friend)
  end

  describe 'editing "Basic" information' do
    it 'displays the "Basic" tab' do
      within '.tab-content' do
        expect(page).to have_content 'Basic'
      end
    end
  end

  describe 'editing "Family" information' do

    describe 'adding a new family relationship' do
      before do
        click_link 'Family'
        click_link 'Add Family Member'
      end

      describe 'with valid information' do
        it 'displays the new family member' do
          family_member = Friend.last
          select 'Spouse', from: 'Relationship'
          select_from_chosen(family_member.name, from: {id: 'family_member_constructor_relation_id'})
          click_button 'Add'
          wait_for_ajax

          within '#family-list' do
            expect(page).to have_content(family_member.name)
          end
        end
      end

      describe 'with incomplete information' do
        it 'displays validation errors' do
          click_button 'Add'
          wait_for_ajax
          expect(page).to have_content("Relationship can't be blank")
        end
      end
    end
  end

  describe 'editing "Activity" information' do

    describe 'adding a new activity' do
      before do
        within '.nav-tabs' do
          click_link 'Activities'
        end
        click_link 'Add Activity'
      end

      describe 'with valid information' do
        it 'displays the new family member' do
          select 'Individual Hearing', from: 'Type'
          select location.name, from: 'Location'
          select_date_and_time(Time.now.beginning_of_hour, from: 'activity_occur_at')
          within '#new_activity' do
            click_button 'Save'
          end
          wait_for_ajax

          within '#activity-list' do
            expect(page).to have_content('Individual hearing')
            expect(page).to have_content(location.name)
          end
        end
      end

      describe 'with incomplete information' do
        it 'displays validation errors' do
          within '#new_activity' do
            click_button 'Save'
          end
          wait_for_ajax
          expect(page).to have_content("Event can't be blank")
        end
      end
    end
  end
end