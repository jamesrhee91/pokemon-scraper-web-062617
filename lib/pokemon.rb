require 'pry'

class Pokemon
  attr_accessor :id, :name, :type, :db, :save, :find, :hp

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id, db)
    row = db.execute("SELECT * FROM pokemon WHERE pokemon.id = ?", id).first
    pokemon = Pokemon.new(id: row[0], name: row[1], type: row[2], hp: row[3])
    pokemon
  end

  def alter_hp(hp, db)
    id = self.id
    sql = <<-SQL
      UPDATE pokemon SET hp = ? WHERE id = ?
    SQL
    db.execute(sql, hp, id)
  end

end
