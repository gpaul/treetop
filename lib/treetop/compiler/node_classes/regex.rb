module Treetop
  module Compiler    
    class Regex < AtomicExpression
      def compile(address, builder, parent_expression = nil)
        super
        rx = "%q(#{text_value[2..-2]})" # strip 'r(' and ')'
        
        builder.if__ "(rx_match = regex_match?(#{rx}, index))" do
          assign_result "instantiate_node(#{node_class_name},input, index...(index + rx_match.length))"
          extend_result_with_inline_module
          builder << "@index += rx_match.length"
        end
        builder.else_ do
          builder << "terminal_parse_failure('r(' + #{rx} + ')')"
          assign_result 'nil'
        end
      end
    end
 end
end