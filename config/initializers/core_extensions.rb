
# aggiunta per il searchable nel cookbook!!!
ActiveRecord::Base.extend Searchable
## Provides to every model the search() capability. In change, you have to implement the searchable_by to let rails know which fields we want

# sembra dare dei problemi
$usa_exception_notification = false