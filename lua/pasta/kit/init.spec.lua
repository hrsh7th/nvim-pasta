local kit = require('pasta.kit')

describe('kit', function()
  describe('.merge', function()
    it('should merge two dict', function()
      assert.are.same(
        kit.merge({
          a = true,
          b = {
            c = vim.NIL,
          },
          d = {
            e = 3,
          },
        }, {
          a = false,
          b = {
            c = true,
          },
          d = {
            f = {
              g = vim.NIL,
            },
          },
        }),
        {
          a = true,
          b = {},
          d = {
            e = 3,
            f = {},
          },
        }
      )
    end)
  end)

  describe('.concat', function()
    it('should concat two list', function()
      assert.are.same(kit.concat({ 1, 2, 3 }, { 4, 5, 6 }), { 1, 2, 3, 4, 5, 6 })
    end)
  end)

  describe('.to_array', function()
    it('should convert value to array', function()
      assert.are.same(kit.to_array(1), { 1 })
      assert.are.same(kit.to_array({ 1, 2, 3 }), { 1, 2, 3 })
      assert.are.same(kit.to_array({}), {})
      assert.are.same(kit.to_array({ a = 1 }), { { a = 1 } })
    end)
  end)

  describe('.is_array', function()
    it('should check array or not', function()
      assert.are.equal(kit.is_array({}), true)
      assert.are.equal(kit.is_array({ 1 }), true)
      assert.are.equal(kit.is_array({ a = 1 }), false)
      assert.are.equal(kit.is_array(1), false)
    end)
  end)

  describe('.reverse', function()
    it('should reverse the array', function()
      assert.are.same(kit.reverse({ 1, 2, 3 }), { 3, 2, 1 })
    end)
  end)

  describe('.default', function()
    it('should return default value', function()
      assert.are.equal(kit.default(nil, 1), 1)
      assert.are.equal(kit.default(false, {}), false)
      assert.are.equal(kit.default(2, 1), 2)
    end)
  end)

  describe('.get', function()
    it('should return value of the paths', function()
      assert.are.equal(kit.get({ a = { b = 1 } }, { 'a', 'b' }), 1)
      assert.are.equal(kit.get({ a = { b = 1 } }, { 'a', 'c' }), nil)
      assert.are.equal(kit.get({ a = { b = 1 } }, { 'a', 'c' }, 2), 2)
      assert.are.equal(kit.get({ a = { b = { 1 } } }, { 'a', 'b', 1 }), 1)
      assert.are.equal(kit.get({ a = { b = { 1 } } }, { 'a', 'b', 2 }), nil)
    end)
  end)
end)
