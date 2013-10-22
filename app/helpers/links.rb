def parse_tags(input)
	tags = clean_input(escape_html(input)).split(",")
	tags << "all"
end

def clean_input(text)
	text.gsub(", ", ",").gsub(" ", "_")
end

def bookmarklet
	"javascript: (function() {var win=window.open('http://#{generate_url}/add_link_to_user?ids[]=#{current_user.id}&url=' + window.location.href, '_blank');win.focus();})();"
end


