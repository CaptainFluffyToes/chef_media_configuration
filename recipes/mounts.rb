#
# Cookbook:: media_configuration
# Recipe:: mounts
#
# Copyright:: 2017, Darren Khan, All Rights Reserved.

# Update Apt for installation of CIFS
apt_update 'Updates Apt' do
  action :update
end

# Install CIFS for mounts
package 'Install CIFS' do
  package_name 'cifs-utils'
  action :install
end

dirs = ['/mnt/Media', '/mnt/config', '/mnt/Temp']

dirs.each do |dir|
  directory "Create #{dir}" do
    path "#{dir}"
    action :create
    not_if { ::Dir.exist?("#{dir}") }
  end
end

# Mount the media share for access
mount 'Mount Media share for access' do
  device '//storage.solsys.com/Bucket/Media'
  fstype 'cifs'
  options 'rw,username=media_user,password=test'
  mount_point '/mnt/Media'
  action [:mount]
end

# Mount the directory on fileshare that houses all of the configurations
mount 'Mount configuration share for containers' do
  device '//storage.solsys.com/config'
  fstype 'cifs'
  options 'rw,username=media_user,password=test'
  mount_point '/mnt/config'
  action [:mount]
end

# Mount the directory for temp transcoding
mount 'Mount temp transcoding directory' do
  device '//storage.solsys.com/Temp'
  fstype 'cifs'
  options 'rw,username=media_user,password=test'
  mount_point '/mnt/Temp'
  action [:mount]
end

dirs = ['/mnt/config/sonarr', '/mnt/config/couchpotato', '/mnt/config/plexpy', '/mnt/config/sabnzbd', '/mnt/config/nzbget']

dirs.each do |dir|
  directory 'Mount directories' do
    path "#{dir}"
    action :create
    not_if { ::Dir.exist?("#{dir}") }
  end
end
