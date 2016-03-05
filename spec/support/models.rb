ActiveRecord::Base.establish_connection adapter: :sqlite3, database: ':memory:'

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :departments, force: true do |t|
    t.text :boss
    t.text :employees
  end
end

class Department < ActiveRecord::Base; end

class Person
  attr_accessor :name

  def initialize(attrs = {})
    @name = attrs.with_indifferent_access['name']
  end

  def ==(other)
    self.name == other.name
  end
end

class Boss < Person; end
class Employee < Person; end
