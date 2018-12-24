class ApplicationController < ActionController::API
	include ActionController::MimeResponds
	before_action :authenticate_request, except: [:csv, :destroy]
	attr_reader :current_user

	protected

	def authenticate_request
		@current_user = AuthorizeApiRequests.call(request.headers).result
		render json: { error: 'Not Authorized'}, status: 401 unless @current_user
	end
end
