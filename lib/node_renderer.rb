require 'pry'

class NodeRenderer


  def initialize(root)
    @root = root
  end


  def render(node=@root)
    puts "Total nodes below '#{node.type}': #{total_nodes_below(node)}"
    puts
    puts "Node Types:"
    node_types_below(node).each do |key, value|
      puts "#{key}: #{value}"
    end
    puts
    puts "Node's data: #{node_data(node)}"
    puts
  end


  def total_nodes_below(node)
    total_nodes = -1
    stack = [node]
    until stack.empty?
      if stack[0].children.length > 0
        stack[0].children.each do |child|
          stack << child
        end
      end
      stack.shift
      total_nodes += 1
    end
    total_nodes
  end



  def node_types_below(node)
    node_types = {}
    stack = []
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
      if node_types.keys.include?(stack[0].type)
        node_types[(stack[0].type)] += 1
      else
        node_types[(stack[0].type)] = 1
      end
      stack.shift
    end
    node_types
  end


  def node_data(node)
    output = ""
    node.attributes.each do |key, value|
      if value.is_a? String
        output += "#{key}: '#{value}' \n"
      else
        output += "#{key}: '"
        value.each do |value|
          output += "#{value}' '"
        end
        output[-1] = ""
      end
    end
    output
  end



end