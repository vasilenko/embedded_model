# EmbeddedModel

A simple extension for ActiveRecord allowing to embed plain-models and store them as JSON. It's well-suited in case the use of full-featured models with underlying tables is redundant.

Works with ActiveRecord ~> 4.2. Support of the 5th version has not been implemented yet.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'embedded_model'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install embedded_model

## Usage

### Embeddable models

Any class allowing to populate their attributes by passing hash into constructor will suit.

```ruby
class Person
  attr_accessor :name

  def initialize(attrs = {})
    @name = attrs.with_indifferent_access['name']
  end
end
```

I recommend using [Virtus](https://github.com/solnic/virtus).

```ruby
class Person
  include Virtus.model

  attribute :name, String
end
```

### Embedding into container model

Add columns to be used as storage for embedded objects. If your database supports JSON (e.g. PostgreSQL), use type `json`, otherwise use `text`.

Use `embeds_one` method for embedding single objects and `embeds_many` for collections.

```ruby
class Department < ActiveRecord::Base
  embeds_one :boss
  embeds_many :employees
end
```

By default, names of the embeddable models are inferred from the column names. Should your classes have other names, it is necessary to specify them explicitly.

```ruby
class Party < ActiveRecord::Base
  embeds_one :tank, class_name: 'Player'
  embeds_many :dps, class_name: 'Player'
end
```

### Example

As soon as everything gets done, it simply works.

```ruby
department_params = {
  boss: { name: 'Todd' },
  employees: [{ name: 'Andy' }, { name: 'Jim' }]
}

department = Department.new(department_params)

# Do something with your model objects
department.boss.command('Work!')  # => Todd commands 'Work!'
department.employees.each(&:work) # => Andy works hard Jim works hard

department.save
department.reload

# Do something else
department.boss.command('Good job!') # => Todd commands 'Good job!'
department.employees.each(&:go_home) # => Andy goes home Jim goes home
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vasilenko/embedded_model.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
