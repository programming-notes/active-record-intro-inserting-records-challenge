#Active Record Intro:  Inserting Records

## Summary

In this challenge, we'll continue working with our models in the console.  We'll switch our focus from retreiving records from the database to creating new records.

```ruby
class Dog < ActiveRecord::Base
end
```

*Figure 1.*  Code for `Dog` class.

We will once again work with a pre-written, empty `Dog` class.  The class is defined in the file `app/models/dog.rb`, whose code is shown in Figure 1.  Again, there are no methods defined within the class itself; however, it inherits a number of class methods from `ActiveRecord::Base`.  Among these inherited methods, are class methods for inserting records into the database.  We are going to explore some of those methods in this challenge.

## Releases

### Pre-release: Create, Migrate, and Seed the Database

1. Run Bundler to ensure that the proper gems have been installed.

2. Use the provided Rake task to create the database.

3. Use the provided Rake task to migrate the database.

4. Use the provided Rake task to seed the database.  This will execute the code written in `db/seeds.rb`.  This file has been written to add three dogs to our database:  Tenley, Jayda, and Eleanor.

### Release 0: `::new` and `::create`

We're going to work with our `Dog` class from within the console.  To open the console, from the command line, run `bundle exec rake console`.  We're going to sample the class methods for inserting new records into the database that our class inherits from ActiveRecord::Base.  For more details, read through the [RailsGuides](http://guides.rubyonrails.org/).  

From within the console run ...

- `Dog.count`

  We'll see that the `dogs` table holds three records, the three that were inserted when we seeded the database.

- `new_dog = Dog.new(name: "Bear")`

  `::new` works very similarly to what we're used to seeing with our Ruby classes.  A new instance of `Dog` has been created and the attributes that we've specified when calling `::new` have been assigned to the object.  In our case, we have a `Dog` object with the name `"Bear"`.  The variable `new_dog` has been assigned this object as its value.
  
  The attributes that we didn't specify have been set to `nil`, as we might expect.  Notice, the value of the `id` attribute.  It is also `nil`.  When we create a new instance of `Dog` by calling `Dog.new`, we are not saving the record to the database.  The object only exists in memory.

- `Dog.count`

  We'll see that the `dogs` table still holds just three records.

- `new_dog.save`

  If we have an instance of `Dog`, we can try to save it to the database by calling `#save` on the instance.  This will generate and execute a SQL query; in this case:
  
  `INSERT INTO "dogs" ("name", ...) VALUES (?, ...)  [["name", "Bear"], ...]`

  The `#save` method then returns `true` if the record was saved successfully and `false` if not.

- `Dog.count`

  We'll see that the `dogs` table now holds four records, the three that were inserted when we seeded the database and now Bear.

- `Dog.create(name: "Max")`

  Sometimes we want to instantiate a new object and save it to the database at the same time.  `::create` gives us this option.  
  
  `::create` will create the new object, assign attributes, and attempt to save it to the database.  However, wherease `#save` returns a true/false value, `::create` is more subtle.  `::create` will always return the newly instantiated object.  If the save was successful, the object will have its `id` attribute assigned.  If the save was unsuccessful, the object's `id` will be `nil`.

- `Dog.count`

  We'll see that the `dogs` table now holds five records.

- `Dog.create [{name: "Toot"}, {name: "Cosmo"}]`

  We can also create multiple records with one call to `::create` by passing an array of argument hashes.


### Release 1: `find_or_initialize_by` and `find_or_create_by`

Sometimes we are unsure whether a record already exists in the database.  For example, is there already a dog named Tenley with this license number?  There are a couple methods that will look for a record in the database and if it's there, return it, and if not, create a new object.

- `Dog.pluck(:name)`

  We'll see the names or the dogs in our database.  Note that the name `"Tenley"` is already in the database.

- `Dog.find_or_initialize_by(name: "Tenley", license: "OH-9384764")`

  Here we want to return the `Dog` with the name `"Tenley"` and license number `"OH-9384764"` if such a record exists in the database.  We can see in the console output that Active Record executes a SQL query:
  
  `SELECT  "dogs".* FROM "dogs"  WHERE "dogs"."name" = 'Tenley' AND "dogs"."license" = 'OH-9384764' LIMIT 1`
  
  In this case, such a record exists and so the method `::find_or_initialize_by` returns the object.

- `Dog.find_or_initialize_by(name: "Tenley", license: "MI-1234567")`

  In this case, we're again looking for a dog named "Tenley".  But, this time, the dog should have a different license.  The record is not found in the database, so Active Record instantiates a new `Dog` object and assigns the attributes that we were looking for.  But, like `::new`, `::find_or_initialize_by` does not attempt to save the record to the database.  We can see that the object's `id` is `nil`.  We would need to call `#save` on the returned instance if we wanted to save to the database.

- `Dog.find_or_create_by(name: "Taj", license: "OH-9084736")`

  `::find_or_create_by` is similar to `::find_or_initialize_by` except that if it doesn't find a record matching the given attributes, it both instantiate a new object with those attributes and also attempt to save it to the database.
  
  In the console output, we can see that two SQL queries were run.  First, Active Record attempted to find a record with the supplied attributes.  Then, after not finding one, it attempted the save a new record with the supplied attributes:
  
  `INSERT INTO "dogs" ("license", "name", ...) VALUES (?, ?, ...)  [["license", "OH-9084736"], ["name", "Taj"], ...]`
  
  The returned `Dog` object has an `id` assigned (i.e., it's not `nil`), so we know that the save was successful.

- `exit`

### Release 2: Insert new Records

In the console, practice inserting new records into the database using the methods outlined above.  Create some dogs, people, and ratings.  Submit the challenge only when you're comfortable creating new records.

