# frozen_string_literal: true

# unmutable but in Ruby there always is a workaround :
# Ustruct.new( ... ).instance_variable_get( :@content ).merge!( ... )
class Ustruct < BasicObject
  def initialize( content = {}, **options )
    @content = content.merge( options )
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

  def get( key )
    @content.fetch( key.to_sym, @content.fetch( key.to_s, nil ) ).freeze
  end
end
