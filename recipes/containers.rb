#
# Cookbook:: media_configuration
# Recipe:: containers
#
# Copyright:: 2017, Darren Khan, All Rights Reserved.

network = 'media'

# Create docker network to bind all containers
docker_network "#{network}" do
  action :create
end

# Create Sonarr Container
docker_container 'Sonarr' do
  container_name 'sonarr'
  repo 'captainfluffytoes/docker_media_sonarr'
  volumes ['/etc/localtime:/etc/localtime:ro', '/mnt/config/sonarr:/root/.config/NzbDrone', '/mnt/Media/TV:/TV', '/mnt/completed:/completed', '/mnt/download:/download']
  port '8989:8989'
  network_mode "#{network}"
  action :run
end

# Create Couchpotato Container
docker_container 'Couchpotato' do
  container_name 'couchpotato'
  repo 'captainfluffytoes/docker_media_couchpotato'
  volumes ['/etc/localtime:/etc/localtime:ro', '/mnt/config/couchpotato:/root/.couchpotato', '/mnt/Media/Movies:/Movies', '/mnt/completed:/completed', '/mnt/download:/download']
  port '5050:5050'
  network_mode "#{network}"
  action :run
end

# Create PlexPy Container
docker_container 'PlexPy' do
  container_name 'plexpy'
  repo 'captainfluffytoes/docker_media_plexpy'
  volumes ['/etc/localtime:/etc/localtime:ro', '/mnt/config/plexpy:/data']
  port '8181:8181'
  network_mode "#{network}"
  action :run
end

# Create nzbget Container
docker_container 'NzbGet' do
  container_name 'nzbget'
  repo 'captainfluffytoes/docker_media_nzbget'
  volumes ['/etc/localtime:/etc/localtime:ro', '/mnt/Media/Movies:/Movies', '/mnt/Media/TV:/TV', '/mnt/completed:/completed', '/mnt/download:/download']
  port '6789:6789'
  network_mode "#{network}"
  action:run
end

# Create plex container from official image
docker_container 'Plex' do
  container_name 'plex'
  repo 'plexinc/pms-docker'
  volumes ['/etc/localtime:/etc/localtime:ro', '/mnt/Media:/data', '/mnt/config/plex:/config', '/mnt/temp:/transcode']
  env ["TZ=America/New_York"]
  port '32400:32400'
  network_mode "#{network}"
  action:run
end

#Create sabnzbd container
docker_container 'SabNZBd' do
  container_name 'sabnzbd'
  repo 'captainfluffytoes/docker_media_sabnzbd'
  volumes ['/etc/localtime:/etc/localtime:ro', '/mnt/Media/Movies:/Movies', '/mnt/Media/TV:/TV', '/mnt/completed:/completed', '/mnt/download:/download', '/sabnzbd:/root/.sabnzbd']
  port '8080:8080'
  network_mode "#{network}"
  action:run
end