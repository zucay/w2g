# -*- coding: utf-8 -*-
class ReaderWriter
  def self.read_core(project, basefile=nil)
    # mymatrixがwww上のファイルを扱えないため一工夫 ここから
    str = project.base_file.url
    filename = 'tmp.txt'
    if(str =~ /\.csv/i)
      filename = 'tmp.csv'
    end
    if(str =~ /\.xls/i)
      filename = 'tmp.xls'
    end

    open(filename, 'wb') do |fo|
      data = open(project.base_file.url).read
      fo.write(data)
    end
    basefile ||= filename
    # mymatrixがwww上のファイルを扱えないため一工夫 ここまで
    
    if(!basefile || !project.header)
      raise 'basefile and header are needed.'
    end

    
    mx = MyMatrix.new(basefile)
    yield(mx)
  end
  # external interface
  def self.read(project, file=nil)
    label_cols = project.header.label_cols
    read_core(file) do |mx|
      headers = mx.getHeaders
      mx.each do |row|
        sp = Spot.new({:project_id => project.id})
        fill_value(sp, label_cols, mx, row, headers)
        sp.save
      end
    end
  end
  def self.fill_value(sp, label_cols, mx, row, headers)
    headers.each do |head|
      if(label_cols[head])
        sp[label_cols[head]] = mx.val(row, head)
      end
    end
  end
  def self.readable?(file=nil)
    out = true
    label_cols = project.header.label_cols
    read_core(file) do |mx|
      #check header
      headers = []
      mx.getHeaders.each do |head|
        if(!label_cols[head])
          p "#{head} notfound."
          out = false
        end
      end
    end
    return out
  end
end

