namespace :events do
  desc "Update event statuses based on their end_date"
  task update_statuses: :environment do
    Event.find_each do |event|
      if event.end_date.present?
        new_status = event.end_date < Date.today ? "closed" : "ongoing"
        if event.status != new_status
          event.update(status: new_status)
          puts "Updated event #{event.id} (#{event.name}): status set to #{new_status}"
        end
      end
    end
    puts "Event statuses updated successfully."
  end
end
