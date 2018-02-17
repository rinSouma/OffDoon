module ApplicationHelper
  require "uri"
  
  def text_url_to_link text
  
    URI.extract(text, ['http','https']).uniq.each do |url|
      sub_text = ""
      unless url.match(/(\.jpg|\.jpeg|\.png|\.gif)/)
        sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      else
        sub_text << "<img src=" << url << " style=\"max-width:400px; \" />"
      end

      text.gsub!(url, sub_text)
    end
  
    return text
  end
end
