module ApplicationHelper

	def error_messages_for(object)
		render(:partial => 'application/error_messages', :locals => {:object => object})
	end

	def status_tag(boolean, options={})
		options[:true_text] ||= ''
		options[:false_text] ||= ''

		if boolean
			content_tag(:span, options[:true_text], :class => 'glyphicon glyphicon-check text-success')
		else
			content_tag(:span, options[:false_text], :class => 'glyphicon glyphicon-unchecked text-danger')
		end
	end
	
end
