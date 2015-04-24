numbers = [1, 2, 3, 4, 5, 6, 7, 8]
animals = ["dog", "cat", "mouse"]
animals1 =	["dog", "cat", "mouse","elephant"]
scores = { 'Carol' => 90, 'Alice' => 50, 'David' => 40, 'Bob' => 60 }
arr = []
user1 = User.new
user2 = User.find(3)
user3 = user2.destroy 
error = nil
# dammy

numbers.map {|item| item * 2 }
numbers.select {|item| item % 2 == 0 }
numbers.find {|item| item % 2 == 0 }
arr = []
arr.empty?
numbers << 9
User.find(3)
User.find_by(username: 'カツオ')
User.all.map(&:username)
User.pluck(:id)
animals.try(:size)
error.try(:size)
animals ||= 'hello'
error ||= 'hello'
User.find(0).blank?
User.find(0).present?
numbers.empty? ? "empty" : "valid"
arr.empty? ? "empty" : "valid"
numbers if numbers.size > 4 
numbers unless numbers.size > 4
animals.index_by do |n|
	"#{n} * 1"
end
animals.each_with_index {|anim, i| puts "#{i+1}. #{anim}" }
scores.each_with_object([]) do |(key, val), arr|
	arr << key if val >= 60
end
puts animals1.any? {|word| word.size > 7 }
puts animals.any? {|word| word.size > 7 }
user1.new_record?
user1.persisted?
user2.persisted?
user3.persisted?