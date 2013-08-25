# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

config_loc = File.join(Rails.root, 'config', 'floor_plan.yml')

if File.exists?(config_loc)
  table_groups = YAML.load_file(config_loc)["tables"]

  table_groups.each do |config|
    table_group = TableGroup.new

    if config["left_end_table"]
      table = Table.new
      for i in 0...config["seats_per_table"]
        table.seats << Seat.create(:name => "L#{i}")
      end

      table.save
      table_group.left_end_table = table
    end

    config["rows"].each do |row|
      row = Row.new
      for j in 0...config["tables"]
        table = Table.new
        for i in 0...config["seats_per_table"]
          table.seats << Seat.create(:name => "#{row}#{j*config["seats_per_table"] + i}")
        end
        table.save
        row.tables << table
      end
      row.save
      table_group.rows << row
    end

    if config["right_end_table"]
      table = Table.new
      for i in 0...config["seats_per_table"]
        table.seats << Seat.create(:name => "R#{i}")
      end

      table.save
      table_group.right_end_table = table
    end

    table_group.save
  end
end
