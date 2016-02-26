#Add the library for HTTP
require 'net/http'


module Rest_service

  HTTP_TIMEOUT_FOR_RESPONSE = 180
  
  #
  # This method set up a connection 
  #
  def Rest_service.get_connection
      http_connection = nil

      proxy_addr = 'localhost'
      proxy_port = 8080

      http_connection=Net::HTTP.new('localhost:8080', nil, proxy_addr, proxy_port)

      http_connection.read_timeout = HTTP_TIMEOUT_FOR_RESPONSE
      return http_connection
  end

end
