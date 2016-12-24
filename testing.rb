require_relative "./factory.rb"

person = Factory.new(:name, :age, :zip)
car = Factory.new(:mark, :issue_year, :number)

person1 = person.new("Oleg", 27, 49000)
person2 = person.new("Oleg", 27, 49000)
person3 = person.new("Alex", 31, 18000)

car1 = car.new("Lamborgini", 2013, 4315)

puts "---------------------------------------------------\nmembers"
print person1.members
puts "\n---------------------------------------------------\nvalues"
print person1.values
puts "\nto_a"
print person1.to_a
puts "\n---------------------------------------------------\n=="
print person1 == person2
puts "\n"
print person1 == person3
puts "\n"
print person1 == car1
puts "\n---------------------------------------------------\ninspect"
print car1.inspect
puts "\n---------------------------------------------------\n[]"
print person1[:name], "\n"
print person1[-1]
puts "\n---------------------------------------------------\n[]="
print person3["name"] = "Alex", "\n"
print person3[-1] = 13000
puts "\n---------------------------------------------------\neach"
person1.each { |v| puts v }
puts "\n---------------------------------------------------\neach_pair"
person1.each_pair { |k, v| puts "#{k} => #{v}" }
puts "\n---------------------------------------------------\neql?"
print person1.eql?(person2), "\n"
print person1.eql?(person3)
puts "\n---------------------------------------------------\nlength"
print person1.length
puts "\nsize"
print person1.size
puts "\n---------------------------------------------------\nselect"
print person1.select { |v| v.is_a?(Fixnum) }
puts "\n---------------------------------------------------\nvalues_at"
print car1.values_at(:mark, -1)
puts "\n\n"

Customer = Struct.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end

test_block = Customer.new("Roman", "Dnepr")
print test_block.greeting, "\n"
