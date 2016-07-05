class PostsSearch < Search::Index
  model Post

  text_field :title,
             char_filter: :phonetic,
             tokenizer: :standard,
             token_filter: [:lowercase, :stopword, :stremmer]

  text_field :body,
             char_filter: [:phonetic, :strip_html],
             tokenizer: :standard,
             token_filter: [:lowercase, :stopword, :stremmer, { length: { min: 2 } }]
end
