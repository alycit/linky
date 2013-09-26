class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid URL") unless url_valid?(value)    
  end

  def url_valid?(input_url)
    url = URI.parse(input_url) rescue false
    (url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)) && starts_properly?(input_url)
  end 

  def starts_properly?(url)
  	url.start_with?("http://") || url.start_with?("https://")
  end
end