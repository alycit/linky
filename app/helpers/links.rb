def parse_tags(input)
	clean_input(input).split(",")
end

def clean_input(text)
	text.gsub(", ", ",").gsub(" ", "_")
end