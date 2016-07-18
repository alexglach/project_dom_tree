class Outputter


  def initialize(root)
    puts outputter(root)
    @output = ''
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