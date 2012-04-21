module Enumerable
  def verbose_each_with_index
    siz = self.size
    cnt = 10
    if(siz > 200)
      cnt = 100
    end
    self.each_with_index do |ele, i|
      if(i%cnt == 0)
        p "#{i+1}/#{siz}"
      end
      yield(ele, i)
    end
  end
  def verbose_each
    verbose_each_with_index do |ele, i|
      yield(ele)
    end
  end
end