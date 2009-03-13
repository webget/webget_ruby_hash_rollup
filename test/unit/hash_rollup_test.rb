require 'test/unit'
require 'hash_rollup'

class Testing < Test::Unit::TestCase

 def setup
  @h=Hash.new
  @h['a']=Hash.new
  @h['b']=Hash.new
  @h['c']=Hash.new
  @h['a']['x']='m'
  @h['a']['y']='n'
  @h['a']['z']='o'
  @h['b']['x']='p'
  @h['b']['y']='q'
  @h['b']['z']='r'
  @h['c']['x']='s'
  @h['c']['y']='t'
  @h['c']['z']='u'
 end

 def test_hash_rollup
  r=@h.rollup
  assert_equal(['a','b','c'], r.keys.sort)
  assert_equal(['m','n','o'], r['a'].sort)
  assert_equal(['p','q','r'], r['b'].sort)
  assert_equal(['s','t','u'], r['c'].sort)
 end

 def test_block
   r = @h.rollup{|items| items.sort.inject{|sum,x| sum+=x}}
   assert_equal(['a','b','c'], r.keys.sort)
   assert_equal('mno', r['a'])
   assert_equal('pqr', r['b'])
   assert_equal('stu', r['c'])
 end

end




