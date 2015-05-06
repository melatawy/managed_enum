class Person < ActiveRecord::Base
  attr_accessible :age_phase, :name, :status
  
  has_managed_enum :age_phase, {baby: 10, child: 20, young: 30, man: 40, old: 50}
  has_managed_enum :status, %w(employed self-employed entrepreneur unemployed)
end
