# frozen_string_literal: true
require 'set'

# unmutable but in Ruby there always is a workaround :
# Ustruct.new( ... ).instance_variable_get( :@content ).merge!( ... )
class Ustruct < BasicObject
  PERMITTED_ARGS = Set.new( :unfrozen )

  def initialize( content = {}, **options )
    @content = content.merge( options )
  end

  def to_hash
    @content
  end

  def method_missing( name, *args )
    Set.new(args).subset?( PERMITTED_ARGS ) ? get( name ) : super
  end

  def []( key, *args )
    get( key, *args )
  end

  private

  def get( key, *args )
    res = @content.fetch( key.to_sym, @content.fetch( key.to_s, nil ) )
    args.include?(:unfrozen) ? res : res.freeze
  end
end
