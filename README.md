# ManagedEnum

A ruby gem for adding managed enumerated fields functionality to ActiveRecord models. This code is published under the MIT-LICENSE.

## Installation

This gem was developed and tested for rails 3.2.17 on ruby 1.9.3.
```
gem install managed_enum
```

## Usage

The main method is has_managed_enum. This method takes a symbol (attribute name) as the first argument, and either 
an array or a hash for the second argument. If you are intending to save the enumerated field as string, send an array 
of possible key values. If you are intending to save the enumerated field as integer, send a hash containing keys as 
names (to be used in your code) and values (to be saved in database for faster searching and indexing).

```ruby
class Person < ActiveRecord::Base
  attr_accessible :age_phase, :name, :status
  
  has_managed_enum :age_phase, {baby: 10, child: 20, young: 30, man: 40, old: 50}
  has_managed_enum :status, %w(employed self_employed entrepreneur unemployed)
end
```
Now you are free to use a bunch of useful class and instance methods.

```ruby
# CLASS METHODS
Person.age_phase_possible_keyvalues
# => {baby: 10, child: 20, young: 30, man: 40, old: 50}

Person.status_possible_keyvalues
# => ["employed", "self_employed", "entrepreneur", "unemployed"]

Person.BABY
# => 10

Person.CHILD
# => 20

Person.EMPLOYED
# => "employed"

Person.SELF_EMPLOYED
# => "self_employed"

# INSTANCE METHODS
person = Person.new

person.baby?
# => returns false
person.make_baby
# => 10
person.baby?
# => returns true

person.employed?
# => returns false
person.make_employed
# => "employed"
person.employed?
# => returns true

## Contribution
Feel free to contribute for upward compatibility, better coding style or adding functionality. 