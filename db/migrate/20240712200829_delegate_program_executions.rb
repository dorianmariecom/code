class DelegateProgramExecutions < ActiveRecord::Migration[8.0]
  def change
    remove_column :programs, :output
    remove_column :programs, :error
    remove_column :programs, :result
  end
end
