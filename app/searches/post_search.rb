class PostSearch < Search::Index
  model Post

  text_field :title,
    tokenizer: :standard
    # token_filter: :lowercase

  # text_field :body,
  #   char_filter: [:phonetic, :strip_html],
  #   tokenizer: :standard,
  #   token_filter: [:lowercase, :stopword, :stremmer, { length: { min: 2 } }]
end
