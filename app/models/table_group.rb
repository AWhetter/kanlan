class TableGroup < ActiveRecord::Base
  has_one :left_end_table, class_name: "Table"
  has_many :rows
  has_one :right_end_table, class_name: "Table"

  validate do |table_group|
    unless (left_end_table || !rows.empty? || right_end_table)
      errors.add :base, "A table group must have at least one left end table, row, or right end table"
    end
  end
end
