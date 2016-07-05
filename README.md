# HomebrewedSearch

Blog with a homebrewed Search™ gem (`./gems/search`).

## Technologies

* Ruby on Rails 5
* PostgreSQL
* ReactJS
* ES6

## How it works?

An enter point of the App is `app/controllers/posts_controller.rb`. It implements an API for ReactJS and renders the main layout.

Search is implemented using a `search` gem. The App has defined a search class (`app/searches/posts_search.rb`) and it creates callbacks for a model that we are indexing.

Search™ provides tiny but extensible DSL for defining indexes.
Also, it adds 2 callbacks to a given model (`after_save` and `after_destroy`).

```ruby
# app/searches/posts_search.rb
class PostsSearch < Search::Index
  model Post

  text_field :title,
             char_filter: :phonetic,
             tokenizer: [:standard, :ngram],
             token_filter: [:lowercase, :stopword, :stemmer]

  text_field :body,
             char_filter: [:phonetic, :strip_html],
             tokenizer: :standard,
             token_filter: [:lowercase, :stopword, :stemmer, { length: { min: 2 } }]

  text_field :author_name, token_filter: :lowercase
end
```

Search™ stores tokens in a `Search::Token` model. You should run the generator which generates a migration to create table for it:

```sh
bundle exec rake search:install
```

## What is out of the box?

Search™ performs each defined performer one by one in a specific order: `Tokenizers -> CharFilters -> TokenFilters`.

### Tokenizers

Splits an input string for tokens.

#### Plain

Actually, does nothing. Just stores a whole input string as one token.

```ruby
text_field :body, tokenizer: :plain
```
This is a default tokenizer.

#### Standard

Splits an input string by space and punctuation.

```ruby
text_field :body, tokenizer: :standard
```

#### Ngram

Splits input string by n-length grams. It may accept additional parameters:
* `size` — size of ngrams (default `3`);
* `word_separator` — ngrams will be splitted by this parameter (default `' '`);
* `padchar` — fills remaining position of a ngram (default `''`).

```ruby
text_field :body, tokenizer: :ngram
text_field :title, tokenizer: [{ ngram: { size: 5 } }]
```

### CharFilters

Mutates chars inside each token.

#### Phonetic

Replaces common phonetic patterns.

```ruby
text_field :body, char_filer: :phonetic
```

#### StripHtml

Sanitizes HTML tags from an input string.

```ruby
text_field :body, char_filer: :strip_html
```

### TokenFilter

Mutates and filters whole tokens.

#### Lowercase

Converts all chars to lowercase.

```ruby
text_field :body, token_filter: :lowercase
```

#### Stopword

Filters stopwords (for example `a/the/...`) from tokens.

```ruby
text_field :body, token_filter: :stopword
```

#### Stemmer

Stemms tokens.

```ruby
text_field :body, token_filter: :stemmer
```

#### Length

Filters tokens by length with a given range. Possible parameters:
* `min`
* `max`

```ruby
text_field :body, token_filter: :length
text_field :title, token_filter: [{ length: { min: 2, max: 10 } }]
```

### You can define your own performers

Each performer should have defined `perform` block and return an array of `Search::Token` (`flat_map_tokens` helps you with that).

```ruby
# lib/search/token_filter/bang.rb
module Search::TokenFilter::Bang
  include Search::Performing

  perform do |string_or_tokens|
    flat_map_tokens(string_or_tokens) do |token|
      token.term += '!'
    end
  end
end
```

### Indexing records

```ruby
PostsSearch.index! # indexes all posts
PostsSearch.index!(Post.first) # indexes the given record
PostsSearch.index!(Post.where(author_id: 1)) # indexes the given scope
```

### Deleting records from index

```ruby
PostsSearch.delete! # deletes all records from index
PostsSearch.delete!(Post.first) # deletes only given record from index
PostsSearch.delete!(Post.where(author_id: 1)) # deletes all given records from index
```

Also, you can pass same parameters to a `Search.index!`/`Search.delete!` methods to update all indexes where this record is provided.

```ruby
# app/searches/posts_search.rb
class PostsSearch < Search::Index
  model Post
end

# app/searches/autocomplete_search.rb
class AutocompleteSearch < Search::Index
  model Post
end

Search.index!(Post.first) # updates the record in both indexes
Search.delete!(Post.first) # deletes the record from both indexes
```

### Searching records

```ruby
PostsSearch.search('Car') # returns ActiveRecord::Relation with matched posts
PostsSearch.search('Car', highlight: true) # assigns `highlights` attribute with matched terms to every post
```

## Testing

```sh
cd gems/search
cp spec/internal/config/database.yml{.example,}
rake
```

You can add `require 'search/rspec'` to your own `spec_helper.rb` to enable some useful matchers:

```ruby
expect { Post.create }.to index
expect { Post.destroy_all }.to delete_from_index

let(:post) { Post.create }
expect { post }.to index(post)

let!(:post) { Post.create }
expect { post.destroy }.to delete_from_index(post)
```
