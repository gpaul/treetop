module Treetop
  module Compiler    
    class Regex < AtomicExpression
      def compile(address, builder, parent_expression = nil)
        super
        
        # I really think there should be 4 slashes in that replacement string, but 6 works. Deeply weird
        rx = text_value[2..-2].gsub("\\", "\\\\\\") # strip 'r(' and ')'
        rx = "%(#{rx})" 
        
        builder.if__ "(rx_match = regex_match?(#{rx}, index))" do
          assign_result "instantiate_node(#{node_class_name},input, index...(index + rx_match.length))"
          extend_result_with_inline_module
          builder << "@index += rx_match.length"
        end
        builder.else_ do
          builder << "terminal_parse_failure('/' + #{rx} + '/')"
          assign_result 'nil'
        end
      end
    end
 end
end