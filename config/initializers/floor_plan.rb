TABLES=YAML.load_file("#{Rails.root}/config/floor_plan.yml")["tables"]
SEATS = {}
TABLES.each do |table|
  SEATS.update(table["name"] => [])
  table["rows"].each do |row|
    for j in 1..table["tables"]
      for i in 1..table["seats_per_table"]
        SEATS[table["name"]] << row + ((j-1)*table["seats_per_table"] + (i-1)).to_s
      end
    end
  end
end
