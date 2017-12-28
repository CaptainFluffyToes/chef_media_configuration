name 'media_configuration'
maintainer 'Darren Khan'
maintainer_email 'djkhan85@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures media_configuration'
long_description 'Installs/Configures media_configuration'
version '0.2.3'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/CaptainFluffyToes/media_configuration/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/CaptainFluffyToes/media_configuration'

# Changelog
# [10/13/2017] - 0.1.1 - Added setup.rb and put in the mount directory and bind instructions.
# [10/13/2017] - 0.1.2 - Updated git ignore file.
# [10/13/2017] - 0.1.3 - Changed the mount call by removing the windows only commands.
# [10/13/2017] - 0.1.4 - Added new mount for configuration files. 
# [10/15/2017] - 0.1.5 - Updated help information and added cookbook dependency.  Added test image to be pulled from the docker hub.
# [10/15/2017] - 0.1.6 - Added SABnzbD, PlexPy, Sonarr, and Couchpotato to cookbook image pull
# [10/15/2017] - 0.1.7 - Added container creation for SABnzbD, sonarr, couchpotato, and plexpy
# [10/16/2017] - 0.1.8 - Added docker installation
# [10/16/2017] - 0.1.9 - Removed docker installation
# [10/16/2017] - 0.1.10 - Added in my own image for plex
# [10/16/2017] - 0.1.11 - Added CIFS installation to this recipe
# [10/16/2017] - 0.1.12 - Removed plex container since it wasn't working
# [10/22/2017] - 0.1.13 - Updated mount points on system for temp transcode directory
# [10/25/2017] - 0.2.0 - Changed the recipe configuration and broke out individual items to their own recipe file
# [12/28/2017] - 0.2.1 - Start using the official plex container
# [12/28/2017] - 0.2.2 - Added transcode directory to plex container
# [12/28/2017] - 0.2.3 - Updated name for the plex image

depends 'docker_configuration'
