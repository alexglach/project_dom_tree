require_relative 'parser'
require_relative 'html_loader'
require_relative 'node_renderer'
require_relative 'tree_searcher'
require_relative 'outputter'


class DOMReader

  attr_reader :root

  def initialize
    @root = nil
    @output = "<!doctype html>\n"
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
      if tag.text_before.length > 0
        @output += ("  " * (tag.depth + 1))
        @output += "#{tag.text_before}\n"
      end
      tag.children.each do |child|
        outputter(child)
      end
      if tag.text_after.length > 0
        @output += ("  " * (tag.depth + 1)) + "#{tag.text_after}\n"
      end
      @output += ("  " * tag.depth)
      @output += "</#{tag.type}>\n"
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

puts d.outputter(d.root)
# searcher = TreeSearcher.new(d.root)
# n = NodeRenderer.new(d.root)
# matches = searcher.search_by(:id, "test")
# puts matches.size
# matches = searcher.search_ancestors(d.root.children[0].children[0], :class,  "test")
# matches.each {|node| n.render(node)}

# n.render(d.root)



