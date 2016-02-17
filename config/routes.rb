Rails.application.routes.draw do

get '/main' => 'users#index'

get '/dashboard/:id' => 'users#show'

get '/shoes' => 'users#show_all'

get '/purchase/:id' => 'users#create_purchase'

post '/user/create' => 'users#create'

post '/create_product' => 'users#create_product'

post '/user/create_returning_user' => 'users#create_returning_user'

delete '/destroy_product/:id' => 'users#destroy_product'

delete '/user/session' => 'users#delete_session'





# get '/user/:id/edit' => 'users#edit'

# patch '/user/:id/update' => 'users#update'

# post '/user/destroy/:id' => 'users#destroy'

end
