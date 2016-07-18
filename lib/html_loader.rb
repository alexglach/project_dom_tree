class HTMLLoader

  def load(path)
    file = File.open(path, "rb")
    str = file.read
    str.gsub(/\n/, "")
  end




end
