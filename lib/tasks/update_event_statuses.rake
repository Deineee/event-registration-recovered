namespace :events do
  desc "Update event statuses based on their date"
  task update_statuses: :environment do
    Event.find_each do |event|
      if event.date.present?
        new_status = event.date < Date.today ? "closed" : "ongoing"
        if event.status != new_status
          event.update(status: new_status)
          puts "Updated event #{event.id} (#{event.name}): status set to #{new_status}"
        end
      end
    end
    puts "Event statuses updated successfully."
  end
end
# This task iterates through all events and updates their status based on the date.
# If the event's date is in the past, it sets the status to "closed";
