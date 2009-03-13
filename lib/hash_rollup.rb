# = Ruby Gem: Hash#rollup
#
# Author:: Joel Parker Henderson, joelparkerhenderson@gmail.com
# Copyright:: Copyright (c) 2007-2009 Joel Parker Henderson
# License:: CreativeCommons License, Non-commercial Share Alike
# License:: LGPL, GNU Lesser General Public License
#
# HashRollup aggregates value for a hash of hashes,
# for example to help calculate subtotals grouped by key.
#
# Example:
#   h={'a'=>{},'b'=>{},'c'=>{}}
#   h['a']['x']=1
#   h['a']['y']=2
#   h['a']['z']=3
#   h['b']['x']=4
#   h['b']['y']=5
#   h['b']['z']=6
#   h['c']['x']=7
#   h['c']['y']=8
#   h['c']['z']=9
#   h.rollup => {"a"=>[1,2,3],"b"=>[4,5,6],"c"=>[7,8,9]} 
#
# = Calculating subtotals 
#                                 
# The rollup method is especially useful for calculating subtotals by key.  
#
# Example:
#   r = h.rollup
#   r['a'].sum => 6
#   r['b'].sum => 15
#   r['c'].sum => 24
#
# = Block customization
#
# You can provide a block that will be called for the rollup items.
#
# Example:
#   h.rollup{|items| items.max } => {"a"=>3,"b"=>6,"c"=>9}
#   h.rollup{|items| items.join("/") } => {"a"=>"1/2/3","b"=>"4/5/6","c"=>"7/8/9"}
#   h.rollup{|items| items.inject{|sum,x| sum+=x } } => {"a"=>6,"b"=>15,"c"=>24}
#
##

module HashRollup

  def rollup(&b)
    a=self.class.new
    each_pair{|k1,v1|
      v1.each_pair{|k2,v2|
        a[k1]=[] if (a[k1]==nil or a[k1]=={})
        a[k1]<<(v2)
      }
    }
    if block_given?
      a.each_pair{|k,v| a[k]=(yield v)}
    end
    a
  end

end

class Hash
 include HashRollup
end
