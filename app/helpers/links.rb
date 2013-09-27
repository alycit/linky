def parse_tags(input)
	tags = clean_input(escape_html(input)).split(",")
	tags << "all"
end

def clean_input(text)
	text.gsub(", ", ",").gsub(" ", "_")
end