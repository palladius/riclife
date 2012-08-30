class ChangeCalendarToRiccalendar < ActiveRecord::Migration
  
    # rimossa il motivo per cui l'avevo fatto era sbagliato!
    
  def self.up
    # rename_table :casdflendars, :riccalendars
    # rename_column :events,     :calendar_id, :riccalendar_id  # ma anche no, posso usare il cazzillo che cambia nome... 
    # rename_column :ric_events, :calendar_id, :riccalendar_id  # ma anche no, posso usare il cazzillo che cambia nome... 
  end

  def self.down
    # rename_column :ric_events, :riccalendar_id, :calendar_id  # ma anche no, posso usare il cazzillo che cambia nome...
    # rename_column :events,     :riccalendar_id, :calendar_id  # ma anche no, posso usare il cazzillo che cambia nome... 
    # rename_table :riccalendars, :calendars
  end
end
