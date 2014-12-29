module ApplicationHelper
	def connect_mongodb
		@db = MongoClient.new("localhost", 27017).db("algso_dev")
		@algs = @db["algs"]
	end
end
