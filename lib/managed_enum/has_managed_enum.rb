module ManagedEnum
	module HasManagedEnum
		extend ActiveSupport::Concern

		included do
		end
		
		module ClassMethods
			
			def has_managed_enum(attribute, possible_keyvalues)
				if possible_keyvalues.is_a? Array
					possible_keyvalues.each do |possible_keyvalue|
						ManagedEnum::HasManagedEnum.define_instance_methods_for attribute, possible_keyvalue, possible_keyvalue
						define_singleton_method possible_keyvalue.upcase do
							possible_keyvalue
						end
						scope "#{attribute}_#{possible_keyvalue}".intern, -> {where(attribute.intern => possible_keyvalue)}
					end
					define_singleton_method "#{attribute}_possible_keyvalues" do
						possible_keyvalues
					end
				elsif possible_keyvalues.is_a? Hash
					possible_keyvalues.each do |possible_keyvalue, possible_value|
						ManagedEnum::HasManagedEnum.define_instance_methods_for attribute, possible_keyvalue, possible_value
						define_singleton_method possible_keyvalue.upcase do
							possible_value
						end
						scope "#{attribute}_#{possible_keyvalue}".intern, -> {where(attribute.intern => possible_value)}
					end
					define_singleton_method "#{attribute}_possible_keyvalues" do
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
			define_method "#{attribute}_as_string" do
				current_value = self.send(attribute)
				all_values = self.class.send("#{attribute}_possible_keyvalues")
				to_return = ''
				if all_values.is_a?(Hash)
					all_values.each do |some_key, some_value|
						if some_value == current_value
							to_return = some_key.to_s
							break
						end
					end
				elsif all_values.is_a?(Array)
					to_return = current_value
				end
				to_return
			end
		end
	end
end

ActiveRecord::Base.send :include, ManagedEnum::HasManagedEnum