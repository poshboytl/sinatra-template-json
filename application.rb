require File.join(File.dirname(__FILE__), 'environment')

###################
#   Routes
###################
get '/' do
  outputJSON('All systems running!')
end

###################
#   Errors
###################
error 400..600 do
  boom   = @env['sinatra.error']
  status = response.status
  case
  when boom != nil
    if boom.to_s == 'Sinatra::NotFound'
      boom = 'Method not found'
    end
    message = boom
  when status != 200
    message = status.to_s
  end
  outputJSON(message, [], true)
end

###################
#   Helpers
###################
helpers do
  #
  # Sets the environment message and halts
  #
  def showError(message)
    @env['sinatra.error'] = message
    halt(400)
  end
  #
  # Standardised method for outputting JSON
  #
  def outputJSON(message, data=[], isError=false)
    content_type :json, 'charset' => 'utf-8'
    result = {}
    result['status']  = (isError) ? 'error' : 'ok'
    result['message'] = message
    unless data == []
      result['data'] = data
    end
    MultiJson.encode(result)
  end
  #
  # Returns the endpoint URL
  #
  def endpointURL
    return request.scheme + '://' + request.host_with_port + '/'
  end
end
