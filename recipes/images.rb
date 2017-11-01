#
# Cookbook:: media_configuration
# Recipe:: images
#
# Copyright:: 2017, Darren Khan, All Rights Reserved.

# List of images to pull
images = ['captainfluffytoes/docker_media_sonarr', 'captainfluffytoes/docker_media_plexpy', 'captainfluffytoes/docker_media_couchpotato', 'captainfluffytoes/docker_media_sabnzbd']

# Checking to see if images exist and pulling is needed
images.each do |image|
  docker_image "Pulling image #{image}" do
    repo "#{image}"
    action :pull_if_missing
  end
end
