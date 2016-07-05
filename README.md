# HomebrewedSearch

Blog with homebrewed Search™ gem (`./gems/search`).

## Technologies

* Ruby on Rails 5
* PostgreSQL
* ReactJS
* ES6

## How it works?

An enter point of the App is `app/controllers/posts_controller.rb`. It implements an API for ReactJS and renders a main layout.

Search is implemented using a `search` gem. The App has defined a search class (`app/searches/posts_search.rb`) and it creates callbacks for a model that we are indexing.

Search™ provides tiny but extensible DSL for defining indexes.

```ruby
class PostsSearch < Search::Index
  model Post

  text_field :title,
             char_filter: :phonetic,
             tokenizer: [:standard, :ngram],
             token_filter: [:lowercase, :stopword, :stremmer]

  text_field :body,
             char_filter: [:phonetic, :strip_html],
             tokenizer: :standard,
             token_filter: [:lowercase, :stopword, :stremmer, { length: { min: 2 } }]

  text_field :author_name, token_filter: :lowercase
end
```

## What is out of the box?

Search™ performs each defined performer one by one in a specific order: `Tokenizers -> CharFilers -> TokenFilers`.

### Tokenizers

Splits input string for tokens.

#### Plain

Actually, does nothing. Just process a whole input string as one token.

```ruby
text_field :body, tokenizer: :plain
```
This is a default tokenizer.

#### Standard

Splits input string by spaces and punctuation.

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
text_field :title, tokenizer: [{ngram: {size: 5}]
```

### CharFilers

Mutates chars inside each tokens.

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

### TokenFiler

Mutates and filters a whole token.

#### Lowercase

Converts all chars to lowercase.

```ruby
text_field :body, token_filter: :lowercase
```

#### Stopword

Filters stopwords (for example `a/the/...`) from tokens.

```ruby
text_field :stopword, token_filter: :stopword
```

#### Stremmer

Stremms tokens.

```ruby
text_field :stopword, token_filter: :stopword
```
