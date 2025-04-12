# frozen_string_literal: true

# unmutable but in Ruby there always is a workaround :
# Ustruct.new(...).instance_variable_get(:@content).merge!(...)
class Ustruct < BasicObject
  def initialize(content = {}, **options)
    @content = duplicate(content).merge duplicate(options)
  end

  def to_hash
    @content
  end

  def method_missing(name, *args)
    args.empty? ? get(name) : super
  end

  def [](key)
    get(key)
  end

  private

  def respond_to_missing?(name, *_args)
    args.empty? && get(name)
  end

  def duplicate(hash)
    hash.transform_values(&:dup)
  end

  def get(key)
    @content.fetch(key.to_sym, @content.fetch(key.to_s, nil)).dup
  end
end
