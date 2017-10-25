#
# Cookbook:: media_configuration
# Recipe:: images
#
# Copyright:: 2017, Darren Khan, All Rights Reserved.

# List of images to pull
images = ['captainfluffytoes/media_sonarr', 'captainfluffytoes/media_plexpy', 'captainfluffytoes/media_couchpotato', 'captainfluffytoes/media_sabnzbd']

# Checking to see if images exist and pulling is needed
images.each do |image|
  docker_image "Pulling image #{image}" do
    repo "#{image}"
    action :pull_if_missing
  end
end

# Create docker network to bind all containers
docker_network 'media' do
  action :create
end
