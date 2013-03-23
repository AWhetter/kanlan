TABLES=YAML.load_file("#{Rails.root}/config/floor_plan.yml")["tables"]
SEATS = {}
END_TABLES = {}
TABLES.each do |table|
  SEATS.update(table["name"] => [])
  END_TABLES.update(table["name"] => [])

  extras = 0
  if table["left_end_table"]
    extras += 1
    END_TABLES[table["name"]] << "L"
  end
  if table["right_end_table"]
    extras += 1
    END_TABLES[table["name"]] << "R"
  end

  table["rows"].each do |row|
    for j in 1..table["tables"]
      for i in 1..table["seats_per_table"] + extras
        SEATS[table["name"]] << row + ((j-1)*table["seats_per_table"] + (i-1)).to_s
      end
    end
  end
end
