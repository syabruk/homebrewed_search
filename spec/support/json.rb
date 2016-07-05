module JsonMacros
  EXCLUDE_KEYS = %w(id created_at updated_at).freeze

  def json
    body = if subject.is_a?(ActionDispatch::TestResponse)
      subject.body
    else
      response.body
    end

    _json_data = MultiJson.load(body)

    if _json_data.is_a? Array
      _json_data.map { |o| ActiveSupport::HashWithIndifferentAccess.new o.except(*EXCLUDE_KEYS) }
    else
      ActiveSupport::HashWithIndifferentAccess.new _json_data.except(*EXCLUDE_KEYS)
    end
  end
end

RSpec.configure do |config|
  config.include JsonMacros, type: :controller
end
