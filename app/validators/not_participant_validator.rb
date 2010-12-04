class NotParticipantValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless record.trip.nil? || record.trip.participants.find_by_email(value).nil?
      record.errors[attribute] << "is already a participant of that trip."
    end
  end
end
