class User
  attr_reader :name, :role

  def initialize(attributes = {})
    @name = attributes[:name] || 'Guest'
    @role = attributes[:role] || 'guest'
  end
end
