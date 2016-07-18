require_relative 'parser'
require_relative 'html_loader'
require_relative 'node_renderer'
require_relative 'tree_searcher'


class DOMReader

  attr_reader :root

  def initialize
    @root = nil
    @output = ''
  end


  def build_tree(path) 
    str = HTMLLoader.new.load(path)
    parser = Parser.new(str)
    parser.parser_script
    @root = parser.root
  end

  def outputter(tag)
    if tag.children == []
      @output += ("  " * tag.depth)
      @output += "<#{tag.type} #{output_class(tag.attributes)}> #{tag.text_before} #{tag.text_after} </#{tag.type}>\n"
      return
    else
      @output += ("  " * tag.depth)
      @output += "<#{tag.type} #{output_class(tag.attributes)}>\n"
      @output += ("  " * (tag.depth + 1))
      @output += "#{tag.text_before}\n"
      tag.children.each do |child|
        outputter(child)
      end
      @output += ("  " * tag.depth)
      @output += "#{tag.text_after}</#{tag.type}>\n"
    end
    @output
  end

  def output_class(hash)
    output = ""
    return output if hash.nil?
    hash.each do |key, value|
      if value.is_a? String
        output += (key + "=" + "'#{value}'" + " ")
      else
        output += (key + "=" + "'")
        value.each do |value|
          output += value + " "
        end
        output[-1] = "'"
      end
    end
    output 


  end


end

d = DOMReader.new
d.build_tree('test.html')
searcher = TreeSearcher.new(d.root)
n = NodeRenderer.new(d.root)
matches = searcher.search_children(d.root, :text, "test")
puts matches.size
# tests = searcher.search_ancestors(d.root.children[0].children[0], :class,  "test")
matches.each {|node| n.render(node)}

# n.render(d.root)



