class HTMLLoader

  def load(path)
    file = File.open(path, "rb")
    str = file.read
    file.close
    str.gsub!(/<!doctype html>/, '')
    str.gsub(/\n/, "")




  end




end
