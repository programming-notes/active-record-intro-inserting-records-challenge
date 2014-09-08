# Code to populate the database ...

tenley_details = { :name    => "Tenley",
                   :license => "OH-9384764",
                   :age     => 1,
                   :breed   => "Golden Doodle" }

jayda_details = { :name    => "Jayda",
                  :license => "OH-4893720",
                  :age     => 3,
                  :breed   => "Bull Terrier" }


tenley = Dog.new(tenley_details)
tenley.save

Dog.create(jayda_details)

Dog.find_or_create_by(name: "Eleanor") do |dog|
  dog.license = "OH-9843098"
  dog.age     = 1
  dog.breed   = "Pit Bull"
end
