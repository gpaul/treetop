require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

module RegexSpec
  
  class Foo < Treetop::Runtime::SyntaxNode
  end

  describe "a simple regex" do
    testing_expression "r(a+bc) <RegexSpec::Foo> { def a_method; end }"

    it "correctly parses matching input" do
      parse "aaaaabc", :index => 0 do |result|
        result.text_value.should == 'aaaaabc'
        result.should be_an_instance_of(Foo)
        result.should respond_to(:a_method)
        result.interval.should == (0...7)
      end
    end
    
    it "fails to parse nonmatching input at the index even if a match occurs later" do
      parse(" abc", :index =>  0).should be_nil
    end

  end

end
