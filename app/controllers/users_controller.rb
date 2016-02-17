class UsersController < ApplicationController
	before_action :require_login, except: [:index, :create, :create_returning_user, :delete_session]
	before_action :require_correct_user, only: [:show]

	def index
	end

	def create
			@new_user = User.create(name:params[:name], last:params[:last], email: params[:email], password:params[:password])
			if @new_user.invalid? 
				flash[:error] = @new_user.errors.full_messages
				redirect_to '/main'
			else
				@users = User.last
				session[:user_id] = @users.id
				redirect_to '/dashboard/%d' % @users.id
			end
	end	

	def create_returning_user
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			session[:name] = user.name
			redirect_to '/dashboard/%d' % session[:user_id], :notice => "Logged in!"
		else
			flash[:errors] = 'Invalid email or password'
			redirect_to '/main'
		end
	end

	def create_product
		@user = User.find(session[:user_id])
		@product = Product.create(prod:params[:prod], amt:params[:amt], user:User.find(session[:user_id]))
		@product_all = Product.where(user:User.find(session[:user_id]))
		redirect_to '/dashboard/%d' % @user.id
	end

	def create_purchase
		@purchase = Purchase.create(product:Product.find(params[:id]), user:User.find(session[:user_id]))
		redirect_to '/dashboard/%d' % session[:user_id]
	end

	def show
		@user = User.find(session[:user_id])
		@product_all = Product.where(user:User.find(session[:user_id]))
		# @purch = Purchase.joins(:user).joins(:product).select('products.prod,purchases.created_at,products.user_id as products_user_id,users.name, products.amt, purchases.user_id as seller_id').where(user:User.find(session[:user_id]))
		# render :text => @purch.name
	end

	def show_all
		@user = User.find(session[:user_id])
		@products = Product.joins(:user).select('products.id as product_id, users.name, users.last,products.prod, products.amt,products.created_at')
		@product = Product.all
	end



	def edit
		@user = User.find(session[:user_id])
	end

	def update
		@updated_user = User.find(session[:user_id])
		@user = @updated_user.update_attributes(name:params[:name],email:params[:email],password:params[:password])
		redirect_to '/dashboard/%d' % @updated_user.id
	end

	def destroy_product
		Product.destroy(params[:id])
		redirect_to '/dashboard/%d' % session[:user_id]
	end

	def destroy
		@user = User.destroy(session[:user_id])
		session.clear
		redirect_to '/main'
	end

	def delete_session
		# session.clear
		session[:user_id] = nil
		redirect_to '/main'
	end

end


# <% @purch.each do |y| %>
# 	<tr>
# 		<td><%= y.prod %></td>
# 		<td><%= y.created_at %></td>
# 		<td><%= y.id %></td>
# 		<td>$<%= y.amt %></td>
# 	</tr>
# 	<% end %>
