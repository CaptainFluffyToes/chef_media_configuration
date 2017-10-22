#
# Cookbook:: media_configuration
# Recipe:: setup
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#Update Apt for installation of CIFS
apt_update 'Updates Apt' do
	action :update
end

#Install CIFS for mounts
package 'Install CIFS' do
	package_name 'cifs-utils'
	action :install
end

dirs = ['/mnt/Media', '/mnt/Config']

dirs.each do |dir|
	directory "Create #{dir}" do
		path "#{dir}"
		action :create
		not_if { ::Dir.exists?("#{dir}") }
	end
end

#Mount the media share for access
mount 'Mount Media share for access' do
	device '//storage.solsys.com/Bucket/Media'
	fstype 'cifs'
	options 'rw,username=media_user,password=test'
	mount_point '/mnt/Media'
	action [:mount]
end

#Mount the directory on fileshare that houses all of the configurations
mount 'Mount configuration share for containers' do
	device '//storage.solsys.com/config'
	fstype 'cifs'
	options 'rw,username=media_user,password=test'
	mount_point '/mnt/Config'
	action [:mount]
end

dirs = ['/mnt/Config/sonarr', '/mnt/Config/couchpotato', '/mnt/Config/plexpy', '/mnt/Config/sabnzbd']

dirs.each do |dir|
	directory 'Mount directories' do
		path "#{dir}"
		action :create
		not_if { ::Dir.exist?("#{dir}") }
	end
end

images = ['captainfluffytoes/media_sonarr', 'captainfluffytoes/media_plexpy', 'captainfluffytoes/media_couchpotato', 'captainfluffytoes/media_sabnzbd']

images.each do |image|
	docker_image "Pulling image #{image}" do
		repo "#{image}"
		action :pull_if_missing
	end
end

#Create docker network to bind all containers
docker_network 'media' do
	action :create
end

#Create Sonarr Container
docker_container 'Sonarr' do
	container_name 'sonarr'
	repo 'captainfluffytoes/media_sonarr'
	volumes ['/mnt/Config/sonarr:/root/.config/NzbDrone', '/mnt/Media/TV:/TV', '/mnt/Media/temp_download:/temp_download']
	port '8989:8989'
	network_mode 'media'
	#restart_policy 'always'
	action :run
end

#Create Couchpotato Container
docker_container 'Couchpotato' do
	container_name 'couchpotato'
	repo 'captainfluffytoes/media_couchpotato'
	volumes ['/mnt/Config/couchpotato:/root/.couchpotato', '/mnt/Media/Movies:/Movies', '/mnt/Media/temp_download:/temp_download']
	port '5050:5050'
	network_mode 'media'
	#restart_policy 'always'
	action :run
end

#Create SabnzbD Container
docker_container 'SabnzbD' do
	container_name 'sabnzbd'
	repo 'captainfluffytoes/media_sabnzbd'
	volumes ['/mnt/Config/sabnzbd:/root/.sabnzbd', '/mnt/Media/Movies:/Movies', '/mnt/Media/temp_download:/temp_download', '/mnt/Media/TV:/TV']
	port '8080:8080'
	network_mode 'media'
	#restart_policy 'always'
	action :run
end

#Create PlexPy Container
docker_container 'PlexPy' do
	container_name 'plexpy'
	repo 'captainfluffytoes/media_plexpy'
	volumes ['/mnt/Config/plexpy:/data']
	port '8181:8181'
	network_mode 'media'
	#restart_policy 'always'
	action :run
end