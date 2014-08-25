module KanLan
	TABLES=YAML.load_file("#{Rails.root}/config/floor_plan.yml")['tables']
	TABLE_NAMES = []
	LEFT_TABLE_NAME = '^'
	RIGHT_TABLE_NAME = '$'

	SEATS = {}
	seat_names = {}
	END_TABLES = {}

	add_seat = lambda { |table, row, i, j|
		seat_name = row + ((j-1)*table['seats_per_table'] + (i-1)).to_s
		SEATS[table['name']] << seat_name
		seat_names.update(seat_name => true)
	}

	TABLES.each do |table|
		TABLE_NAMES << table['name']
		SEATS.update(table['name'] => [])
		END_TABLES.update(table['name'] => [])

		if table['left_end_table']
			END_TABLES[table['name']] << 'L'
			for i in 1..table['seats_per_table']
				add_seat[table, LEFT_TABLE_NAME, i, 1]
			end
		end

		table['rows'].each do |row|
			for j in 1..table['tables']
				for i in 1..table['seats_per_table']
					add_seat[table, row, i, j]
				end
			end
		end

		if table['right_end_table']
			END_TABLES[table['name']] << 'R'
			for i in 1..table['seats_per_table']
				add_seat[table, RIGHT_TABLE_NAME, i, 1]
			end
		end
	end

	SEAT_NAMES = seat_names.keys
end
