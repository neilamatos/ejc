class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors.add attr_name, options[:message] || :invalid_email
    end
  end
end
