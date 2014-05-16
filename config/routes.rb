AdventureLibrary::Application.routes.draw do
  # new app
  root 'adventures#index'

  resources :libraries do
    resources :adventures
  end
  resources :adventures do
    resources :pages
  end

#                 Prefix Verb   URI Pattern                                          Controller#Action
#                   root GET    /                                                    libraries#index
#     library_adventures GET    /libraries/:library_id/adventures(.:format)          adventures#index
#                        POST   /libraries/:library_id/adventures(.:format)          adventures#create
#  new_library_adventure GET    /libraries/:library_id/adventures/new(.:format)      adventures#new
# edit_library_adventure GET    /libraries/:library_id/adventures/:id/edit(.:format) adventures#edit
#      library_adventure GET    /libraries/:library_id/adventures/:id(.:format)      adventures#show
#                        PATCH  /libraries/:library_id/adventures/:id(.:format)      adventures#update
#                        PUT    /libraries/:library_id/adventures/:id(.:format)      adventures#update
#                        DELETE /libraries/:library_id/adventures/:id(.:format)      adventures#destroy
#              libraries GET    /libraries(.:format)                                 libraries#index
#                        POST   /libraries(.:format)                                 libraries#create
#            new_library GET    /libraries/new(.:format)                             libraries#new
#           edit_library GET    /libraries/:id/edit(.:format)                        libraries#edit
#                library GET    /libraries/:id(.:format)                             libraries#show
#                        PATCH  /libraries/:id(.:format)                             libraries#update
#                        PUT    /libraries/:id(.:format)                             libraries#update
#                        DELETE /libraries/:id(.:format)                             libraries#destroy
#        adventure_pages GET    /adventures/:adventure_id/pages(.:format)            pages#index
#                        POST   /adventures/:adventure_id/pages(.:format)            pages#create
#     new_adventure_page GET    /adventures/:adventure_id/pages/new(.:format)        pages#new
#    edit_adventure_page GET    /adventures/:adventure_id/pages/:id/edit(.:format)   pages#edit
#         adventure_page GET    /adventures/:adventure_id/pages/:id(.:format)        pages#show
#                        PATCH  /adventures/:adventure_id/pages/:id(.:format)        pages#update
#                        PUT    /adventures/:adventure_id/pages/:id(.:format)        pages#update
#                        DELETE /adventures/:adventure_id/pages/:id(.:format)        pages#destroy
#             adventures GET    /adventures(.:format)                                adventures#index
#                        POST   /adventures(.:format)                                adventures#create
#          new_adventure GET    /adventures/new(.:format)                            adventures#new
#         edit_adventure GET    /adventures/:id/edit(.:format)                       adventures#edit
#              adventure GET    /adventures/:id(.:format)                            adventures#show
#                        PATCH  /adventures/:id(.:format)                            adventures#update
#                        PUT    /adventures/:id(.:format)                            adventures#update
#                        DELETE /adventures/:id(.:format)                            adventures#destroy


end
