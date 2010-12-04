class LocationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
#    location_types = [
#      'street_address', 'intersection', 'neighborhood', 'subpremise',
#     'premise', 'airport', 'natural_feature', 'park', 'point_of_interest'
#    ]
#    query = Geocoder.search(value) unless value.nil?
#    if query.nil? || (query['results'].first['types'] & location_types).empty?
#      record.errors[attribute] << "is invalid"
#    end
  end
end
