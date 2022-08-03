require 'rails_helper'

RSpec.describe Invoice do
  describe 'invoice#show' do
    it 'shows invoice attributes' do
      merchant = Merchant.create!(name: "Al Capone")

      customer1 = Customer.create!(first_name: "Babe", last_name: "Ruth")
      customer2 = Customer.create!(first_name: "Charles", last_name: "Bukowski")
      customer3 = Customer.create!(first_name: "Josey", last_name: "Wales")

      invoice1 = Invoice.create!(status: 0, customer_id: customer1.id)
      invoice2 = Invoice.create!(status: 0, customer_id: customer2.id)
      invoice3 = Invoice.create!(status: 0, customer_id: customer3.id)

      visit admin_invoices_path

      within(".customer_invoice-#{invoice1.id}") do
        expect(page).to have_link("#{invoice1.id}")
        click_link "#{invoice1.id}"
        expect(current_path).to eq("/admin/invoices/#{invoice1.id}")
      end

      expect(page).to have_content("Invoice ID: #{invoice1.id}")
      expect(page).to have_content("Invoice Status: In Progress")
      expect(page).to have_content("Invoice #{invoice1.created_at.strftime("Created On: %m/%d/%Y")}")
      expect(page).to have_content("Customer Name: Babe Ruth")
    end
  end

  describe 'Invoice Item Information' do
    it 'can visit an admin invoice show page' do
      merchant1 = Merchant.create!(name: "Josey Wales")
      merchant2 = Merchant.create!(name: "Britches Eckles")
      
      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, merchant_id: merchant1.id )
      item4 = Item.create!(name: "Leash", description: "dog leash", unit_price: 100, merchant_id: merchant1.id )
      item5 = Item.create!(name: "Collar", description: "dog collar", unit_price: 100, merchant_id: merchant1.id )
      item6 = Item.create!(name: "kibble", description: "dog food", unit_price: 100, merchant_id: merchant1.id )
      
      customer1 = Customer.create!(first_name: "Babe", last_name: "Ruth")
      customer2 = Customer.create!(first_name: "Charles", last_name: "Bukowski")
      customer3 = Customer.create!(first_name: "Josey", last_name: "Wales")
      customer4 = Customer.create!(first_name: "Popcorn", last_name: "Sutton")
      customer5 = Customer.create!(first_name: "Nucky", last_name: "Johnson")
      customer6 = Customer.create!(first_name: "Freddy", last_name: "McCoy")
      
      invoice1 = Invoice.create!(status: 0, customer_id: customer1.id)
      invoice2 = Invoice.create!(status: 0, customer_id: customer2.id)
      invoice3 = Invoice.create!(status: 0, customer_id: customer3.id)
      invoice4 = Invoice.create!(status: 0, customer_id: customer4.id)
      invoice5 = Invoice.create!(status: 0, customer_id: customer5.id)
      invoice6 = Invoice.create!(status: 0, customer_id: customer6.id)
      
      invoice_items1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 500, status: 0) #500
      invoice_items2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 2, unit_price: 200, status: 0) #400
      invoice_items3 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item3.id, quantity: 3, unit_price: 100, status: 1) #300
      invoice_items4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item4.id, quantity: 2, unit_price: 100, status: 1) #200
      invoice_items5 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item5.id, quantity: 2, unit_price: 400, status: 2) #800
      invoice_items6 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item6.id, quantity: 2, unit_price: 600, status: 2) #1200
      
      transaction1 = Transaction.create!(credit_card_number: 2325994, result: 1, invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: 8203839, result: 1, invoice_id: invoice2.id)
      transaction3 = Transaction.create!(credit_card_number: 9348031, result: 1, invoice_id: invoice3.id)
      transaction4 = Transaction.create!(credit_card_number: 9397282, result: 1, invoice_id: invoice4.id)
      transaction5 = Transaction.create!(credit_card_number: 2994421, result: 1, invoice_id: invoice5.id)
      transaction6 = Transaction.create!(credit_card_number: 5929135, result: 1, invoice_id: invoice6.id)
      
      visit admin_invoice_path(invoice1.id)
    end

    it 'when on invoice-item show page shows all the items for that invoice and no other' do
      merchant1 = Merchant.create!(name: "Josey Wales")
      merchant2 = Merchant.create!(name: "Britches Eckles")
      
      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, merchant_id: merchant1.id )
      item4 = Item.create!(name: "Leash", description: "dog leash", unit_price: 100, merchant_id: merchant1.id )
      item5 = Item.create!(name: "Collar", description: "dog collar", unit_price: 100, merchant_id: merchant1.id )
      item6 = Item.create!(name: "kibble", description: "dog food", unit_price: 100, merchant_id: merchant1.id )
      
      customer1 = Customer.create!(first_name: "Babe", last_name: "Ruth")
      customer2 = Customer.create!(first_name: "Charles", last_name: "Bukowski")
      customer3 = Customer.create!(first_name: "Josey", last_name: "Wales")
      customer4 = Customer.create!(first_name: "Popcorn", last_name: "Sutton")
      customer5 = Customer.create!(first_name: "Nucky", last_name: "Johnson")
      customer6 = Customer.create!(first_name: "Freddy", last_name: "McCoy")
      
      invoice1 = Invoice.create!(status: 0, customer_id: customer1.id)
      invoice2 = Invoice.create!(status: 0, customer_id: customer2.id)
      invoice3 = Invoice.create!(status: 0, customer_id: customer3.id)
      invoice4 = Invoice.create!(status: 0, customer_id: customer4.id)
      invoice5 = Invoice.create!(status: 0, customer_id: customer5.id)
      invoice6 = Invoice.create!(status: 0, customer_id: customer6.id)
      
      invoice_items1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 500, status: 2) #500
      invoice_items2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 2, unit_price: 200, status: 0) #400
      invoice_items3 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item3.id, quantity: 3, unit_price: 100, status: 1) #300
      invoice_items4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item4.id, quantity: 2, unit_price: 100, status: 1) #200
      invoice_items5 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item5.id, quantity: 2, unit_price: 400, status: 2) #800
      invoice_items6 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item6.id, quantity: 2, unit_price: 600, status: 2) #1200
      
      transaction1 = Transaction.create!(credit_card_number: 2325994, result: 1, invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: 8203839, result: 1, invoice_id: invoice2.id)
      transaction3 = Transaction.create!(credit_card_number: 9348031, result: 1, invoice_id: invoice3.id)
      transaction4 = Transaction.create!(credit_card_number: 9397282, result: 1, invoice_id: invoice4.id)
      transaction5 = Transaction.create!(credit_card_number: 2994421, result: 1, invoice_id: invoice5.id)
      transaction6 = Transaction.create!(credit_card_number: 5929135, result: 1, invoice_id: invoice6.id)
      
      visit admin_invoice_path(invoice1.id)

      within("#items") do
          expect(page).to have_content("Item Name: Camera")
          expect(page).to have_content("Quantity Ordered: 1")
          expect(page).to have_content("Unit Price: $500.00")
          expect(page).to have_content("Item Status: Shipped")

          expect(page).to have_content("Item Name: Bone")
          expect(page).to have_content("Quantity Ordered: 2")
          expect(page).to have_content("Unit Price: $200.00")
          expect(page).to have_content("Item Status: Packaged")

          expect(page).to have_content("Item Name: Kong")
          expect(page).to have_content("Quantity Ordered: 3")
          expect(page).to have_content("Unit Price: $100.00")
          expect(page).to have_content("Item Status: Pending")

          expect(page).to have_content("Item Name: Camera")
          expect(page).to have_content("Quantity Ordered: 1")
          expect(page).to have_content("Unit Price: $500.00")
          expect(page).to have_content("Item Status: Packaged")

          expect(page).to have_content("Item Name: Camera")
          expect(page).to have_content("Quantity Ordered: 1")
          expect(page).to have_content("Unit Price: $500.00")
          expect(page).to have_content("Item Status: Packaged")
      end
    end
  end
end