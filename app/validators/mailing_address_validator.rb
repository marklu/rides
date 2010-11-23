#class MailingAddressValidator < ActiveModel::EachValidator
#  def validate_each(record, attribute, value)
#    query = Geocoder.search(value) unless value.nil?
#    if query.nil? || query['results'].find {|r| r['types'].include? 'street_address'}.nil?
#      record.errors[attribute] << "must be a valid street address"
#    end
#  end
#end
