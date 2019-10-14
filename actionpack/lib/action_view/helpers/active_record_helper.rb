require 'cgi'
require File.dirname(__FILE__) + '/form_helper'

module ActionView
  class Base
    @@field_error_proc = Proc.new{ |html_tag, instance| "<div class=\"fieldWithErrors\">#{html_tag}</div>" }
    cattr_accessor :field_error_proc
  end

  module Helpers
    # The Active Record Helper makes it easier to create forms for records kept in instance variables. The most far-reaching is the form
    # method that creates a complete form for all the basic content types of the record (not associations or aggregations, though). This
    # is a great of making the record quickly available for editing, but likely to prove lacklusters for a complicated real-world form.
    # In that case, it's better to use the input method and the specialized form methods in link:classes/ActionView/Helpers/FormHelper.html
    module ActiveRecordHelper
      # Returns a default input tag for the type of object returned by the method. Example
      # (title is a VARCHAR column and holds "Hello World"):
      #   input("post", "title") =>
      #     <input id="post_title" name="post[title]" size="30" type="text" value="Hello World" />
      def input(record_name, method)
        InstanceTag.new(record_name, method, self).to_tag
      end

      # Returns an entire form with input tags and everything for a specified Active Record object. Example
      # (post is a new record that has a title using VARCHAR and a body using TEXT):
      #   form("post") =>
      #     <form action='create' method='POST'>
      #       <p>
      #         <label for="post_title">Title</label><br />
      #         <input id="post_title" name="post[title]" size="30" type="text" value="Hello World" />
      #       </p>
      #       <p>
      #         <label for="post_body">Body</label><br />
      #         <textarea cols="40" id="post_body" name="post[body]" rows="20" wrap="virtual">
      #           Back to the hill and over it again!
      #         </textarea>
      #       </p>
      #       <input type='submit' value='Create' />
      #     </form>
      #
      # It's possible to specialize the form builder by using a different action name and by supplying another
      # block renderer. Example (entry is a new record that has a message attribute using VARCHAR):
      #
      #   form("entry", :action => "sign", :input_block =>
      #        Proc.new { |record, column| "#{column.human_name}: #{input(record, column.name)}<br />" }) =>
      #
      #     <form action='sign' method='POST'>
      #       Message:
      #       <input id="post_title" name="post[title]" size="30" type="text" value="Hello World" /><br />
      #       <input type='submit' value='Sign' />
      #     </form>
      def form(record_name, options = {})
        record   = instance_eval("@#{record_name}")
        action   = options[:action] || (record.new_record? ? "create" : "update")
        id_field = record.new_record? ? "" : InstanceTag.new(record_name, "id", self).to_input_field_tag("hidden")

        "<form action='#{action}' method='POST'>" +
        id_field + all_input_tags(record, record_name, options) +
        "<input type='submit' value='#{action.gsub(/[^A-Za-z]/, "").capitalize}' />" +
        "</form>"
      end

      # Returns a string containing the error message attached to the +method+ on the +object+, if one exists.
      # This error message is wrapped in a DIV tag, which can be specialized to include both a +prepend_text+ and +append_text+
      # to properly introduce the error and a +css_class+ to style it accordingly. Examples (post has an error message
      # "can't be empty" on the title attribute):
      #
      #   <%= error_message_on "post", "title" %> =>
      #     <div class="formError">can't be empty</div>
      #
      #   <%= error_message_on "post", "title", "Title simply ", " (or it won't work)", "inputError" %> =>
      #     <div class="inputError">Title simply can't be empty (or it won't work)</div>
      def error_message_on(object, method, prepend_text = "", append_text = "", css_class = "formError")
        if errors = instance_eval("@#{object}").errors.on(method)
          "<div class=\"#{css_class}\">#{prepend_text + (errors.is_a?(Array) ? errors.first : errors) + append_text}</div>"
        end
      end

      def error_messages_for(object_name)
        object = instance_eval("@#{object_name}")
        unless object.errors.empty?
          "<div id=\"errorExplanation\">" +
          "<h2>#{object.errors.count} error#{"s" unless object.errors.count == 1} prohibited this #{object_name.gsub("_", " ")} from being saved</h2>" +
          "<p>There were problems with the following fields (marked in red below):</p>" +
          "<ul>#{object.errors.full_messages.collect { |msg| "<li>#{msg}</li>"}}</ul>" +
          "</div>"
        end
      end

      private
        def all_input_tags(record, record_name, options)
          input_block = options[:input_block] || default_input_block
          record.class.content_columns.collect{ |column| input_block.call(record_name, column) }.join("\n")
        end

        def default_input_block
          Proc.new { |record, column| "<p><label for=\"#{record}_#{column.name}\">#{column.human_name}</label><br />#{input(record, column.name)}</p>" }
        end
    end

    class InstanceTag #:nodoc:
      def to_tag(options = {})
        case column_type
          when :string
            field_type = @method_name.include?("password") ? "password" : "text"
            to_input_field_tag(field_type, options)
          when :text
            to_text_area_tag(options)
          when :integer, :float
            to_input_field_tag("text", options)
          when :date
            to_date_select_tag(options)
          when :datetime
            to_datetime_select_tag(options)
          when :boolean
            to_boolean_select_tag(options)
        end
      end

      alias_method :tag_without_error_wrapping, :tag

      def tag(name, options)
        if object.respond_to?("errors") && object.errors.respond_to?("on")
          error_wrapping(tag_without_error_wrapping(name, options), object.errors.on(@method_name))
        else
          tag_without_error_wrapping(name, options)
        end
      end

      alias_method :content_tag_without_error_wrapping, :content_tag

      def content_tag(name, value, options)
        if object.respond_to?("errors") && object.errors.respond_to?("on")
          error_wrapping(content_tag_without_error_wrapping(name, value, options), object.errors.on(@method_name))
        else
          content_tag_without_error_wrapping(name, value, options)
        end
      end

      alias_method :to_date_select_tag_without_error_wrapping, :to_date_select_tag
      def to_date_select_tag(options = {})
        if object.respond_to?("errors") && object.errors.respond_to?("on")
          error_wrapping(to_date_select_tag_without_error_wrapping(options), object.errors.on(@method_name))
        else
          to_date_select_tag_without_error_wrapping(options)
        end
      end

      alias_method :to_datetime_select_tag_without_error_wrapping, :to_datetime_select_tag
      def to_datetime_select_tag(options = {})
        if object.respond_to?("errors") && object.errors.respond_to?("on")
            error_wrapping(to_datetime_select_tag_without_error_wrapping(options), object.errors.on(@method_name))
          else
            to_datetime_select_tag_without_error_wrapping(options)
        end
      end

      def error_wrapping(html_tag, has_error)
        has_error ? Base.field_error_proc.call(html_tag, self) : html_tag
      end

      def error_message
        object.errors.on(@method_name)
      end

      def column_type
        object.send("column_for_attribute", @method_name).type
      end
    end
  end
end
