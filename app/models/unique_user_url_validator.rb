class UniqueUserUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "can only be saved once by a user") unless url_unique?(record, value)    
  end

  def url_unique?(record, input_url)
    Link.where(user_id: record.user_id, url: input_url).count == 0
  end 
end