module ManagedEnum
	module HasManagedEnum
		extend ActiveSupport::Concern

		included do
		end
		
		module ClassMethods
			
			def has_managed_enum(field, possible_keyvalues)
				if possible_keyvalues.is_a? Array
					possible_keyvalues.each do |possible_keyvalue|
						ManagedEnum::HasManagedEnum.define_instance_methods_for field, possible_keyvalue, possible_keyvalue
						define_singleton_method possible_keyvalue.upcase do
							possible_keyvalue
						end
						scope "#{field}_#{possible_keyvalue}".intern, -> {where(field.intern => possible_keyvalue)}
					end
					define_singleton_method "#{field}_possible_keyvalues" do
						possible_keyvalues
					end
				elsif possible_keyvalues.is_a? Hash
					possible_keyvalues.each do |possible_keyvalue, possible_value|
						ManagedEnum::HasManagedEnum.define_instance_methods_for field, possible_keyvalue, possible_value
						define_singleton_method possible_keyvalue.upcase do
							possible_value
						end
						scope "#{field}_#{possible_keyvalue}".intern, -> {where(field.intern => possible_value)}
					end
					define_singleton_method "#{field}_possible_keyvalues" do
						possible_keyvalues
					end
				end
			end
		end
		
		def self.define_instance_methods_for(attribute, possible_keyvalue, possible_value)
			define_method "#{possible_keyvalue}?" do
				self.send(attribute) == possible_value
			end
			
			define_method "make_#{possible_keyvalue}" do
				self.send "#{attribute}=", possible_value
			end
		end
	end
end

ActiveRecord::Base.send :include, ManagedEnum::HasManagedEnum