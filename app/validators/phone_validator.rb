#!/bin/env ruby
# encoding: utf-8
class PhoneValidator < ActiveModel::EachValidator
  # first 2 digits represent dialing code
  # dialing codes in Brazil don't start with 0
  #
  # the following represent the phone
  # must have 8 digits
  # first digit must start with 2, 3, 4, 5 or 6
  #
  LANDLINE_REGEXP = /\A[1-9]\d[2-6]\d{7}\z/

  # first 2 digits represent dialing code
  # dialing codes in Brazil don't start with 0
  #
  # the following represent the phone
  # must have 8 digits
  # might have 9 if dialing code is 11, 12, 13, 14, 15, 16, 17, 18 or 19
  # first digit must start with 7, 8 or 9
  # might start with 5 as well if dialing code is 11
  #
  MOBILE_REGEXP = /\A(11(5|[7-9])\d{7,8}|1[2-9][7-9]\d{7,8}|[2-9]\d[7-9]\d{7,8})\z/

  def validate_each(record, attr_name, value)
    message = options[:mobile] ?
      "número de celular inválido" :
      "número de telefone inválido"

    value = value.gsub('(','').gsub(')','').gsub(' ','').gsub('-',"") if !value.blank?

    if !value.blank?
      # only mobile phones
      if options[:mobile]
        unless value =~ MOBILE_REGEXP
          record.errors.add attr_name, options[:message] || message
        end
      else # can be mobile or landline phone
        if !((value =~ MOBILE_REGEXP) || (value =~ LANDLINE_REGEXP))
          record.errors.add attr_name, options[:message] || message
        end
      end
    end
  end
end
