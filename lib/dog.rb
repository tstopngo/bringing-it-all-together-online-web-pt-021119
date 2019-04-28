require 'pry'

class Dog 
  attr_accessor :name, :breed, :id

  def initialize(args)
    @name = args[:name]
    @breed = args[:breed]
    @id = args[:id]
  end
  
  def self.create_table
    sql_table = <<-SQL
    CREATE TABLE IF NOT EXISTS dogs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    breed TEXT
    )
    SQL
    
    DB[:conn].execute(sql_table)
  end

  def self.drop_table
    sql_table = <<-SQL
    DROP TABLE dogs
    SQL
    
    DB[:conn].execute(sql_table)
  end
  
  def self.new_from_db(row)
    dog = Dog.new(id => row[0], name => row[1], breed => row[2])
    dog
  end
  
  def save
    sql_save = <<-SQL
      INSERT INTO dogs (name, breed) VALUES (?,?)
    SQL
    if self.id
      self.update
    else
      DB[:conn].execute(sql_save, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
    self
  end
  
  def self.create(args)
    dog = Dog.new(args)
    dog.save
    dog
  end
  
  def self.find_by_id(id)
    sql_query = <<-SQL
      SELECT * FROM dogs WHERE id = ?
      LIMIT 1
    SQL
    
    search = DB[:conn].execute(sql_query, id)[0]
    dog =Dog.new(search[0], search[1], search[2])
  end
  
  def self.find_by_name(name)
  
  end
end