require 'singleton'
require 'json'

class GetToken
  include Singleton
  attr_accessor:token

  def initialize
    http_connection=Rest_service.get_connection

    http_response = Rest_service.execute_request(http_connection, http_request)
    http_request = Net::HTTP::Get.new(@path, initheader = {'Content-Type' =>'application/json'})
    json_responce = JSON.parse(http_response.body)
    @token=json_responce[$TOKENSTRING]
  end
end

Given(/^I have set a connection to todo\.ly service$/) do
  @http_connection = Rest_service.get_connection
  #@token_value= GetToken.instance
  #puts "TOKEN: #{@token_value.token}" 
end

When (/^I send a (PUT|POST) request to (.*?) with json$/) do |method, end_point, json_text|
  http_request = Rest_service.get_request(method, end_point)

#  http_request[$TOKEN]=@token_value.token
#  http_request['content-type'] = 'aplication/json'
  http_request.body = json_text
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body


  # puts "json #{@http_response.body}"
end

When (/^I send a (GET) request to (.*?)$/) do |method, end_point|
  http_request = Rest_service.get_request(method, end_point)
  http_request[$TOKEN]=@token_value.token
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end

Then (/^I expect HTTP code (\d+)$/) do |http_code|
  expect(@http_response.code).to eql(http_code)
end

Then (/^I expect JSON equal to$/) do |json_text|
  expect(@last_json).to be_json_eql json_text
end
