#
# Cookbook:: media_configuration
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'docker_configuration::default'
include_recipe 'media_configuration::mounts'
include_recipe 'media_configuration::images'
include_recipe 'media_configuration::containers'
