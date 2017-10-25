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

mounts = ['Media', 'config', 'Temp']

mounts.each do |mount|
  mount "Mount share #{mount}" do
    device "//storage.solsys.com/#{mount}"
    fstype 'cifs'
    options 'rw,username=media_user,password=test'
    mount_point "/mnt/#{mount}"
    action [:mount]
  end
end

dirs = ['/mnt/config/sonarr', '/mnt/config/couchpotato', '/mnt/config/plexpy', '/mnt/config/sabnzbd', '/mnt/config/nzbget']

dirs.each do |dir|
  directory 'Mount directories' do
    path "#{dir}"
    action :create
    not_if { ::Dir.exist?("#{dir}") }
  end
end
