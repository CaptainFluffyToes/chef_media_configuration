#
# Cookbook:: media_configuration
# Recipe:: containers
#
# Copyright:: 2017, Darren Khan, All Rights Reserved.

# Create docker network to bind all containers
docker_network 'media' do
  action :create
end

# Create Sonarr Container
docker_container 'Sonarr' do
  container_name 'sonarr'
  repo 'captainfluffytoes/media_sonarr'
  volumes ['/etc/localtime:/etc/localtime:ro', '/mnt/config/sonarr:/root/.config/NzbDrone', '/mnt/Media/TV:/TV', '/mnt/Media/temp_download:/temp_download']
  port '8989:8989'
  network_mode 'media'
  action :run
end

# Create Couchpotato Container
docker_container 'Couchpotato' do
  container_name 'couchpotato'
  repo 'captainfluffytoes/media_couchpotato'
  volumes ['/etc/localtime:/etc/localtime:ro', '/mnt/config/couchpotato:/root/.couchpotato', '/mnt/Media/Movies:/Movies', '/mnt/Media/temp_download:/temp_download']
  port '5050:5050'
  network_mode 'media'
  action :run
end

# Create SabnzbD Container
docker_container 'SabnzbD' do
  container_name 'sabnzbd'
  repo 'captainfluffytoes/media_sabnzbd'
  volumes ['/etc/localtime:/etc/localtime:ro', '/mnt/config/sabnzbd:/root/.sabnzbd', '/mnt/Media/Movies:/Movies', '/mnt/Media/temp_download:/temp_download', '/mnt/Media/TV:/TV']
  port '8080:8080'
  network_mode 'media'
  action :run
end

# Create PlexPy Container
docker_container 'PlexPy' do
  container_name 'plexpy'
  repo 'captainfluffytoes/media_plexpy'
  volumes ['/etc/localtime:/etc/localtime:ro', '/mnt/config/plexpy:/data']
  port '8181:8181'
  network_mode 'media'
  action :run
end
