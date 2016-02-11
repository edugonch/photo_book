class CreateTagsIndex < ActiveRecord::Migration
  def up
    enable_extension "btree_gin"
    execute "CREATE INDEX tags_search_index ON tags USING gin(description);"
  end
  def down

  end
end
