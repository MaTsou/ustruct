# Ustruct

`Ustruct` is a really tiny class providing an unmutable Struct.

## Installation

This gem is not on rubygems.org. To install it add `gem 'ustruct', git: "https://github.com/MaTsou/ustruct.git"` or clone this repo.

## Usage

```
# creation given named args
foo = Ustruct.new( bar: 'hello', baz: 'world' )
# or given a hash
my_hash = { bar: 'hello', baz: 'world' }
foo = Ustruct.new( my_hash )
# or both
foo = Ustruct.new( { bar: 'hello' }, baz: 'world' )

## accessing content
# with a method call
foo.bar # 'hello'
# like a hash with symbol key
foo[:bar] # 'hello'
# like a hash with string key
foo['baz'] # 'world'
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
