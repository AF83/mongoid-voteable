# mongoid-voteable

Add voting to your Mongoid documents

## Installation

This is a fork, so it doesn't exist as a gem right now. The only way to use it
is through a Gemfile directive.

Add the gem to your `Gemfile`

    gem 'mongoid-voteable', git: 'https://github.com/AF83/mongoid-voteable.git'

## Usage

This a a fork from the gem "mongoid-voteable", what follows are interesting bits
of the initial README on the gem usage.

Include the `Mongoid::Voteable` module into your models you want to vote in.

```ruby
class Story
  include Mongoid::Document
  include Mongoid::Voteable

  # ...
end
```

You can then cast votes by simply using the `vote` method on the model.

```ruby
@story = Story.first
@user = User.where(:name => 'Simon')

@story.vote 1, @user  # vote by +1, you like it
@story.vote -1, @user # vote by -1, you don't like it
```

You are not limited to just voting up and down by 1, you can vote by any amount.

```ruby
@story.vote 5, @user   # you love it
@story.vote -10, @user # you want to bury it
```

You also have access to a couple of helpful methods.

```ruby
@story.voted? @user # true if the user has already voted on this

@story.vote_count   # total number of votes
```

**Note** if your users are not stored in a Mongo collection or the ID field is
not called `_id` you can still pass the ID in as the second parameter instead.

```ruby
@story.vote 1, @user.id

@story.voted? @user.id
```

Currently it will only use the first vote from a user. Functionality to allow a
user to change their vote may be included in a future release.

Some other ideas include specifying vote weights, for example an up vote may be
worth more than a down vote, or vice versa. Also maybe voting in an embedded
documented may affect the votes of the parent document.

## Addition

The notion of `vote_up` and `vote_down` is being added to this library. Instead
of having a `votes` field, model has a `votes_up` and a `votes_down` attribute.
Method `votes` returns the addition of the latters.

There is also a `vote_up` and a `vote_down` method, both with the same syntax,
same as the `vote` method, except the amount of votes can be omitted, and so
forth defaulted to `1` or `-1`.

## License

Copyright 2012 Tom Bell
Copyright 2014 AF83

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
