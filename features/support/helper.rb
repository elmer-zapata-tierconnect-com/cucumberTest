require 'net/http'


module Rest_service

  HTTP_TIMEOUT_FOR_RESPONSE = 180
  
  #
  # This method set up a connection 
  #
  def Rest_service.get_connection
      http_connection = nil

      http_connection = Net::HTTP.new("10.100.1.195:8080")
      http_connection.read_timeout = HTTP_TIMEOUT_FOR_RESPONSE
      return http_connection
  end

  def Rest_service.get_request(method, url)
    request = nil   
    url =  $app_root + url
    #url="localhost:8080/riot-core-services/api/user/login"
    puts "url #{url}"
    case method
      when "POST"
        request = Net::HTTP::Post.new(url)
        request.content_type = 'application/json'
      when "PUT"
        request = Net::HTTP::Put.new(url)
      when "DELETE"
        request = Net::HTTP::Delete.new(url)
      when "GET"
        request = Net::HTTP::Get.new(url)
    end
   return request
  end

  def Rest_service.execute_request(http_connection, http_request)
    puts "ads#{http_connection}"
        http_response = http_connection.request(http_request)
    return http_response
  end


end

