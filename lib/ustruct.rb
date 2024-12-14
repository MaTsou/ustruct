# frozen_string_literal: true

require_relative "ustruct/version"

class Ustruct
  def initialize( content = {}, **options )
    @content = content.merge( options )
  end

  def debug( keys = false )
    keys ? @content.keys : @content
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
    @content.fetch( key.to_sym, @content.fetch( key.to_s, nil ) )
  end
end
