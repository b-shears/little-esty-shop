require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Al Capone", created_at: Time.now, updated_at: Time.now, status: 'enabled')
    @merchant_2 = Merchant.create!(name: "Lucky Luciano", created_at: Time.now, updated_at: Time.now)
    @merchant_3 = Merchant.create!(name: "George Remus", created_at: Time.now, updated_at: Time.now)
  end

  it 'displays all of the merchants' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)

  end

  it 'has an enabled and disable button next to each merchant based on category' do

    visit '/admin/merchants'
      within (".enabled_merchant-#{@merchant_1.id}") do
        expect(page).to have_button("Disable")
        expect(page).to have_content("Al Capone")
        click_button 'Disable'
        expect(current_path).to eq('/admin/merchants')

      end

      within (".disabled_merchant-#{@merchant_2.id}") do
        expect(page).to have_button("Enable")
        expect(page).to have_content("Lucky Luciano")
        click_button 'Enable'
        expect(current_path).to eq('/admin/merchants')
      end
    end
  end
