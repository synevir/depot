namespace :db do
  desc "Add to database payment_types"
  task add_payment_types: :environment do
    payment_type1 = PaymentType.create!(name: "Check")
    payment_type2 = PaymentType.create!(name: "Credit card")
    payment_type3 = PaymentType.create!(name: "Purchase order")
  end
end
