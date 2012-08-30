# Include hook code here

unless Rails::VERSION::MAJOR == 2 && Rails::VERSION::MINOR >= 2
  raise "This version of ActiveScaffold requires Rails 2.2 or higher. 
  Please use an earlier version. Ah, sorry...it wasnt invented yet? Well, this is future, be patient :P
  
  -- Riccardo C."
end

ActiveRecord::Base.send :include, ActsAsCarlesso