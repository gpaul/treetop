require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe "#next_node_height is deterministic", :shared => true do
  before do
    node_heights = expected_node_heights.dup
    stub(list).next_node_height { node_heights.shift }
  end
end

describe "it is non-empty", :shared => true do
  specify "#empty? returns false" do
    list.should_not be_empty
  end
end

describe "#nodes is an array of the three inserted nodes in value order", :shared => true do
  specify "#nodes is an array of the three inserted nodes in value order" do
    list.nodes.should == inserted_nodes.sort_by(&:value)
  end
end

describe "it has nil next pointers", :shared => true do
  it "has nil next pointers" do
    inserted_node.next.each do |next_pointer|
      next_pointer.should be_nil
    end
  end
end


describe IntervalSkipList do
  attr_reader :list

  before do
    @list = IntervalSkipList.new
  end

  describe "when nothing has been inserted" do
    specify "#empty? returns true" do
      list.should be_empty
    end

    specify "#nodes returns an empty array" do
      list.nodes.should == []
    end

    describe "#head" do
      attr_reader :head

      before do
        @head = list.head
      end

      it "#has a height of #max_height" do
        head.height.should == list.max_height
      end

      it "has nil next pointers" do
        0.upto(list.max_height - 1) do |i|
          head.next[i].should be_nil
        end
      end
    end
  end

  describe "when 1 has been inserted" do
    attr_reader :inserted_node, :inserted_nodes

    def expected_node_heights
      [1]
    end

    it_should_behave_like "#next_node_height is deterministic"

    before do
      @inserted_node = list.insert(1)
      @inserted_nodes = [@inserted_node]
    end

    it_should_behave_like "it is non-empty"
    it_should_behave_like "#nodes is an array of the three inserted nodes in value order"

    describe "#head" do
      attr_reader :head

      before do
        @head = list.head
      end

      it "has inserted_node.height next pointers pointing at the inserted node" do
        0.upto(inserted_node.height - 1) do |i|
          head.next[i].should == inserted_node
        end
      end

      it "has the rest of its next pointers pointing at nil" do
        inserted_node.height.upto(list.max_height - 1) do |i|
          head.next[i].should == nil
        end
      end
    end

    describe "the inserted node" do
      it_should_behave_like "it has nil next pointers"

      it "has a height of the expected_node_heights.first" do
        inserted_node.height.should == expected_node_heights.first
      end

      it "has a value of 1" do
        inserted_node.value.should == 1
      end
    end
  end

  describe "when 1 and 3 have been inserted in order" do
    attr_reader :inserted_nodes

    def expected_node_heights
      [1, 2]
    end

    it_should_behave_like "#next_node_height is deterministic"

    before do
      @inserted_nodes = []
      inserted_nodes << list.insert(1)
      inserted_nodes << list.insert(3)
    end

    it_should_behave_like "it is non-empty"
    it_should_behave_like "#nodes is an array of the three inserted nodes in value order"

    describe "the first inserted node" do
      attr_reader :inserted_node

      before do
        @inserted_node = inserted_nodes[0]
      end

      it "has a value of 1" do
        inserted_node.value.should == 1
      end

      it "has a height of the first expected node height" do
        inserted_node.height.should == expected_node_heights[0]
      end

      it "has its single next pointer pointing at the second inserted node" do
        inserted_node.next[0].should == inserted_nodes[1]
      end
    end

    describe "the second inserted node" do
      attr_reader :inserted_node
      
      before do
        @inserted_node = inserted_nodes[1]
      end

      it_should_behave_like "it has nil next pointers"

      it "has a value of 3" do
        inserted_node.value.should == 3
      end

      it "has a height of the second expected node height" do
        inserted_node.height.should == expected_node_heights[1]
      end
    end
  end

  describe "when 1, 3 and 7 have been inserted in order" do
    attr_reader :inserted_nodes

    def expected_node_heights
      [1, 2, 1]
    end

    it_should_behave_like "#next_node_height is deterministic"

    before do
      @inserted_nodes = []
      inserted_nodes << list.insert(1)
      inserted_nodes << list.insert(3)
      inserted_nodes << list.insert(7)
    end

    it_should_behave_like "it is non-empty"
    it_should_behave_like "#nodes is an array of the three inserted nodes in value order"

    describe "the first inserted node" do
      attr_reader :inserted_node

      before do
        @inserted_node = inserted_nodes[0]
      end

      it "has a value of 1" do
        inserted_node.value.should == 1
      end

      it "has a height of the first expected node height" do
        inserted_node.height.should == expected_node_heights[0]
      end

      it "has its single next pointer pointing at the second inserted node" do
        inserted_node.next[0].should == inserted_nodes[1]
      end
    end

    describe "the second inserted node" do
      attr_reader :inserted_node

      before do
        @inserted_node = inserted_nodes[1]
      end

      it "has a value of 3" do
        inserted_node.value.should == 3
      end

      it "has a height of the second expected node height" do
        inserted_node.height.should == expected_node_heights[1]
      end

      it "has a next pointer at level 0 pointing to the third inserted node" do
        inserted_node.next[0].should == inserted_nodes[2]
      end

      it "has nil next pointer at level 1" do
        inserted_node.next[1].should be_nil
      end
    end

    describe "the third inserted node" do
      attr_reader :inserted_node

      before do
        @inserted_node = inserted_nodes[2]
      end

      it_should_behave_like "it has nil next pointers"

      it "has a value of 3" do
        inserted_node.value.should == 7
      end

      it "has a height of the third expected node height" do
        inserted_node.height.should == expected_node_heights[2]
      end
    end
  end


  describe "when 7, 1 and 3 have been inserted in order" do
    attr_reader :inserted_nodes

    def expected_node_heights
      [1, 1, 2]
    end

    it_should_behave_like "#next_node_height is deterministic"

    before do
      @inserted_nodes = []
      inserted_nodes << list.insert(7)
      inserted_nodes << list.insert(1)
      inserted_nodes << list.insert(3)
    end

    it_should_behave_like "it is non-empty"
    it_should_behave_like "#nodes is an array of the three inserted nodes in value order"

    describe "the first inserted node" do
      attr_reader :inserted_node

      before do
        @inserted_node = inserted_nodes[0]
      end

      it_should_behave_like "it has nil next pointers"

      it "is the third node in the list" do
        inserted_node.should == list.nodes[2]
      end

      it "has a value of 7" do
        inserted_node.value.should == 7
      end

      it "has a height of the first expected node height" do
        inserted_node.height.should == expected_node_heights[0]
      end
    end

    describe "the second inserted node" do
      attr_reader :inserted_node

      before do
        @inserted_node = inserted_nodes[1]
      end

      it "is the first node in the list" do
        inserted_node.should == list.nodes[0]
      end

      it "has a value of 1" do
        inserted_node.value.should == 1
      end

      it "has a height of the second expected node height" do
        inserted_node.height.should == expected_node_heights[1]
      end

      it "has a next pointer at level 0 pointing to the second node in the list" do
        inserted_node.next[0].should == list.nodes[1]
      end
    end

    describe "the third inserted node" do
      attr_reader :inserted_node

      before do
        @inserted_node = inserted_nodes[2]
      end

      it "is the second node in the list" do
        inserted_node.should == list.nodes[1]         
      end

      it "has a value of 3" do
        inserted_node.value.should == 3
      end

      it "has a height of the third expected node height" do
        inserted_node.height.should == expected_node_heights[2]
      end
    end
  end

end

class IntervalSkipList
  describe Node do
    it "instantiated a next array of nils of size equal to its height" do
      node = Node.new(nil, 3)
      node.next.should == [nil, nil, nil]
    end
  end
end