class GuessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if !record.errors.blank? || (record.guesses.exclude? value.downcase)
    record.errors[attribute] << (options[:message] ||
        "already made, pick another letter")
  end
end
