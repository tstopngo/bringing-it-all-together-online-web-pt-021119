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
    
  
  end
  
  def self.find_by_name(name)
  
  end
end