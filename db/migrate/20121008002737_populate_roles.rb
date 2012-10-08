class PopulateRoles < ActiveRecord::Migration

  def up
    [
      ["Administrator", :admin],
      ["User", :user],
      ["Commenter", :commenter],
    ].each do |name, key|
      Role.create!(:name => name, :key => key)
      say "#{name} role created."
    end
  end

  def down
    say "Purging all roles."
    Role.delete_all
  end

end
