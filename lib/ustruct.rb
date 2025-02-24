# frozen_string_literal: true

# unmutable but in Ruby there always is a workaround :
# Ustruct.new( ... ).instance_variable_get( :@content ).merge!( ... )
class Ustruct < BasicObject
  def initialize( content = {}, **options )
    @content = duplicate(content).merge( duplicate options )
  end

  def to_hash
    @content
  end

  def method_missing( name, *args )
    args.empty? ? get( name ) : super
  end

  def []( key )
    get( key )
  end

  private

  def duplicate( hash )
    hash.map do |k,v|
      [k, v.dup]
    end.to_h
  end

  def get( key )
    @content.fetch( key.to_sym, @content.fetch( key.to_s, nil ) ).dup
  end
end
