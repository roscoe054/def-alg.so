module ApplicationHelper
	def connect_mongodb
		@algs = MongoClient.new("localhost", 27017).db("algso_dev")["algs"]
	end
end
