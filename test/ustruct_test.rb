require_relative 'test_helper'
require_relative '../lib/ustruct'

describe Ustruct do

  describe "Initialize" do
    before do
      @foo = { bar: 'hello', baz: 'world' }
    end

    it "can receive a hash" do
      _( Ustruct.new( @foo ).to_hash ).must_equal @foo
    end

    it "can receive named args" do
      _( Ustruct.new( **@foo ).to_hash ).must_equal @foo
    end

    it "can receive both hash and named args" do
      foo = @foo.reject { |k,v| k == :baz }
      _( Ustruct.new( foo, baz: 'world' ).to_hash ).must_equal @foo
    end
  end

  describe "Accessors" do
    before do
      @my_hash = {
        hello: "world",
        bonjour: String( "le monde" ),
        ciao: [ 1, 'a', Object.new ]
      }
      @context = Ustruct.new( @my_hash )
    end

    it "transforms given hash keys into methods" do
      @my_hash.keys.each do |key|
        _(@context.send( key )).must_equal @my_hash[key]
      end
    end

    it "keeps hash [] syntax to acceed values" do
      @my_hash.keys.each do |key|
        _(@context[key.to_sym]).must_equal @my_hash[key]
        _(@context[key.to_s]).must_equal @my_hash[key]
      end
    end

    it "do not accept any writing attemps" do
      _{ @context[:hello] = 'moon' }.must_raise NoMethodError
      _{ @context.hello = 'moon' }.must_raise NoMethodError
    end

    it "raise method missing when args passed" do
      _{ @context.hello( 1 ) }.must_raise NoMethodError
    end
  end
end
