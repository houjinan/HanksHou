namespace :assets do
  task :clean_images do
    images = Dir.glob('app/assets/images/**/*')
    unused_images = []
    images.each do |image|
      unless File.directory?(image)
        puts "Checking #{image}..."
        result = `grep -nr #{File.basename(image)}* app/ `
        if result.empty?
          unused_images << image
          `rm -rf #{image}`
        end
      end
    end
  end
end