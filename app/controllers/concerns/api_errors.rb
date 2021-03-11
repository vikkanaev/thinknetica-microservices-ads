module ApiErrors
  def handle_exception(e)
    case e
    when KeyError
      error_response(I18n.t(:missing_parameters, scope: 'api.errors'), 422)
    when JSON::ParserError
      error_response(I18n.t(:wrong_request, scope: 'api.errors'), 422)
    else
      raise
    end
  end

  def error_response(error_messages, status_code)
    errors = case error_messages
    when Sequel::Model
      ErrorSerializer.from_model(error_messages)
    else
      ErrorSerializer.from_messages(error_messages)
    end

    status status_code
    body errors.to_json
  end
end
