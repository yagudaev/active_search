class CreatePagesSearchIndex < ActiveRecord::Migration[6.0]
  def change
    Page.__elasticsearch__.create_index!
  end
end
