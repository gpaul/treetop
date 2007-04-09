dir = File.dirname(__FILE__)
require "#{dir}/protometagrammar/protometagrammar"
require "#{dir}/protometagrammar/grammar_expression_builder"
require "#{dir}/protometagrammar/parsing_rule_sequence_expression_builder"
require "#{dir}/protometagrammar/parsing_rule_expression_builder"
require "#{dir}/protometagrammar/primary_expression_builder"
require "#{dir}/protometagrammar/nonterminal_symbol_expression_builder"
require "#{dir}/protometagrammar/terminal_symbol_expression_builder"
require "#{dir}/protometagrammar/character_class_expression_builder"
require "#{dir}/protometagrammar/anything_symbol_expression_builder"
require "#{dir}/protometagrammar/sequence_expression_builder"
require "#{dir}/protometagrammar/suffix_expression_builder"
require "#{dir}/protometagrammar/prefix_expression_builder"
require "#{dir}/protometagrammar/ordered_choice_expression_builder"
require "#{dir}/protometagrammar/node_class_eval_block_expression_builder"
require "#{dir}/protometagrammar/trailing_block_expression_builder"