desc "Import avatars from user's gravatar url"
task :import_avatars => :environment do
  puts "Importing avatars from gravatar"
  User.get_gravatars
  puts "Avatars updated."
end
