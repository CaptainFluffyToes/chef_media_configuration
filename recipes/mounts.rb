#
# Cookbook:: media_configuration
# Recipe:: mounts
#
# Copyright:: 2017, Darren Khan, All Rights Reserved.

# Update Apt
apt_update 'Updates Apt' do
  action :update
end

apps = ['cifs-utils', 'nfs-common']

apps.each do |app|
  package "Installing #{app}" do
    package_name "#{app}"
    action :install
  end
end

dirs = ['/mnt/Media', '/mnt/config', '/mnt/temp', '/mnt/completed', '/mnt/download']

dirs.each do |dir|
  directory "Create #{dir}" do
    path "#{dir}"
    action :create
    not_if { ::Dir.exist?("#{dir}") }
  end
end

cifsmounts = ['Media', 'config', 'completed']

cifsmounts.each do |mount|
  mount "Mount share #{mount}" do
    device "//storage.solsys.com/#{mount}"
    fstype 'cifs'
    options 'rw,username=media_user,password=test'
    mount_point "/mnt/#{mount}"
    action [:mount]
  end
end

nfsmounts = ['download', 'temp']

nfsmounts.each do |nfsmount|
  mount "Mount share #{nfsmount}" do
    device "storage.solsys.com:/mnt/capsule/#{nfsmount}"
    fstype 'nfs'
    options 'hard,intr,bg,sync,rw'
    mount_point "/mnt/#{nfsmount}"
    action [:mount]
  end
end

dirs = ['/mnt/config/sonarr', '/mnt/config/couchpotato', '/mnt/config/plexpy', '/mnt/config/nzbget', '/mnt/config/plex', 'mnt/config/sabnzbd']

dirs.each do |dir|
  directory "Create directory #{dir}" do
    path "#{dir}"
    action :create
    not_if { ::Dir.exist?("#{dir}") }
  end
end

directory "Create local diectory for SabnzbD" do
  path '/sabnzbd'
  action :create
  not_if { ::Dir.exist?("/sabnzbd")}
end

ruby_block 'sabnzbdSettings' do
  block do
    if ::File.exist("/sabnzbd/sabnzbd.ini")
      bash 'copySettings' do
        code <<-EOH
          cp -Rf /sabnzbd /mnt/config/sabnzbd
          EOH
      end
    else
      bash 'copySettings' do
        code <<-EOH
          cp -Rf /mnt/config/sabnzbd /sabnzbd
          EOH
      end
    end
  end
  action :run
end
