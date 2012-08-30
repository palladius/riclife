class RecipesController < ApplicationController
   active_scaffold :recipe do |config|
    list.columns.exclude :created_at, :updated_at
   end
 end
