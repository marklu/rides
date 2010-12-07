class HasTripOrganizersValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.empty?
      record.errors[attribute] << "has no trip organizers"
    end
  end
end
