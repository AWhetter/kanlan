class DevController < ApplicationController
  def sha
    wd = File.absolute_path( Dir.getwd() )
    Dir.chdir(File.dirname(__FILE__))
    result = `git log --name-status HEAD^..HEAD`
    Dir.chdir(wd)
    render :text => result.gsub("\n", '<br>').html_safe
  end
end
