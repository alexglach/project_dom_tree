require 'pry'

class  TreeSearcher


  def initialize(root)
    @root = root

  end

  def search_by(attribute, value)
    attr_s = attribute.to_s
    stack = [@root]
    matches = []
    until stack.empty?
      if stack[0].children.length > 0
        stack[0].children.each do |child|
          stack << child
        end
      end
      if stack[0].attributes.keys.include?(attr_s)
        if stack[0].attributes[attr_s].is_a?Array
          stack[0].attributes[attr_s].each do |att_value|
            if /#{value}/ =~ att_value
              matches << stack[0]
            end
          end
        else
          if /#{value}/ =~ stack[0].attributes[attr_s]
            matches << stack[0]
          end
        end
      end
      stack.shift
    end
    matches
  end


  def search_children(node, attribute, value)
    attr_s = attribute.to_s
    stack = []
    matches = []
    if node.children.length > 0
      node.children.each do |child|
        stack << child
      end
    end
    until stack.empty?
      if stack[0].children.length > 0
        stack[0].children.each do |child|
          stack << child
        end
      end
      if stack[0].attributes.keys.include?(attr_s)
        if stack[0].attributes[attr_s].is_a?Array
          stack[0].attributes[attr_s].each do |att_value|
            if value == att_value
              matches << stack[0]
            end
          end
        else
          if stack[0].attributes[attr_s] == value
            matches << stack[0]
          end
        end
      end
      stack.shift
    end
    matches


  end


  def search_ancestors(node, attribute, value)
    attr_s = attribute.to_s
    stack = []
    matches = []
    if node.parent
      stack << node.parent
    end
    until stack.empty?
      if stack[0].parent
          stack << stack[0].parent
      end
      if stack[0].attributes.keys.include?(attr_s)
        if stack[0].attributes[attr_s].is_a?Array
          stack[0].attributes[attr_s].each do |att_value|
            if value == att_value
              matches << stack[0]
            end
          end
        else
          if stack[0].attributes[attr_s] == value
            matches << stack[0]
          end
        end
      end
      stack.shift
    end
    matches
  end



end