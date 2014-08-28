# Array::Subindex

Are you tired of The Man getting you down by only letting you use whole
integers as array indexes? Who isn't, dude! Seriously, who is The Man anyway?

Now you can get back at "The Man", in Ruby at least:

```ruby
[1,2,3][0.5] == 1.5

%w[ foo bar baz ][1.3] == "arb"

[8,9][Rational(2,5)] == 8.4

[ [1,2], [3,4] ][0.5] == 2.5
``` 

The inspiration:

<blockquote class="twitter-tweet" lang="en"><p>&quot;Should array indices start at 0 or 1? My compromise of 0.5 was rejected without, I thought, proper consideration.&quot; — Stan Kelly-Bootle</p>&mdash; Usman Masood (@usmanm) <a href="https://twitter.com/usmanm/statuses/410449694603485184">December 10, 2013</a></blockquote><script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

This gem is postumously dedicated to <a href="http://en.wikipedia.org/wiki/Stan_Kelly-Bootle">Stan Kelly-Bootle</a>. I would like to think he'd approve of this sort misuse of technology.

## Installation

You shouldn't really use this gem. Ever. Really, don't.

Ok, ok, you can use is as long as you promise to *never* use it in a
production environment. Clear?  Good.

    $ gem install array-subindex

..then..

```ruby
require 'array/subindex'
```

..and then go pour yourself a stiff drink because, baby, you're going to need it. In fact, you should make it a double just to be safe.

## Usage

This gem overrides the Ruby core Array#[] method. **Do I sound crazy yet? Because I should.** If a
"normal" integer index is used, the method behaves as the untainted Array class would:

```ruby
[1,2][0] == 1
```

However, if the method detects that the index passed is not an integer
but is still a valid number class, the method will return the correct portions of the appropriate indicies.

In the case of an array of numbers (int, float, real), it gets portions of the
adjacent values, adds them, and returns them. For example:

```ruby
[1,2,3][1.5] == 2.5
# 1/2 of index 2 + 1/2 of index 3
```

It also works for unequal devisions (e.g. indexes other than 0.5):

```ruby
[1,2,3][0.25] == 1.25
# 3/4 of index 0 + 1/4 of index 1
```

In the case of irrational divisions, the results are rounded:

```ruby
[1,2,3][1.001] == 2.001
```

You can use other number classes, too:

```ruby
[8,9][Rational(2,5)] == 8.4

[3,4,5][BigDecimal.new("1.5")] == 4.3
```

For arrays of strings, a concatination of portions of the values are used:

```ruby
[ "this", "is", "a", "test" ][0.5] == "isi"
# 1/2 of index 0 ("is") added to half of index 1 ("i")
```

For unevenly dividable strings, the index is rounded down:

```ruby
[ "foo", "bar", "baz" ][0.5] == "oob"
```

_BONUS LEVEL_

For arrays that contain arrays, hashes, or anything that responds like an
array, we will get the appropriate index values in those and then concat
or add them as appropriate:

```ruby
[ [ 1, 2 ], [ 3, 4] ][0.5] == 2.5
# [2] + [3], then 0.5 of result

[ [ "foo", "bar" ], [ "baz", "qux" ] ][0.5] == "arb"
# 1/2 of "bar" (rounded up to 2/3) + 1/2 of "baz" (rounded down to 1/3)

# works with hashes, too!
[ ['foo'], { bar: 'baz' } ][0.5] == 'oobar'
# 1/2 of "foo" round up to 2/3 + hash.to_a -> 1/2 of first value
```

## License

Distributed under the [WTFPL](https://github.com/rlespinasse/WTFPL) license.

## Contributing

1. Don't. Stop encouraging me to commit sins like this.

## Bling

> VERY [![Code Climate](https://codeclimate.com/github/xunker/array-subindex/badges/gpa.svg)](https://codeclimate.com/github/xunker/array-subindex)
> > [![Build Status](https://travis-ci.org/xunker/array-subindex.png?branch=master)](https://travis-ci.org/xunker/array-subindex) IMAGE
> > > SUCH [![Test Coverage](https://codeclimate.com/github/xunker/array-subindex/badges/coverage.svg)](https://codeclimate.com/github/xunker/array-subindex)
> > > > [ ![Codeship Status for xunker/array-subindex](https://www.codeship.io/projects/6fb16c30-10fb-0132-f222-0e0e1e0e9e00/status)](https://www.codeship.io/projects/32954) BADGES
