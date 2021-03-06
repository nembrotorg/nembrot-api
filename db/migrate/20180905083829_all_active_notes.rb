class AllActiveNotes < ActiveRecord::Migration
  def up
    connection.execute(%q{
      CREATE OR REPLACE FUNCTION api.active_notes() RETURNS setof notes AS $$
        SELECT *
         FROM notes
         WHERE notes.active = 't'
           AND notes.hide = 'f'
         ORDER BY weight ASC, external_updated_at DESC
      $$ language sql stable;
    })
  end

  def down
    connection.execute(%q{
      DROP FUNCTION api.active_notes() CASCADE;
    })
  end
end
