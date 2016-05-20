class ChargesController < ApplicationController
  def new
    @user = current_user
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Premium Membership - #{current_user.username}",
        amount: 20_00
    }
  end

  def create
    @user = current_user
    customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        customer: customer.id,
        amount: 20_00,
        description: "Premium Membership - #{current_user.email}",
        currency: 'usd'
    )

    current_user.premium!

    flash[:notice] = "Thank you for your payment and upgrading to a Premium Account, #{current_user.email}!"
    redirect_to root_path

  rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_charge_path
  end

  def downgrade
    current_user.standard!
    current_user.wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
    flash[:notice] = "You have been downgraded to standard , #{current_user.email}!"
    redirect_to root_path
  end


end
