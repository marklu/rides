class LocationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    query = Geocoder.search(value) unless value.nil?
    if query.nil? || query['results'].find {|r| r['types'].include? 'street_address'}.nil?
      record.errors[attribute] << "must point to a valid location"
    end
  end
end
