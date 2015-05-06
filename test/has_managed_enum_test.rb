require 'test_helper'
require 'managed_enum/has_managed_enum'

class HasManagedEnumTest < ActiveSupport::TestCase
	test "truth" do
		assert_kind_of Module, ManagedEnum::HasManagedEnum
	end

	def test_person_possible_age_phase_values
		age_phases = {baby: 10, child: 20, young: 30, man: 40, old: 50}
		assert_equal age_phases, Person.age_phase_possible_keyvalues
	end
	
	def test_person_possible_status_values
		statuses = %w(employed self-employed entrepreneur unemployed)
		assert_equal statuses, Person.status_possible_keyvalues
	end
	
	def test_person_age_phase
		age_phases = {baby: 10, child: 20, young: 30, man: 40, old: 50}
		age_phases.each do |age_phase_name, age_phase_limit|
			assert_equal age_phase_limit, Person.send(age_phase_name.upcase)
		end
	end
	
	def test_person_age_phase
		statuses = %w(employed self-employed entrepreneur unemployed)
		statuses.each do |status|
			assert_equal status, Person.send(status.upcase)
		end
	end
	
	def test_a_person_should_become_a_baby
		person = Person.new
		assert_equal false, person.baby?
		person.make_baby
		assert_equal true, person.baby?
		assert_equal 10, person.age_phase
	end
	
	def test_a_person_should_become_an_unemployed
		person = Person.new
		assert_equal false, person.unemployed?
		person.make_unemployed
		assert_equal true, person.unemployed?
		assert_equal 'unemployed', person.status
	end
end
