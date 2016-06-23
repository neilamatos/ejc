class DateTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    date_only = options[:date_only] || false

    if !date_only # datetime
      record.errors.add(attr_name, 'deve ser uma data e hora válida') if ((Date._strptime(value, '%d/%m/%Y %H:%M') rescue ArgumentError) == ArgumentError)
    else # only date
      record.errors.add(attr_name, 'deve ser uma data válida') if ((Date._strptime(value, '%d/%m/%Y') rescue ArgumentError) == ArgumentError)
    end
  end
end
